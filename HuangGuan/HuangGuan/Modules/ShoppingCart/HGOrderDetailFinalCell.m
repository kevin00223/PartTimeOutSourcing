//
//  HGOrderDetailThirdCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGOrderDetailFinalCell.h"

@interface HGOrderDetailFinalCell ()

@property (weak, nonatomic) IBOutlet UILabel *accountName;
@property (weak, nonatomic) IBOutlet UILabel *accountPhone;
@property (weak, nonatomic) IBOutlet UILabel *accountAddress;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;


@end

@implementation HGOrderDetailFinalCell

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
    self.accountName.text = order.address.name;
    self.accountPhone.text = order.address.mobile;
    self.accountAddress.text = order.address.address;
    self.noteLabel.text = order.note;
}

@end
