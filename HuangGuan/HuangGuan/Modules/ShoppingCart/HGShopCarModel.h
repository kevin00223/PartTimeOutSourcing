//
//  HGShopCarModel.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HGShopCarModel : HGItemModel

@property (nonatomic, assign) NSUInteger shopCarCount;

@property (nonatomic, assign) BOOL isSelect;

@end

NS_ASSUME_NONNULL_END
