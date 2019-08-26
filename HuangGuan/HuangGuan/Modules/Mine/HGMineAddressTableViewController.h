//
//  HGMineAddressTableViewController.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,Orgin) {
    OrginMyAddress,
    OrginOrder
};

typedef void(^SelectBlock)(HGAddressModel *address);

@interface HGMineAddressTableViewController : UITableViewController

@property (nonatomic, assign) Orgin orgin;

@property (nonatomic, copy) SelectBlock block;

@end

NS_ASSUME_NONNULL_END
