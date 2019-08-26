//
//  HGConfirmOrderFourthCell.h
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^NoteBlock)(NSString *block);

@interface HGConfirmOrderFourthCell : UITableViewCell

@property (nonatomic, copy) NoteBlock block;

@end

NS_ASSUME_NONNULL_END
