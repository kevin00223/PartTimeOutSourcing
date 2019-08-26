//
//  HGOrderDetailThridCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/26.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGOrderDetailThridCell.h"

@interface HGOrderDetailThridCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemCount;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;

@end

@implementation HGOrderDetailThridCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItem:(HGShopCarModel *)item {
    _item = item;
    self.itemImage.image = [UIImage imageNamed:item.itemImage];
    self.itemTitle.text = item.itemTitle;
    self.itemCount.text = [NSString stringWithFormat:@"x%lu", (unsigned long)item.shopCarCount];
    self.itemPrice.text = item.itemPrice;
}

@end
