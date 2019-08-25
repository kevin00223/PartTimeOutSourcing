//
//  ShopCarDataTool.h
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/4.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@class HGShopCarModel;
@interface ShopCarDataTool : NSObject


- (void)addToShopCar:(HGShopCarModel *)item;
- (void)substractToShopCar:(HGShopCarModel *)item;
- (void)deteleRecord:(HGShopCarModel *)item;
+ (ShopCarDataTool *)sharedManger;
- (NSMutableArray *)queryShopCar;
- (NSMutableArray *)querySelectItem;
- (void)selectItem:(HGShopCarModel *)item select:(BOOL)select;
@end

NS_ASSUME_NONNULL_END
