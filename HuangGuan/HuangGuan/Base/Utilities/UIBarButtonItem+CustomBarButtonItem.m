//
//  UIBarButtonItem+CustomBarButtonItem.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "UIBarButtonItem+CustomBarButtonItem.h"

@implementation UIBarButtonItem (CustomBarButtonItem)

+ (instancetype)itemWithTitle:(NSString *_Nullable)title Image:(NSString *_Nullable)image target:(id)target action:(SEL)action {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if ([title isNotBlank]) {
        [button setTitle:title forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:16];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    
    if ([image isNotBlank]) {
        [button setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    [button sizeToFit];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[self alloc] initWithCustomView:button];
}

@end
