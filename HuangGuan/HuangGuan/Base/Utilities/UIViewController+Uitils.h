//
//  UIViewController+Uitils.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (Uitils)

- (void)loginRequest;

- (void)toDoAnythingWithInternet:(void (^)(void))anything isShowHud:(BOOL)showHud;

@end

NS_ASSUME_NONNULL_END
