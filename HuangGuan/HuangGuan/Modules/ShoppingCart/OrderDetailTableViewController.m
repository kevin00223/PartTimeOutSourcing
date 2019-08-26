//
//  OrderDetailTableViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "OrderDetailTableViewController.h"
#import "HGOrderDetailFirstOneCell.h"
#import "HGOrderDetailSecondCell.h"
#import "HGOrderDetailThridCell.h"
#import "HGOrderDetailFourthCell.h"
#import "HGOrderDetailFinalCell.h"
#import "HGOrderDetailFifthCell.h"

@interface OrderDetailTableViewController ()

@end

@implementation OrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下单成功";
    
    UIBarButtonItem *confirmBtn = [UIBarButtonItem itemWithTitle:nil Image:@"back" target:self action:@selector(backBtnClick)];
    self.navigationItem.leftBarButtonItem = confirmBtn;
}

- (void)backBtnClick {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return self.orderData.itemArr.count;
            break;
        case 3:
            return 1;
            break;
        case 4:
            return 1;
            break;
        case 5:
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
            switch (indexPath.row) {
                case 0: {
                    HGOrderDetailFirstOneCell *firstOneCell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailFirstOneCell" owner:self options:nil].firstObject;
                    firstOneCell.order = self.orderData;
                    cell = firstOneCell;
                }
                    break;
                case 1: {
                    cell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailFirstTwoCell" owner:self options:nil].firstObject;
                }
                    break;
                default:
                    break;
            }
        }
            break;
        case 1: {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailSecondCell" owner:self options:nil].firstObject;
        }
            break;
        case 2: {
             HGOrderDetailThridCell *thirdCell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailThridCell" owner:self options:nil].firstObject;
            thirdCell.item = self.orderData.itemArr[indexPath.row];
            cell = thirdCell;
        }
            break;
        case 3: {
            cell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailFourthCell" owner:self options:nil].firstObject;
        }
            break;
        case 4: {
            HGOrderDetailFifthCell *fifthCell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailFifthCell" owner:self options:nil].firstObject;
            fifthCell.order = self.orderData;
            cell = fifthCell;
        }
            break;
        case 5: {
            HGOrderDetailFinalCell *finalCell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailFinalCell" owner:self options:nil].firstObject;
            finalCell.order = self.orderData;
            cell = finalCell;
        }
            break;
        default:
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            switch (indexPath.row) {
                case 0:
                    return 70;
                    break;
                case 1:
                    return 166;
                    break;
                default:
                    return 0;
                    break;
            }
            break;
        case 1:
            return 40;
            break;
        case 2:
            return 110;
            break;
        case 3:
            return 80;
            break;
        case 4:
            return 50;
            break;
        case 5:
            return 175;
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
    if (section == 1 || section == 2) {
        return 0;
    }else{
        return 10;
    }
}


@end
