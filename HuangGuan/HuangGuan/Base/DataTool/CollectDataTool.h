//
//  CollectDataTool.h
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/5.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Item;
NS_ASSUME_NONNULL_BEGIN

@interface CollectDataTool : NSObject

//往表插入数据
- (void)insertRecords:(Item *)item;

- (void)deleteRecord:(Item *)item;

- (NSMutableArray *)queryCollect;

+ (CollectDataTool *)sharedManger;

- (BOOL)queryIsSelect:(Item *)item;


@end

NS_ASSUME_NONNULL_END
