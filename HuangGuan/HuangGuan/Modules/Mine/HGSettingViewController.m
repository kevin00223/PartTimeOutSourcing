//
//  HGSettingViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGSettingViewController.h"
#import "HGMineSettingCell.h"
#import "SAChangePwdViewController.h"

static NSString *settingCellID = @"cellID";

@interface HGSettingViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UIButton *logoutButton;

@end

@implementation HGSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self initSubviews];
}

- (void)initSubviews {
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.logoutButton];
    [self.tableView setTableFooterView:[UIView new]];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.offset(kScreenHeight-50);
    }];
    
    [self.logoutButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.offset(50);
    }];
}

- (void)logoutButtonClicked: (UIButton *)button {
    NSLog(@"点击退出登录");
}

#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGMineSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:settingCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        // 修改密码
        UIStoryboard *board = [UIStoryboard storyboardWithName:@"SAChangePwd" bundle:nil];
        SAChangePwdViewController *vc = [board instantiateViewControllerWithIdentifier:@"changePwd"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]init];
        [_tableView setScrollEnabled:NO];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = HGHexColor(0xEEEEEE);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[HGMineSettingCell class] forCellReuseIdentifier:settingCellID];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[@"修改密码", @"注销账号"];
    }
    return _dataSource;
}

- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setBackgroundColor:HGHexColor(0xEB5266)];
        [_logoutButton addTarget:self action:@selector(logoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

@end
