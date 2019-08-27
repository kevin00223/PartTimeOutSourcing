//
//  HGMainViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMainViewController.h"
#import "FXCustomizeButton.h"
#import "UIButton+HGCustomButton.h"
#import "HGMainTableViewCell.h"
#import "HGItemListTableViewController.h"
#import "HGItemModel.h"
#import "HGItemDetailsTableViewController.h"
#import <MJRefresh/MJRefresh.h>

@interface HGMainViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *topContainerView;
@property (nonatomic, strong) UIView *topBackgroundView;
@property (nonatomic, strong) UIView *buttonsBackgroundView;
@property (nonatomic, strong) UIImageView *topImageView;

@property (nonatomic, strong) UIView *promotionView;
@property (nonatomic, strong) UIImageView *promotionImage;
@property (nonatomic, strong) UILabel *promotionLabel;

@property (nonatomic, strong) NSArray *buttons;

@property (nonatomic, strong) NSArray *goodsDataSource;\

@property (nonatomic, strong) NSArray *itemListArray;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation HGMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"首页";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.topContainerView;
    [self.topContainerView addSubview:self.topBackgroundView];
    [self.topBackgroundView addSubview:self.topImageView];
    [self.topBackgroundView addSubview:self.buttonsBackgroundView];
    [self.topContainerView addSubview:self.promotionView];
    [self.promotionView addSubview:self.promotionImage];
    [self.promotionView addSubview:self.promotionLabel];
    
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.topBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.topContainerView);
        make.height.offset(290);
    }];
    
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.topBackgroundView).offset(5);
        make.right.equalTo(self.topBackgroundView).offset(-5);
    }];
    
    [self.buttonsBackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.topBackgroundView);
        make.top.equalTo(self.topImageView.mas_bottom).offset(5);
        make.bottom.equalTo(self.topBackgroundView).offset(-5);
    }];
    
    [self.promotionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topContainerView).offset(15);
        make.right.equalTo(self.topContainerView).offset(-15);
        make.top.equalTo(self.topBackgroundView.mas_bottom).offset(10);
        make.bottom.equalTo(self.topContainerView).offset(-10);
    }];
    
    [self.promotionImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.promotionView).offset(15);
        make.centerY.equalTo(self.promotionView);
    }];
    
    [self.promotionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.promotionImage.mas_right).offset(10);
        make.centerY.equalTo(self.promotionView);
    }];
}

- (void)btnClicked: (UIButton *)button {
    HGItemListTableViewController *vc = [[HGItemListTableViewController alloc]initWithStyle:UITableViewStylePlain];
    vc.title = self.titleArray[button.tag];
    vc.data = self.itemListArray[button.tag];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)loadData {
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //刷新列表
        [weakSelf.tableView reloadData];
        //拿到当前的刷新控件，结束刷新状态
        [weakSelf.tableView.mj_header endRefreshing];
    });
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGMainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.dataSourceDic = self.goodsDataSource[indexPath.section];
    cell.cellTag = indexPath.section;
    cell.itemDidClick = ^(HGItemModel * _Nonnull item) {
        HGItemDetailsTableViewController *vc = [[HGItemDetailsTableViewController alloc]initWithStyle:UITableViewStyleGrouped];
        vc.topImageStr = item.itemImage;
        vc.detailModel = item;
        [self.navigationController pushViewController:vc animated:YES];
    };
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 260;
}

#pragma mark - lazy loading
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_tableView registerNib:[UINib nibWithNibName:@"HGMainTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellID"];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIView *)topContainerView {
    if (!_topContainerView) {
        _topContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 350)];
        _topContainerView.backgroundColor = HGHexColor(0xEFEFF4);
    }
    return _topContainerView;
}

- (UIView *)topBackgroundView {
    if (!_topBackgroundView) {
        _topBackgroundView = [[UIView alloc]init];
        _topBackgroundView.backgroundColor = [UIColor whiteColor];
    }
    return _topBackgroundView;
}

- (UIImageView *)topImageView {
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_topView"]];
    }
    return _topImageView;
}

- (UIView *)buttonsBackgroundView {
    if (!_buttonsBackgroundView) {
        _buttonsBackgroundView = [[UIView alloc] init];
        _buttonsBackgroundView.backgroundColor = [UIColor whiteColor];
        
        int width = 50;
        int height = 62;
        int space = (kScreenWidth - 5 * width) / 6;
        int y = 10;
        
        for (int i = 0; i < self.buttons.count; i ++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setFrame:CGRectMake(i * width + (i+1) * space, y, width, height)];
            NSString *title = self.buttons[i][@"title"];
            NSString *image = self.buttons[i][@"image"];
            [btn setTitle:title forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:12];
            [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
            [btn verticalImageAndTitle:10];
            btn.tag = i;
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
            [_buttonsBackgroundView addSubview:btn];
        }
    }
    return _buttonsBackgroundView;
}

- (NSArray *)buttons {
    if (!_buttons) {
        _buttons = @[
                     @{@"image": @"被子被芯", @"title": @"被子被芯"},
                     @{@"image": @"枕头枕芯", @"title": @"枕头枕芯"},
                     @{@"image": @"床垫褥子", @"title": @"床垫褥子"},
                     @{@"image": @"床品套件", @"title": @"床品套件"},
                     @{@"image": @"夏凉用品", @"title": @"夏凉用品"}
                     ];
    }
    return _buttons;
}

- (UIView *)promotionView {
    if (!_promotionView) {
        _promotionView = [[UIView alloc]initWithFrame:CGRectZero];
        _promotionView.layer.cornerRadius = 20;
        _promotionView.layer.masksToBounds = YES;
        _promotionView.backgroundColor = [UIColor whiteColor];
    }
    return _promotionView;
}

- (UIImageView *)promotionImage {
    if (!_promotionImage) {
        _promotionImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"家纺头条"]];
    }
    return _promotionImage;
}

- (UILabel *)promotionLabel {
    if (!_promotionLabel) {
        _promotionLabel = [[UILabel alloc]init];
        _promotionLabel.text = @"7/28-7/29 酬宾大促销 全场满199元减99元。";
        _promotionLabel.font = [UIFont systemFontOfSize:11];
    }
    return _promotionLabel;
}

- (NSArray *)goodsDataSource {
    if (!_goodsDataSource) {
        _goodsDataSource = @[
                             @{
                                 @"title" : @"热销产品",
                                 @"subTitle" : @"热销榜单·不容错过",
                                 @"goods" : @[self.itemListArray[0][0], self.itemListArray[1][0], self.itemListArray[2][0]
                                         ]
                                 
                                },
                             @{
                                 @"title" : @"最新产品",
                                 @"subTitle" : @"最新产品·尝新低价",
                                 @"goods" : @[self.itemListArray[3][0], self.itemListArray[4][1], self.itemListArray[2][3]
                                         ]
                                 
                                 },
                             ];
    }
    return _goodsDataSource;
}

- (NSArray *)itemListArray {
    if (!_itemListArray) {
        _itemListArray = [HGItemModel messageModelWithPlistName:@"Item.plist"];
    }
    return _itemListArray;
}

- (NSArray *)titleArray {
    if (!_titleArray) {
        _titleArray = @[
                        @"被子被芯",
                        @"枕套枕芯",
                        @"床垫褥子",
                        @"床品套件",
                        @"夏凉用品"
                        ];
    }
    return _titleArray;
}

@end
