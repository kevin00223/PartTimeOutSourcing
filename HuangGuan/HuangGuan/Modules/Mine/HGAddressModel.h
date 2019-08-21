//
//  HGAddressModel.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGAddressModel : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *mobile;

@property (nonatomic, strong) NSNumber *id;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *userMobile;

@property (nonatomic, assign) BOOL isDefault;

@end

NS_ASSUME_NONNULL_END
