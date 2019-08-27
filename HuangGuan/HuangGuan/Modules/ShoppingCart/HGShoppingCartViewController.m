//
//  HGShoppingCartViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGShoppingCartViewController.h"
#import "Order.h"
#import "HGAddressModel.h"
#import "HGShopCarModel.h"
#import "HGShopCartCell.h"
#import "HGItemModel.h"
#import "ShopCarDataTool.h"
#import "HGConfirmOrderViewController.h"

@interface HGShoppingCartViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
@property (weak, nonatomic) IBOutlet UILabel *totalAmount;

@property (nonatomic, strong) NSMutableArray *shopCarArr;
@property (nonatomic, strong) NSMutableArray *selectArr;

@end

@implementation HGShoppingCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"购物车";
    [self setupTableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)setupTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 1;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_tableView registerNib:[UINib nibWithNibName:@"HGShopCartCell" bundle:nil] forCellReuseIdentifier:@"shopCartCell"];
    self.tableView.ly_emptyView = [CustomizeEmptyView diyNoDataEmpty];
}

- (void)loadData {
    _shopCarArr = [[ShopCarDataTool sharedManger] queryShopCar];
    _selectArr = [[ShopCarDataTool sharedManger] querySelectItem];
    if (_shopCarArr.count == 0) {
        _allSelectButton.selected = NO;
    }else if (_selectArr.count == _shopCarArr.count) {
        _allSelectButton.selected = YES;
    } else {
        _allSelectButton.selected = NO;
    }
    [self.tableView reloadData];
}

- (IBAction)allSelectButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (self.selectArr.count != self.shopCarArr.count) {
        [self.selectArr removeAllObjects];
        [self.selectArr addObjectsFromArray:self.shopCarArr];
        [self.selectArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ((HGShopCarModel *)obj).isSelect = YES;
        }];
    } else {
        
        [self.shopCarArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            ((HGShopCarModel *)obj).isSelect = NO;
        }];
        [self.selectArr removeAllObjects];
    }
    [self.tableView reloadData];
}

- (IBAction)balanceButtonClicked:(UIButton *)sender {
    [self loginRequest];
    if ([[JHUserDefaults shareInstance].mobile isNotBlank]) {
        
        if (_selectArr.count == 0) {
            [MBProgressHUD showError:@"请至少选择一个商品"];
            return;
        }
        Order *order = [[Order alloc] init];
        NSString* where = [NSString stringWithFormat:@"where %@=%@ and %@ = %@",bg_sqlKey(@"userMobile"),bg_sqlValue([JHUserDefaults shareInstance].mobile),bg_sqlKey(@"isDefault"),bg_sqlValue(@(1))];
        order.address = [HGAddressModel bg_find:@"addressDB" where:where].firstObject;
        order.itemArr = _selectArr;
        order.totalAmount = _totalAmount.text;
        order.account = @{@"name":[JHUserDefaults shareInstance].name,@"mobile":[JHUserDefaults shareInstance].mobile};
        
        
        [self toDoAnythingWithInternet:^{
            HGConfirmOrderViewController *vc = [[HGConfirmOrderViewController alloc]init];
            vc.orderData = order;
            vc.isFromShopCar = YES;
            [self.navigationController pushViewController:vc animated:YES];
        } isShowHud:YES];
    }
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSMutableAttributedString *sign = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%lu件商品,合计:",(unsigned long)_selectArr.count] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13]}];
    
    CGFloat total = 0.0;
    for (HGShopCarModel *item in _selectArr) {
        total += (item.shopCarCount * [[item.itemPrice substringFromIndex:1] doubleValue]);
    }
    
    NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"¥ %.2f",total] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 16]}];
    [sign appendAttributedString:amountStr];
    self.totalAmount.attributedText = sign;
    return _shopCarArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:@"shopCartCell" forIndexPath:indexPath];
    HGShopCarModel *item = _shopCarArr[indexPath.section];
    cell.shopCarItem = item;
    for (HGShopCarModel *tempitem in _selectArr) {
        if (item.Id == tempitem.Id ) {
            item.isSelect = YES;
        }
    }
    cell.select = item.isSelect;
    cell.addBlock = ^(HGItemModel * _Nonnull item) {
        [[ShopCarDataTool sharedManger] addToShopCar:(HGShopCarModel *)item];
        [self loadData];
    };
    cell.substructBlock = ^(HGItemModel * _Nonnull item) {
        [[ShopCarDataTool sharedManger] substractToShopCar:(HGShopCarModel *)item];
        [self loadData];
    };
    
    cell.selectBlock = ^(BOOL select) {
        if (select) {
            [[ShopCarDataTool sharedManger] selectItem:item select:YES];
        } else {
            [[ShopCarDataTool sharedManger] selectItem:item select:NO];
        }
        [self loadData];
    };
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HGShopCarModel *item = _shopCarArr[indexPath.section];
//    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//
//    ItemDetailViewController *itemDetailVC = [sb instantiateViewControllerWithIdentifier:@"itemDetailVC"];
//    itemDetailVC.item = item;
//    [self.navigationController pushViewController:itemDetailVC animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 125;
}


#pragma mark - lazy loading
- (NSMutableArray *)selectArr {
    if (!_selectArr) {
        _selectArr = [NSMutableArray arrayWithCapacity:0];
    }
    return _selectArr;
}

@end
