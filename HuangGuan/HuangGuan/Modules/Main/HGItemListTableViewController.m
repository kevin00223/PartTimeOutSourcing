//
//  HGItemListTableViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGItemListTableViewController.h"
#import "HGItemCell.h"
#import "HGItemDetailsTableViewController.h"

@interface HGItemListTableViewController ()

@end

@implementation HGItemListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"itemCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HGItemCell" bundle:nil] forCellReuseIdentifier:@"itemCell"];
    self.tableView.tableFooterView = [UIView new];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    cell.itemModel = self.data[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HGItemDetailsTableViewController *detailVC = [[HGItemDetailsTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
    HGItemModel *model = self.data[indexPath.row];
    detailVC.topImageStr = model.itemImage;
    [self.navigationController pushViewController:detailVC animated:YES];
}

@end
