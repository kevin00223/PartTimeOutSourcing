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
#import "HGOrderDetailThirdCell.h"

@interface OrderDetailTableViewController ()

@end

@implementation OrderDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"下单成功";
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
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
            HGOrderDetailSecondCell *secondCell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailSecondCell" owner:self options:nil].firstObject;
            cell = secondCell;
        }
            break;
        case 2: {
            HGOrderDetailThirdCell *thirdCell = [[NSBundle mainBundle] loadNibNamed:@"HGOrderDetailThirdCell" owner:self options:nil].firstObject;
            cell = thirdCell;
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
            return 230;
            break;
        case 2:
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
