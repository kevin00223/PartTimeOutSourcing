//
//  HGMineViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMineViewController.h"
#import "UIImage+GradientColor.h"
#import "HGMineCellModel.h"
#import "HGMineCell.h"
#import "HGFeedBackViewController.h"
#import "HGSettingViewController.h"

static NSString *mineCellID = @"mineCell";

@interface HGMineViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIImageView *topContainerView;
@property (nonatomic, strong) UIImageView *topIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subTitleLabel;
@property (nonatomic, strong) UIButton *editButton;

@property (nonatomic, copy) NSArray *dataSource;

@end

@implementation HGMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initSubviews];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)initSubviews {
    [self.view addSubview:self.tableView];
    [self.topContainerView addSubview:self.topIcon];
    [self.topContainerView addSubview:self.titleLabel];
    [self.topContainerView addSubview:self.subTitleLabel];
    [self.topContainerView addSubview:self.editButton];
    self.tableView.tableHeaderView = self.topContainerView;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.topIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topContainerView);
        make.top.equalTo(self.topContainerView).offset(65);
        make.width.height.offset(70);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topContainerView);
        make.top.equalTo(self.topIcon.mas_bottom).offset(15);
    }];
    
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.width.height.offset(16);
    }];
    
    [self.subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.topContainerView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
    }];
}

#pragma mark - tableview datasource / delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGMineCell *cell = [tableView dequeueReusableCellWithIdentifier:mineCellID forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.mineCellModel = self.dataSource[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0: {
            NSLog(@"地址");
        }
            break;
        case 1: {
            // 反馈
            [self.navigationController pushViewController:[HGFeedBackViewController new] animated:YES];
        }
            break;
        case 2:
            NSLog(@"版本更新");
            break;
        case 3:
            NSLog(@"清除缓存");
            break;
        case 4:
            // 设置
            [self.navigationController pushViewController:[HGSettingViewController new] animated:YES];
        default:
            break;
    }
}

#pragma mark - lazy loading

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = HGHexColor(0xEEEEEE);
        [_tableView registerClass:[HGMineCell class] forCellReuseIdentifier:mineCellID];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}

- (UIImageView *)topContainerView {
    if (!_topContainerView) {
        _topContainerView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
        UIColor *startColor = HGHexColor(0xEC6A2E);
        UIColor *endColor = HGHexColor(0xEB5266);
        _topContainerView.image = [UIImage gradientColorImageFromColors:@[startColor,endColor] gradientType:GradientTypeUpleftToLowright imgSize:CGSizeMake(kScreenWidth, 250)];
    }
    return _topContainerView;
}

- (UIImageView *)topIcon {
    if (!_topIcon) {
        _topIcon = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_icon"]];
    }
    return _topIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.text = @"SYangn花卷";
        _titleLabel.textColor = [UIColor whiteColor];
        [_titleLabel sizeToFit];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:18];
    }
    return _titleLabel;
}

- (UILabel *)subTitleLabel {
    if (!_subTitleLabel) {
        _subTitleLabel = [[UILabel alloc]init];
        _subTitleLabel.text = @"15010695466";
        _subTitleLabel.textColor = [UIColor whiteColor];
        [_subTitleLabel sizeToFit];
        _subTitleLabel.textAlignment = NSTextAlignmentCenter;
        _subTitleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _subTitleLabel;
}

- (UIButton *)editButton {
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setImage:[UIImage imageNamed:@"mine_edit"] forState:UIControlStateNormal];
    }
    return _editButton;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [HGMineCellModel mineCellModelWithPlistName:@"MineCell.plist"];
    }
    return _dataSource;
}

@end
