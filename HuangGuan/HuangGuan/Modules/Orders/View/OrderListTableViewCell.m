//
//  OrderListTableViewCell.m
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/8.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import "OrderListTableViewCell.h"
#import "OrderCollectionViewCell.h"
#import "Order.h"
@interface OrderListTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *collectionViewHeight;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLabel;

@end

@implementation OrderListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([OrderCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellId"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setOrderData:(Order *)orderData {
    _orderData = orderData;
    
    NSMutableAttributedString *sign = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"共%lu件商品,",(unsigned long)orderData.itemArr.count] attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 10]}];
    NSMutableAttributedString *amountStr = [[NSMutableAttributedString alloc] initWithString:orderData.totalAmount attributes:@{NSFontAttributeName: [UIFont fontWithName:@"PingFangSC-Regular" size: 13]}];
    [sign appendAttributedString:amountStr];
    
    _totalAmountLabel.attributedText = sign;
    _orderIdLabel.text = [NSString stringWithFormat:@"订单编号: %ld",_orderData.bg_id.integerValue + 201900600];
    
    _collectionViewHeight.constant = (orderData.itemArr.count * 90) + (orderData.itemArr.count - 1) * 10;
    
    //    [self.collectionView reloadData];
}



- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSUInteger count = _orderData.itemArr.count;
    return count;
}



//每个单元格的大小size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionView.width - 30, 90);
}

-(CGFloat )collectionView:(UICollectionView *)collectionView
                   layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 10;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    OrderCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndexPath:indexPath];
    cell.data = _orderData.itemArr[indexPath.row];
    return cell;
}

@end
