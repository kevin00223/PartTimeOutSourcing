//
//  HGMainTableViewCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMainTableViewCell.h"

@interface HGMainTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *goodsButton1;
@property (weak, nonatomic) IBOutlet UILabel *goodsName1;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel1;
@property (weak, nonatomic) IBOutlet UIButton *goodsButton2;
@property (weak, nonatomic) IBOutlet UILabel *goodsName2;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel2;
@property (weak, nonatomic) IBOutlet UIButton *goodsButton3;
@property (weak, nonatomic) IBOutlet UILabel *goodsName3;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel3;

@end

@implementation HGMainTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataSourceDic:(NSDictionary *)dataSourceDic {
    _dataSourceDic = dataSourceDic;
    self.titleLabel.text = dataSourceDic[@"title"];
    self.subTitleLabel.text = dataSourceDic[@"subTitle"];
    [self.goodsButton1 setImage:[UIImage imageNamed:dataSourceDic[@"goods"][0][@"goodsButtonStr"]] forState:UIControlStateNormal];
    self.goodsName1.text = dataSourceDic[@"goods"][0][@"goodsName"];
    self.priceLabel1.text = dataSourceDic[@"goods"][0][@"price"];
    
    [self.goodsButton2 setImage:[UIImage imageNamed:dataSourceDic[@"goods"][1][@"goodsButtonStr"]] forState:UIControlStateNormal];
    self.goodsName2.text = dataSourceDic[@"goods"][1][@"goodsName"];
    self.priceLabel2.text = dataSourceDic[@"goods"][1][@"price"];
    
    [self.goodsButton3 setImage:[UIImage imageNamed:dataSourceDic[@"goods"][2][@"goodsButtonStr"]] forState:UIControlStateNormal];
    self.goodsName3.text = dataSourceDic[@"goods"][2][@"goodsName"];
    self.priceLabel3.text = dataSourceDic[@"goods"][2][@"price"];
}

@end
