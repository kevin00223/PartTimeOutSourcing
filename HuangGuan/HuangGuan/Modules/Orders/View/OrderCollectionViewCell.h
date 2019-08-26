//
//  OrderCollectionViewCell.h
//  YYAC
//
//  Created by Gerhard Z on 2019/5/24.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class HGShopCarModel;

@interface OrderCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) HGShopCarModel *data;

@end

NS_ASSUME_NONNULL_END
