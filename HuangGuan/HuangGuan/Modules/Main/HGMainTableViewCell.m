//
//  HGMainTableViewCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMainTableViewCell.h"
#import "HGItemModel.h"

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

@property (nonatomic, strong) NSArray *itemListArray;
@property (nonatomic, strong) NSArray *itemArray;

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
    
    HGItemModel *item0 = dataSourceDic[@"goods"][0];
    [self.goodsButton1 setImage:[UIImage imageNamed:item0.itemImage] forState:UIControlStateNormal];
    self.goodsName1.text = item0.itemTitle;
    self.priceLabel1.text = item0.itemPrice;
    
    HGItemModel *item1 = dataSourceDic[@"goods"][1];
    [self.goodsButton2 setImage:[UIImage imageNamed:item1.itemImage] forState:UIControlStateNormal];
    self.goodsName2.text = item1.itemTitle;
    self.priceLabel2.text = item1.itemPrice;
    
    HGItemModel *item2 = dataSourceDic[@"goods"][2];
    [self.goodsButton3 setImage:[UIImage imageNamed:item2.itemImage] forState:UIControlStateNormal];
    self.goodsName3.text = item2.itemTitle;
    self.priceLabel3.text = item2.itemPrice;
}

- (void)setCellTag:(NSInteger)cellTag {
    self.goodsButton1.tag = cellTag * 3 + 1;
    self.goodsButton2.tag = cellTag * 3 + 2;
    self.goodsButton3.tag = cellTag * 3 + 3;
}

- (IBAction)itemButtonClicked:(UIButton *)sender {
    HGItemModel *item1 = self.itemArray[0][0];
    HGItemModel *item2 = self.itemArray[0][1];
    HGItemModel *item3 = self.itemArray[0][2];
    HGItemModel *item4 = self.itemArray[1][0];
    HGItemModel *item5 = self.itemArray[1][1];
    HGItemModel *item6 = self.itemArray[1][2];
    
    if (sender.tag == 1) {
        self.itemDidClick(item1);
    }
    if (sender.tag == 2) {
        self.itemDidClick(item2);
    }
    if (sender.tag == 3) {
        self.itemDidClick(item3);
    }
    
    if (sender.tag == 4) {
        self.itemDidClick(item4);
    }
    if (sender.tag == 5) {
        self.itemDidClick(item5);
    }
    if (sender.tag == 6) {
        self.itemDidClick(item6);
    }

}

- (NSArray *)itemArray {
    if (!_itemArray) {
        _itemArray = @[
                       @[self.itemListArray[0][0], self.itemListArray[1][0], self.itemListArray[2][0]],
                       @[self.itemListArray[3][0], self.itemListArray[4][1], self.itemListArray[2][3]]
                       ];
    }
    return _itemArray;
}

- (NSArray *)itemListArray {
    if (!_itemListArray) {
        _itemListArray = [HGItemModel messageModelWithPlistName:@"Item.plist"];
    }
    return _itemListArray;
}


@end
