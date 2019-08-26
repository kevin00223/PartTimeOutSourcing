//
//  OrderCollectionViewCell.m
//  YYAC
//
//  Created by Gerhard Z on 2019/5/24.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import "OrderCollectionViewCell.h"
#import "HGShopCarModel.h"
@interface OrderCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *amountLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation OrderCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setData:(HGShopCarModel *)data {
    _data = data;
    _productImage.image = [UIImage imageNamed:data.itemImage];
    NSMutableAttributedString *sign = [[NSMutableAttributedString alloc] initWithString:@"¥" attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 10]}];
    NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc] initWithString:data.itemPrice attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13]}];
    [sign appendAttributedString:amountStr];
    _amountLabel.attributedText = sign;
    _nameLabel.text = data.itemTitle;
    
    NSUInteger extractedExpr = data.shopCarCount;
    NSString *count = extractedExpr != 0 ? [NSString stringWithFormat:@"x %lu",(unsigned long)data.shopCarCount] : @"x 1";
    _countLabel.text = count;
    
}

@end
