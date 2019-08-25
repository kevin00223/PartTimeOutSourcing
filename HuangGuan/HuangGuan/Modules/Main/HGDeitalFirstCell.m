//
//  HGDeitalFirstCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGDeitalFirstCell.h"

@interface HGDeitalFirstCell ()

@property (weak, nonatomic) IBOutlet UILabel *detailTitle;
@property (weak, nonatomic) IBOutlet UILabel *detailSale;
@property (weak, nonatomic) IBOutlet UILabel *detailPrice;


@end

@implementation HGDeitalFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setCellModel:(HGItemModel *)cellModel {
    _cellModel = cellModel;
    self.detailTitle.text = cellModel.itemTitle;
    self.detailSale.text = cellModel.itemSales;
    self.detailPrice.text = cellModel.itemPrice;
}

@end
