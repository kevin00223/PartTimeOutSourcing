//
//  AppDelegate.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "AppDelegate.h"
#import "HGNavigationController.h"
#import "HGTabBarController.h"
#import "HGAddressModel.h"
#import "HGAccountModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self networkRequest];
    
    [[WHC_HttpManager shared] registerNetworkStatusMoniterEvent];
    
    if (![UserDefault boolForKey:@"first"]) {
        [self setupAccountTable];
    }
    
    self.window = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    HGNavigationController *loginNav = [[HGNavigationController alloc]initWithRootViewController:[[SALoginViewController alloc] init]];
    HGTabBarController *tabBarVC = [[HGTabBarController alloc]init];
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *studentNo = [userDefaults objectForKey:@"studentNo"];
//    if (studentNo.length == 0) {
//        [userDefaults setObject:@"160601" forKey:@"studentNo"];
//        [userDefaults setObject:@"123123" forKey:@"password"];
//
//        self.window.rootViewController = loginNav;
//    }else{
//        self.window.rootViewController = tabBarVC;
//    }
    
    self.window.rootViewController = tabBarVC;
    
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setupAccountTable {
    HGAccountModel *account = [[HGAccountModel alloc] init];
    account.bg_tableName = @"accountDB";
    account.name = @"SYangN花卷";
    account.mobile = @"15101070703";
    account.password = @"123456";
    [account bg_saveOrUpdate];
    
    HGAddressModel *address = [[HGAddressModel alloc] init];
    address.address = @"四川省成都市高新区天府三街新时代科技广场";
    address.mobile = @"15101070703";
    address.name = @"SYangN花卷";
    address.isDefault = YES;
    address.bg_tableName = @"addressDB";
    address.userMobile = @"15101070703";
    [address bg_save];
}

- (void)networkRequest {
    
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
