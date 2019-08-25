//
//  HGConfirmOrderFirstCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGConfirmOrderFirstCell.h"

@interface HGConfirmOrderFirstCell ()

@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *accountPhone;
@property (weak, nonatomic) IBOutlet UILabel *accountAddress;


@end

@implementation HGConfirmOrderFirstCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderData:(Order *)orderData {
    _orderData = orderData;
    self.accountName.text = orderData.address.name;
    self.accountPhone.text = orderData.address.mobile;
    self.accountAddress.text = orderData.address.address;
}

- (IBAction)toAddressButtonClicked:(UIButton *)sender {
}


@end
