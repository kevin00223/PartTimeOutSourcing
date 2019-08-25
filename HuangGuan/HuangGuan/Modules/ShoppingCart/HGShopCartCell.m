//
//  HGShopCartCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGShopCartCell.h"

@interface HGShopCartCell ()

@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *itemImage;
@property (weak, nonatomic) IBOutlet UILabel *itemTitle;
@property (weak, nonatomic) IBOutlet UILabel *itemPrice;
@property (weak, nonatomic) IBOutlet UILabel *shopCarCountLabel;


@end

@implementation HGShopCartCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setShopCarItem:(HGShopCarModel *)shopCarItem {
    _shopCarItem = shopCarItem;
    self.itemImage.image = [UIImage imageNamed:shopCarItem.itemImage];
    self.itemTitle.text = shopCarItem.itemTitle;
    self.itemPrice.text = shopCarItem.itemPrice;
    self.shopCarCountLabel.text = @(shopCarItem.shopCarCount).stringValue;
}

- (void)setSelect:(BOOL)select {
    _select = select;
    _selectButton.selected = select;
}

- (IBAction)selectButtonClicked:(UIButton *)sender {
    sender.selected = !sender.selected;
    self.select = !self.select;
    if (self.selectBlock) {
        self.selectBlock(self.select);
    }
}

- (IBAction)removeButtonClicked:(UIButton *)sender {
    if (self.substructBlock) {
        self.substructBlock(_shopCarItem);
    }
}

- (IBAction)addButtonClicked:(UIButton *)sender {
    if (self.addBlock) {
        self.addBlock(_shopCarItem);
    }
}


@end
