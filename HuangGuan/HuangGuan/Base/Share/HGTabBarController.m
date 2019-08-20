//
//  HGTabBarController.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGTabBarController.h"
#import "HGNavigationController.h"

@interface HGTabBarController ()

@end

@implementation HGTabBarController

- (instancetype)init {
    self = [super init];
    
    if (self) {
        [self initViewControllers];
    }
    return self;
}

- (void)initViewControllers {
    [self.tabBar setTintColor:HGRedColor];
    
    UIViewController *vc1 = [self setupChildViewControllerWithControllerName:@"HGMainViewController" title:@"首页" imageName:@"main"];
    UIViewController *vc2 = [self setupChildViewControllerWithControllerName:@"HGShoppingCartViewController" title:@"购物车" imageName:@"shoppingCart"];
    UIViewController *vc3 = [self setupChildViewControllerWithControllerName:@"HGOrdersViewController" title:@"订单" imageName:@"orders"];
    UIViewController *vc4 = [self setupChildViewControllerWithControllerName:@"HGMineViewController" title:@"我的" imageName:@"mine"];
    
    self.viewControllers = @[vc1, vc2, vc3, vc4];
}

- (UIViewController *)setupChildViewControllerWithControllerName: (NSString *)controllerName title: (NSString *)title imageName: (NSString *)imageName {
    Class viewControllerClass = NSClassFromString(controllerName);
    UIViewController *viewController = [[viewControllerClass alloc] init];
    viewController.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.selectedImage = [[UIImage imageNamed:[imageName stringByAppendingString:@"_Sel"]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    viewController.tabBarItem.title = title;
    HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController: viewController];
    return nav;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
