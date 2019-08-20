//
//  HGMineCellModel.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGMineCellModel : NSObject

@property (nonatomic, strong) NSString *iconImage;

@property (nonatomic, strong) NSString *title;

+ (NSArray *)mineCellModelWithPlistName: (NSString *)plistName;

@end

NS_ASSUME_NONNULL_END
