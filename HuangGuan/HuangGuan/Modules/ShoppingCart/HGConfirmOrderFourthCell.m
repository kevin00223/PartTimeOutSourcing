//
//  HGConfirmOrderFourthCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/25.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGConfirmOrderFourthCell.h"

@interface HGConfirmOrderFourthCell () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end

@implementation HGConfirmOrderFourthCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.remarkTextView.placeholder = @"说点您需要的";
    self.remarkTextView.limitLength = @200;
    self.remarkTextView.placeholdColor = UIColorHex(#989898);
    self.remarkTextView.placeholdFont = [UIFont systemFontOfSize:12];
    self.remarkTextView.delegate = self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.block) {
        self.block(self.remarkTextView.text);
    }
}

@end
