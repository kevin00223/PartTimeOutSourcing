//
//  HGItemCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGItemCell.h"

@interface HGItemCell ()

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *itemSale;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;


@end

@implementation HGItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setItemModel:(HGItemModel *)itemModel {
    _itemModel = itemModel;
    
    self.itemImageView.image = [UIImage imageNamed:itemModel.itemImage];
    self.itemTitle.text = itemModel.itemTitle;
    self.itemSubtitle.text = itemModel.itemSubtitle;
    self.itemSale.text = itemModel.itemSales;
    self.itemPrice.text = itemModel.itemPrice;
}

@end
