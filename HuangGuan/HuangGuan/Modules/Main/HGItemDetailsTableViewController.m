//
//  HGItemDetailsTableViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGItemDetailsTableViewController.h"

@interface HGItemDetailsTableViewController ()

@property (nonatomic, strong) UIImageView *topView;

@end

@implementation HGItemDetailsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商品详情";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"detailCell"];
    self.tableView.tableHeaderView = self.topView;
}

- (void)setTopImageStr:(NSString *)topImageStr {
    _topImageStr = topImageStr;
    
    self.topView.image = [UIImage imageNamed:topImageStr];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell" forIndexPath:indexPath];
    cell.textLabel.text = @"tt";
    return cell;
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

@end
