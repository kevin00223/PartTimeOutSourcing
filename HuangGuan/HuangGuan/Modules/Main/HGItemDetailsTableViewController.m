//
//  HGItemDetailsTableViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGItemDetailsTableViewController.h"
#import "HGDeitalFirstCell.h"
#import "HGShopCarModel.h"
#import "ShopCarDataTool.h"
#import "Order.h"
#import "HGAddressModel.h"

@interface HGItemDetailsTableViewController ()

@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIView *bottomContainView;
@property (nonatomic, strong) UIButton *addToCartButton;
@property (nonatomic, strong) UIButton *buyButton;

@end

@implementation HGItemDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"detailCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HGDetailFirstCell" bundle:nil] forCellReuseIdentifier:@"detailFirst"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HGDetailSecondCell" bundle:nil] forCellReuseIdentifier:@"detailSecond"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HGDetailSecondSecondCell" bundle:nil] forCellReuseIdentifier:@"detailSecondSecond"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HGDetailThridCell" bundle:nil] forCellReuseIdentifier:@"detailThrid"];
    self.tableView.tableHeaderView = self.topView;
    [[UIApplication sharedApplication].keyWindow addSubview:self.bottomContainView];
    [self.bottomContainView addSubview:self.addToCartButton];
    [self.bottomContainView addSubview:self.buyButton];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.bottomContainView setHidden:YES];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.bottomContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.offset(44);
    }];
    
    [self.addToCartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.bottomContainView);
        make.width.offset(kScreenWidth * 0.5);
    }];
    
    [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self.bottomContainView);
        make.width.offset(kScreenWidth * 0.5);
    }];
}

- (void)setTopImageStr:(NSString *)topImageStr {
    _topImageStr = topImageStr;
    
    self.topView.image = [UIImage imageNamed:topImageStr];
}

- (void)addToCartButtonClicked: (UIButton *)button {
    NSString *str = [self.detailModel modelToJSONString];
    HGShopCarModel *item = [HGShopCarModel modelWithJSON:str];
    [self toDoAnythingWithInternet:^{
        [[ShopCarDataTool sharedManger] addToShopCar:item];
        [MBProgressHUD showSuccess:@"添加至购物车"];
    } isShowHud:NO];
}

- (void)buyButtonClicked: (UIButton *)button {
    [self loginRequest];
    if ([JHUserDefaults shareInstance].mobile) {
        Order *order = [[Order alloc] init];
        NSString* where = [NSString stringWithFormat:@"where %@=%@ and %@ = %@",bg_sqlKey(@"userMobile"),bg_sqlValue([JHUserDefaults shareInstance].mobile),bg_sqlKey(@"isDefault"),bg_sqlValue(@(1))];
        order.address = [HGAddressModel bg_find:@"addressDB" where:where].firstObject;
        NSString *itemStr = [_detailModel modelToJSONString];
        HGShopCarModel *item = [HGShopCarModel modelWithJSON:itemStr];
        item.shopCarCount = 1;
        order.itemArr = @[item];
        order.totalAmount = item.itemPrice;
        order.account = @{@"name":[JHUserDefaults shareInstance].name,@"mobile":[JHUserDefaults shareInstance].mobile};
        
        
        [self toDoAnythingWithInternet:^{
//            UIStoryboard *sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//            ConfirmOrderViewController *confirmOrderVC = [sb instantiateViewControllerWithIdentifier:@"confirmOrderVC"];
//            confirmOrderVC.orderData = order;
//            [self.navigationController pushViewController:confirmOrderVC animated:YES];
        } isShowHud:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.section) {
        case 0: {
            HGDeitalFirstCell *firstCell = [[NSBundle mainBundle] loadNibNamed:@"HGDeitalFirstCell" owner:self options:nil].firstObject;
            firstCell.cellModel = self.detailModel;
            cell = firstCell;
        }
            break;
        case 1:
            if (indexPath.row == 0) {
                cell = [[NSBundle mainBundle] loadNibNamed:@"HGDetailSecondCell" owner:self options:nil].firstObject;
            }else{
                cell = [[NSBundle mainBundle] loadNibNamed:@"HGDetailSecondSecondCell" owner:self options:nil].firstObject;
            }
            break;
        case 2:
            cell = [[NSBundle mainBundle] loadNibNamed:@"HGDetailThirdCell" owner:self options:nil].firstObject;
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 70;
            break;
        case 1:
            return 50;
            break;
        case 2:
            return 440;
            break;
        default:
            return 0;
            break;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [[UIView alloc]init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}

#pragma mark - lazy loading
- (UIImageView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 300)];
    }
    return _topView;
}

- (UIView *)bottomContainView {
    if (!_bottomContainView) {
        _bottomContainView = [[UIView alloc]init];
        _bottomContainView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomContainView;
}

- (UIButton *)addToCartButton {
    if (!_addToCartButton) {
        _addToCartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addToCartButton setBackgroundImage:[UIImage imageNamed:@"addToCartButton"] forState:UIControlStateNormal];
        [_addToCartButton addTarget:self action:@selector(addToCartButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addToCartButton;
}

- (UIButton *)buyButton {
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buyButton setBackgroundImage:[UIImage imageNamed:@"buyButton"] forState:UIControlStateNormal];
        [_buyButton addTarget:self action:@selector(buyButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _buyButton;
}

@end
