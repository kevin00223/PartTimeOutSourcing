//
//  HGAddressModel.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGAddressModel.h"

@implementation HGAddressModel

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"Id" : @"id"};
}

+ (NSArray *)bg_uniqueKeys {
    return @[@"id"];
}

@end
