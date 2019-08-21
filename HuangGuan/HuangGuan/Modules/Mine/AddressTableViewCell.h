//
//  AddressTableViewCell.h
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/7.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGAddressModel;
NS_ASSUME_NONNULL_BEGIN

typedef void(^EditBlock)(HGAddressModel *address);

@interface AddressTableViewCell : UITableViewCell

@property (nonatomic, strong) HGAddressModel *detaiAddress;

@property (nonatomic, copy) EditBlock editBlock;

+ (instancetype)addressCellWith:(UITableView *)tableView index:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
