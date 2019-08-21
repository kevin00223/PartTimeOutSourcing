//
//  UIBarButtonItem+CustomBarButtonItem.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (CustomBarButtonItem)

+ (instancetype)itemWithTitle:(NSString *_Nullable)title Image:(NSString *_Nullable)image target:(id)target action:(SEL)action;

@end

NS_ASSUME_NONNULL_END
