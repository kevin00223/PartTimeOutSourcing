//
//  UIViewController+Uitils.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "UIViewController+Uitils.h"
#import "HGLoginRegisterViewController.h"

@implementation UIViewController (Uitils)

- (void)loginRequest {
    JHUserDefaults *userD = [JHUserDefaults shareInstance];
    if (![userD.mobile isNotBlank]) {
        UIStoryboard *sb = [UIStoryboard storyboardWithName:@"HGLoginRegister" bundle:nil];
        HGLoginRegisterViewController *loginRegisterVC = [sb instantiateViewControllerWithIdentifier:@"loginRegister"];
        [self presentViewController:loginRegisterVC animated:YES completion:nil];
        return;
    }
}

- (void)toDoAnythingWithInternet:(void (^)(void))anything isShowHud:(BOOL)showHud {
    switch ([WHC_HttpManager shared].networkStatus) {
        case NotReachable:
            [MBProgressHUD showError:@"当前无网络"];
            return;
            break;
        case ReachableViaWiFi:
            
            break;
        case ReachableViaWWAN:
            
            break;
    }
    
    if (showHud) {
        [MBProgressHUD showMessage:@"请稍后"];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), anything);
    } else {
        anything();
    }
    
    
}

@end
