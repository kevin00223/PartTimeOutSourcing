//
//  HGShopCartCell.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGShopCarModel.h"
#import "HGItemModel.h"

typedef void(^ItemBlock)(HGItemModel * _Nullable item);

typedef void(^SelectBlock)(BOOL select);

NS_ASSUME_NONNULL_BEGIN

@interface HGShopCartCell : UITableViewCell

@property (nonatomic, strong) HGShopCarModel *shopCarItem;

@property (nonatomic, copy) ItemBlock addBlock;

@property (nonatomic, copy) ItemBlock substructBlock;

@property (nonatomic, copy) SelectBlock selectBlock;

@property (nonatomic, assign) BOOL select;

@end

NS_ASSUME_NONNULL_END
