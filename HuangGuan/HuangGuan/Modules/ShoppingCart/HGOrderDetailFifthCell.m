//
//  HGOrderDetailFifthCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/26.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGOrderDetailFifthCell.h"

@interface HGOrderDetailFifthCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderId;

@end

@implementation HGOrderDetailFifthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrder:(Order *)order {
    _order = order;
    
    if (order.bg_id) {
        self.orderId.text = @(order.bg_id.integerValue + 2019000900).stringValue;
    } else {
        NSUInteger maxCount = [Order bg_findAll:@"orderDB"].count;
        self.orderId.text = @(maxCount + 2019000900).stringValue;
    }
}

@end
