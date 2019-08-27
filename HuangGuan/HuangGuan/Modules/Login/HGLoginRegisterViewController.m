//
//  HGLoginRegisterViewController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGLoginRegisterViewController.h"
#import "HGAccountModel.h"
#import "HGTabBarController.h"
#import "HGAddressModel.h"

@interface HGLoginRegisterViewController ()

@property (weak, nonatomic) IBOutlet UITextField *loginPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *loginPsdTextField;

@property (weak, nonatomic) IBOutlet UITextField *registerPhoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerPsdTextField;
@property (weak, nonatomic) IBOutlet UITextField *registerAgainPsdTextField;



@end

@implementation HGLoginRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.loginPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.registerPhoneTextField.keyboardType = UIKeyboardTypeNumberPad;
    
    self.loginPsdTextField.secureTextEntry = YES;
    self.registerPsdTextField.secureTextEntry = YES;
    self.registerAgainPsdTextField.secureTextEntry = YES;
}

- (IBAction)loginButtonClicked:(UIButton *)sender {
    if (![self.loginPhoneTextField.text isNotBlank] || ![self.loginPsdTextField.text isNotBlank]) {
        [MBProgressHUD showError:@"请输入账号和密码"];
        return;
    }
    NSString *where = [NSString stringWithFormat:@"where %@ = %@",bg_sqlKey(@"mobile"),bg_sqlValue(self.loginPhoneTextField.text)];
    
    NSArray *arr = [HGAccountModel bg_find:@"accountDB" where:where];
    
    if (arr.count == 0) {
        [MBProgressHUD showError:@"账号不存在"];
        return;
    }
    
    HGAccountModel *account = arr.firstObject;
    
    if (![account.mobile isEqualToString:@"15101070703"]) {
        [HGAddressModel bg_drop:@"addressDB"];
    }
    
    
//    WeakSelf;
    [self toDoAnythingWithInternet:^{
        if ([account.password isEqualToString:self.loginPsdTextField.text]) {
            [[JHUserDefaults shareInstance] resetMobile:account.mobile];
            [[JHUserDefaults shareInstance] updateMember:account.name];
            if ([account.avatarImg isNotBlank]) {
                [[JHUserDefaults shareInstance] changeAvatar:account.avatarImg];
            }
            [self dismissViewControllerAnimated:YES completion:nil];
            
        } else {
            [MBProgressHUD showError:@"密码错误"];
        }
    } isShowHud:YES];
}


- (IBAction)registerButtonClicked:(UIButton *)sender {
    if (![self.registerPhoneTextField.text isNotBlank] || ![self.registerPsdTextField.text isNotBlank] || ![self.registerAgainPsdTextField.text isNotBlank]) {
        [MBProgressHUD showError:@"请输入账号和密码"];
        return;
    }
    
    if (![self.registerPsdTextField.text isEqualToString:self.registerAgainPsdTextField.text]) {
        [MBProgressHUD showError:@"两次密码不相同"];
        return;
    }
    
    [self toDoAnythingWithInternet:^{
        NSString *where = [NSString stringWithFormat:@"where %@ = %@",bg_sqlKey(@"mobile"),bg_sqlValue(self.registerPhoneTextField.text)];
        
        NSArray *arr = [HGAccountModel bg_find:@"accountDB" where:where];
        
        if (arr.count != 0) {
            [MBProgressHUD showError:@"账号已存在"];
            return;
        }
        
        HGAccountModel *account = [[HGAccountModel alloc] init];
        account.mobile = self.registerPhoneTextField.text;
        account.password = self.registerPsdTextField.text;
        account.name = [NSString stringWithFormat:@"用户%@",self.registerPhoneTextField.text];
        account.bg_tableName = @"accountDB";
        [account bg_save];
        [MBProgressHUD showSuccess:@"注册成功"];
        [self dismissViewControllerAnimated:YES completion:nil];
    } isShowHud:YES];
}

- (IBAction)clickToLoginPage:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)backButtonClicked:(UIButton *)sender {
    HGTabBarController *tabVC = (HGTabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    tabVC.selectedIndex = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
