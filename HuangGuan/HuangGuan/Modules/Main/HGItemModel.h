//
//  HGItemModel.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface HGItemModel : NSObject

@property (nonatomic, strong) NSString *itemImage;
@property (nonatomic, strong) NSString *itemTitle;
@property (nonatomic, strong) NSString *itemSubtitle;
@property (nonatomic, strong) NSString *itemSales;
@property (nonatomic, strong) NSString *itemPrice;

+ (NSArray *)messageModelWithPlistName: (NSString *)plistName;

@end

NS_ASSUME_NONNULL_END
