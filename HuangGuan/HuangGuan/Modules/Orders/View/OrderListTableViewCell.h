//
//  OrderListTableViewCell.h
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/8.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Order;
NS_ASSUME_NONNULL_BEGIN

@interface OrderListTableViewCell : UITableViewCell

@property (nonatomic, strong) Order *orderData;

@end

NS_ASSUME_NONNULL_END
