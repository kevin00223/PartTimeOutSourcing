//
//  HGConfirmOrderViewController.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Order.h"

NS_ASSUME_NONNULL_BEGIN

@interface HGConfirmOrderViewController : UIViewController

@property (nonatomic, strong) Order *orderData;

@property (nonatomic, assign) BOOL isFromShopCar;

@end

NS_ASSUME_NONNULL_END
