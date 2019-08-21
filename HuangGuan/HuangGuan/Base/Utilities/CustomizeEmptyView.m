//
//  CustomizeEmptyView.m
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/2.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import "CustomizeEmptyView.h"

@implementation CustomizeEmptyView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare {
    [super prepare];
    self.titleLabFont = [UIFont fontWithName:@"PingFangSC-Regular" size:14];
    self.titleLabTextColor = HGHexColor(0x989898);
    
    self.detailLabFont = [UIFont fontWithName:@"PingFangSC-Regular" size:12];;
    self.detailLabTextColor = HGHexColor(0x989898);
    self.detailLabMaxLines = 5;
    self.actionBtnBackGroundColor = HGHexColor(0xf6f6f6);
}

+ (instancetype)diyNoDataEmpty{
    return [CustomizeEmptyView emptyViewWithImageStr:@"emptyView"
                                     titleStr:@"暂无数据"
                                    detailStr:@"你可以去别的地方逛逛"];
}


@end
