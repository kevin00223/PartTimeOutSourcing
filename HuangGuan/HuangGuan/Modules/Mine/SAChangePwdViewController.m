//
//  SAChangePwdViewController.m
//  ShouAn
//
//  Created by 李凯 on 2019/6/12.
//  Copyright © 2019 LK. All rights reserved.
//

#import "SAChangePwdViewController.h"

@interface SAChangePwdViewController ()

@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, strong) UIView *bottomContainerView;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *updatedPwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmNewPwdTextField;

@end

@implementation SAChangePwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initValues];
    [self initSubviews];
}

- (void)initValues {
    self.title = @"修改密码";
}

- (void)initSubviews {
    self.tableView.tableFooterView = self.bottomContainerView;
    [self.bottomContainerView addSubview:self.confirmButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.bottomContainerView);
        make.height.offset(45);
        make.width.offset(200);
        make.bottom.equalTo(self.bottomContainerView);
    }];
}

- (void)saveButtonClicked: (UIButton *)confirmButton {
    if (![self.updatedPwdTextField.text isEqualToString:self.confirmNewPwdTextField.text]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码不一致, 请重新输入" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"密码修改成功!" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//            SANavigationController *loginNav = [[SANavigationController alloc]initWithRootViewController:[[SALoginViewController alloc] init]];
//            [UIApplication sharedApplication].delegate.window.rootViewController = loginNav;
        }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:self.confirmNewPwdTextField.text forKey:@"password"];
    }
}

#pragma mark - lazy loading

- (UIButton *)confirmButton {
    if (!_confirmButton) {
        _confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _confirmButton.layer.cornerRadius = 22.0;
//        _confirmButton.layer.masksToBounds = YES;
//        [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
//        [_confirmButton setBackgroundColor:[UIColor redColor]];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"savePsd"] forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(saveButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

- (UIView *)bottomContainerView {
    if (!_bottomContainerView) {
        _bottomContainerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 130)];
    }
    return _bottomContainerView;
}

@end
