//
//  HGMineAddressTableViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMineAddressTableViewController.h"
#import "HGMineEditAddressTableViewController.h"
#import "AddressTableViewCell.h"

@interface HGMineAddressTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataArr;

@end

@implementation HGMineAddressTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"我的地址";
    
    [self setupTableView];
    
    UIBarButtonItem *confirmBtn = [UIBarButtonItem itemWithTitle:@"添加地址" Image:nil target:self action:@selector(addAddressBtnClick)];
    self.navigationItem.rightBarButtonItem = confirmBtn;
}

- (void)addAddressBtnClick {
    UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HGMineEditAddress" bundle:nil];
    HGMineEditAddressTableViewController *editAddressVC = [sb instantiateViewControllerWithIdentifier:@"editAddress"];
    [self.navigationController pushViewController:editAddressVC animated:YES];
}

- (void)setupTableView {
    self.tableView.ly_emptyView = [CustomizeEmptyView diyNoDataEmpty];
    self.tableView.tableFooterView = [UIView new];
}

- (void)loadData {
    _dataArr = nil;
    JHUserDefaults *userD = [JHUserDefaults shareInstance];
    if ([userD.mobile isNotBlank]) {
        _dataArr = [[HGAddressModel bg_findAll:@"addressDB"] mutableCopy];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressTableViewCell *cell = [AddressTableViewCell addressCellWith:tableView index:0];
    cell.detaiAddress = _dataArr[indexPath.section];
    cell.editBlock = ^(HGAddressModel * _Nonnull address) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HGMineEditAddress" bundle:nil];
        HGMineEditAddressTableViewController *editAddressVC = [sb instantiateViewControllerWithIdentifier:@"editAddress"];
        editAddressVC.addressData = self.dataArr[indexPath.section];
        editAddressVC.addressType = EditAddressTypeEdit;
        [self.navigationController pushViewController:editAddressVC animated:YES];
    };
    return cell;
}

@end
