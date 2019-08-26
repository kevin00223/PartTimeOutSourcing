//
//  HGOrderDetailFirstOneCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGOrderDetailFirstOneCell.h"
#import "HGShopCarModel.h"

@interface HGOrderDetailFirstOneCell ()

@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;

@end

@implementation HGOrderDetailFirstOneCell

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
    
    CGFloat total = 0.00;
    for (HGShopCarModel *item in order.itemArr) {
        total += [[item.itemPrice substringFromIndex:1] doubleValue] * item.shopCarCount;
    }
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%.2f", total];
}

@end
