//
//  UIImage+GradientColor.h
//  JZJSG
//
//  Created by Gerhard Z on 2019/5/31.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, GradientType) {
    
    GradientTypeTopToBottom = 0,//从上到小
    
    GradientTypeLeftToRight = 1,//从左到右
    
    GradientTypeUpleftToLowright = 2,//左上到右下
    
    GradientTypeUprightToLowleft = 3,//右上到左下
    
};


@interface UIImage (GradientColor)


+ (UIImage *)gradientColorImageFromColors:(NSArray*)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize;

@end

NS_ASSUME_NONNULL_END
