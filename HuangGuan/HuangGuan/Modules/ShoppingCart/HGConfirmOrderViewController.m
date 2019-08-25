//
//  HGConfirmOrderViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGConfirmOrderViewController.h"
#import "HGShopCarModel.h"
#import "HGConfirmOrderFirstCell.h"
#import "HGConfirmOrderSecondCell.h"
#import "HGConfirmOrderThirdOneCell.h"
#import "HGConfirmOrderThirdTwoCell.h"
#import "HGConfirmOrderThirdThreeCell.h"
#import "HGConfirmOrderFourthCell.h"
#import "OrderDetailTableViewController.h"

@interface HGConfirmOrderViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsAmountLabel;

@property (nonatomic, assign) CGFloat itemTotal;
@property (nonatomic, assign) CGFloat deliveredTotal;

@end

@implementation HGConfirmOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"确认订单";
    [self setupTableView];
    _goodsAmountLabel.text = [NSString stringWithFormat:@"共%lu件商品",(unsigned long)_orderData.itemArr.count];
    
    
    _itemTotal = 0.00;
    for (HGShopCarModel *item in _orderData.itemArr) {
        _itemTotal += [[item.itemPrice substringFromIndex:1] doubleValue] * item.shopCarCount;
    }
    _moneyLabel.text = [NSString stringWithFormat:@"￥%.2f", _itemTotal];
    
    _deliveredTotal = _itemTotal;
//    [self changeTypeBtnClick:_sendBtn];
}

- (void)setupTableView {
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.estimatedRowHeight = 1;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.tableView.ly_emptyView = [CustomizeEmptyView diyNoDataEmpty];
}

- (IBAction)congfirmButtonClicked:(UIButton *)sender {
    
//    _orderData.note = self.noteStr;
//    WeakSelf;
    [self toDoAnythingWithInternet:^{
        OrderDetailTableViewController *orderDetailVC = [[OrderDetailTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
//        orderDetailVC.orderData = weakSelf.orderData;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
//        weakSelf.orderData.bg_tableName = @"orderDB";
//        [weakSelf.orderData bg_saveOrUpdate];
//        [EBBannerView showWithContent:@"下单成功"];
//        if (self.isFromShopCar) {
//            for (ShopCarItem *item in weakSelf.orderData.itemArr) {
//                [[ShopCarDataTool sharedManger] deteleRecord:item];
//            }
//        }
    } isShowHud:YES];
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return _orderData.itemArr.count;
            break;
        case 2:
            return 3;
            break;
        case 3:
            return 1;
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    CGFloat total = 0.00;
    for (HGShopCarModel *item in self.orderData.itemArr) {
        total += [[item.itemPrice substringFromIndex:1] doubleValue] * item.shopCarCount;
    }
    switch (indexPath.section) {
        case 0: {
            HGConfirmOrderFirstCell *firstCell = [[NSBundle mainBundle] loadNibNamed:@"HGConfirmOrderFirstCell" owner:self options:nil].firstObject;
            firstCell.orderData = self.orderData;
            cell = firstCell;
        }
            break;
        case 1: {
            HGConfirmOrderSecondCell *secondCell = [[NSBundle mainBundle] loadNibNamed:@"HGConfirmOrderSecondCell" owner:self options:nil].firstObject;
            secondCell.item = self.orderData.itemArr[indexPath.row];
            cell = secondCell;
        }
            break;
        case 2: {
            switch (indexPath.row) {
                case 0:
                    cell = [[NSBundle mainBundle] loadNibNamed:@"HGConfirmOrderThirdOneCell" owner:self options:nil].firstObject;
                    break;
                case 1:
                    cell = [[NSBundle mainBundle] loadNibNamed:@"HGConfirmOrderThirdTwoCell" owner:self options:nil].firstObject;
                    break;
                case 2: {
                    HGConfirmOrderThirdThreeCell *thirdThreecell = [[NSBundle mainBundle] loadNibNamed:@"HGConfirmOrderThirdThreeCell" owner:self options:nil].firstObject;
                    thirdThreecell.totalMoney.text = [NSString stringWithFormat:@"￥%.2f", total];
                    cell = thirdThreecell;
                }
                    break;
                default:
                    break;
            }
            break;
        }
        case 3: {
            HGConfirmOrderFourthCell *fourthCell = [[NSBundle mainBundle] loadNibNamed:@"HGConfirmOrderFourthCell" owner:self options:nil].firstObject;
            cell = fourthCell;
        }
            break;
        default:
            break;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            return 80;
            break;
        case 1:
            return 125;
            break;
        case 2:
            return 50;
            break;
        case 3:
            return 200;
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

@end
