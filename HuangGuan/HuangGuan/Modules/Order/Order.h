//
//  Order.h
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/7.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BGFMDB.h>
#import "HGAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Order : NSObject

@property (nonatomic, strong) HGAddressModel *address;

@property (nonatomic, strong) NSArray *itemArr;

@property (nonatomic, strong) NSString *totalAmount;

@property (nonatomic, strong) NSDictionary *account;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, assign) BOOL isDelivered;

@property (nonatomic, copy) NSString *takeTime;


@end

NS_ASSUME_NONNULL_END
