//
//  HGMainTableViewCell.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGItemModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^ItemDidClickBlock)(HGItemModel *item);

@interface HGMainTableViewCell : UITableViewCell

@property (nonatomic, strong) NSDictionary *dataSourceDic;

@property (nonatomic, strong) HGItemModel *item;

@property (nonatomic, assign) NSInteger cellTag;

@property (nonatomic, copy) ItemDidClickBlock itemDidClick;

@end

NS_ASSUME_NONNULL_END
