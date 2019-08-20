//
//  HGConst.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#ifndef HGConst_h
#define HGConst_h

// 屏幕的宽和高
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

// 颜色
#define HGRandomColor  [UIColor colorWithRed:arc4random() % 256 / 256.0 green:arc4random() % 256 / 256.0 blue:arc4random() % 256 / 256.0 alpha:1.0];
#define HGHexColor(f) [UIColor colorWithRed:(((f) >> 16) & 0x0000ff) / 255.0 green:(((f) >> 8) & 0x0000ff) / 255.0 blue:(((f)) & 0x0000ff) / 255.0 alpha:1.0]

#define HGRedColor HGHexColor(0xEB5266)


/**
 iPhoneX
 */
#define kIsIPhoneX ((kScreenWidth == 375 && kScreenHeight == 812) ? YES : NO)

/**
 状态栏+导航栏高度
 */
#define kStatusBarAndNavigationBarHeight (kIsIPhoneX ? 88 : 64)

/**
 状态栏高度
 */
#define kStatusBarHeight (kIsIPhoneX ? 44 : 20)

/**
 导航栏高度
 */
#define kNavigationBarHeight 44

/**
 tabBar高度
 */
#define kTabBarHeight (kIsIPhoneX ? (49+34) : 49)

#endif /* HGConst_h */
