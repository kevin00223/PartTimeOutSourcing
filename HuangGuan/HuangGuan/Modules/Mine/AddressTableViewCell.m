//
//  AddressTableViewCell.m
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/7.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import "AddressTableViewCell.h"
#import "HGAddressModel.h"
@interface AddressTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *mobileLabel;
@property (weak, nonatomic) IBOutlet UIImageView *defaultIM;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;

@end

@implementation AddressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDetaiAddress:(HGAddressModel *)detaiAddress {
    _detaiAddress = detaiAddress;
    _nameLabel.text = detaiAddress.name;
    _mobileLabel.text = detaiAddress.mobile;
    _addressLabel.text = detaiAddress.address;
    if (!detaiAddress.isDefault) {
        [_defaultIM removeFromSuperview];
    }
}

- (IBAction)editAddress:(id)sender {
    if (self.editBlock) {
        self.editBlock(_detaiAddress);
    }
}

+ (instancetype)addressCellWith:(UITableView *)tableView index:(NSInteger)index {
    NSString *identifier = @"";
    switch (index) {
        case 0:
            identifier = @"address";
            index = 0;
            break;
        default:
            break;
    }
    
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"AddressTableViewCell" owner:self options:nil] objectAtIndex:index];
    }
    return cell;
}


@end
