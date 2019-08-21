//
//  HGMineEditAddressTableViewController.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/21.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGAddressModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,EditAddressType) {
    EditAddressTypeNew,
    EditAddressTypeEdit
};

@interface HGMineEditAddressTableViewController : UITableViewController

@property (nonatomic, assign) EditAddressType addressType;

@property (nonatomic, strong) HGAddressModel *addressData;

@end

NS_ASSUME_NONNULL_END
