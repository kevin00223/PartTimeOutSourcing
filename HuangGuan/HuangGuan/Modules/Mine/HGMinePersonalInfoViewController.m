//
//  HGMinePersonalInfoViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMinePersonalInfoViewController.h"

@interface HGMinePersonalInfoViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;

@property (nonatomic, strong) UIButton *logoutButton;


@end

@implementation HGMinePersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initValues];
}

- (void)initValues {
    self.title = @"我的信息";
    
    self.nameTextField.text = [JHUserDefaults shareInstance].name;
    self.phoneTextField.text = [JHUserDefaults shareInstance].mobile;
    NSString *avatarStr = [JHUserDefaults shareInstance].avatarUrl;
    self.avatarImage.image = [avatarStr isNotBlank] ? [UIImage imageNamed:avatarStr] : [UIImage imageNamed:@"personalInfoIcon"];
    
    UIBarButtonItem *confirmBtn = [UIBarButtonItem itemWithTitle:@"确定" Image:nil target:self action:@selector(confirmBtnClick)];
    self.navigationItem.rightBarButtonItem = confirmBtn;
    
    self.tableView.tableFooterView = self.logoutButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return kScreenHeight - kStatusBarAndNavigationBarHeight - 44 - 210;
}

- (void)confirmBtnClick {
    [self toDoAnythingWithInternet:^{
        bg_executeSql([NSString stringWithFormat:@"update accountDB set BG_mobile = '%@', BG_name = '%@' where BG_mobile = '%@'",self.phoneTextField.text,self.nameTextField.text,[JHUserDefaults shareInstance].mobile], nil, nil);
        [[JHUserDefaults shareInstance] updateMember:self.nameTextField.text];
        [[JHUserDefaults shareInstance] resetMobile:self.phoneTextField.text];
        [self.navigationController popViewControllerAnimated:YES];
        [MBProgressHUD showSuccess:@"修改成功"];
    } isShowHud:YES];
}

- (void)logoutButtonClicked: (UIButton *)button {
    [self toDoAnythingWithInternet:^{
        self.tabBarController.selectedIndex = 0;
        [[JHUserDefaults shareInstance] loginOut];
        [self.navigationController popViewControllerAnimated:YES];
    } isShowHud:YES];
}


- (UIButton *)logoutButton {
    if (!_logoutButton) {
        _logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_logoutButton setFrame:CGRectMake(0, 0, kScreenWidth, 44)];
        [_logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_logoutButton setBackgroundColor:HGHexColor(0xEB5266)];
        [_logoutButton addTarget:self action:@selector(logoutButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _logoutButton;
}

@end
