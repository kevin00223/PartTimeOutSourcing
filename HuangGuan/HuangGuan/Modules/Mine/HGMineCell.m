//
//  HGMineCell.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMineCell.h"

@interface HGMineCell ()

@property (nonatomic, strong) UIImageView *cellIcon;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *sepratorLine;

@end

@implementation HGMineCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initSubviews];
    }
    return self;
}

- (void)initSubviews {
    [self.contentView addSubview:self.cellIcon];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.sepratorLine];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self.cellIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.offset(20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.cellIcon.mas_right).offset(20);
    }];
    
    [self.sepratorLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.contentView);
        make.height.offset(1/[UIScreen mainScreen].scale);
    }];
}

- (void)setMineCellModel:(HGMineCellModel *)mineCellModel {
    _mineCellModel = mineCellModel;
    self.cellIcon.image = [UIImage imageNamed:mineCellModel.iconImage];
    self.titleLabel.text = mineCellModel.title;
}

- (UIImageView *)cellIcon {
    if (!_cellIcon) {
        _cellIcon = [[UIImageView alloc]init];
    }
    return _cellIcon;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:13];
        [_titleLabel sizeToFit];
        _titleLabel.textColor = HGHexColor(0x282828);
    }
    return _titleLabel;
}

- (UIView *)sepratorLine {
    if (!_sepratorLine) {
        _sepratorLine = [[UIView alloc]init];
        _sepratorLine.backgroundColor = HGHexColor(0xDCDCDC);
    }
    return _sepratorLine;
}


@end
