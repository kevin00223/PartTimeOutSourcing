//
//  HGItemDetailsTableViewController.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface HGItemDetailsTableViewController : UITableViewController

@property (nonatomic, strong) NSString *topImageStr;
@property (nonatomic, strong) HGItemModel *detailModel;

@end

NS_ASSUME_NONNULL_END
