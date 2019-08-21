//
//  HGAccountModel.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGAccountModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) NSString *avatarImg;

@property (nonatomic, copy) NSString *password;

@end

NS_ASSUME_NONNULL_END
