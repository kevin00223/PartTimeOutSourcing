//
//  HGItemModel.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/24.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGItemModel.h"

@implementation HGItemModel

+ (NSArray *)messageModelWithPlistName: (NSString *)plistName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *dictArrs = [NSArray arrayWithContentsOfFile:filePath];
    
    return [HGItemModel mj_objectArrayWithKeyValuesArray:dictArrs];
}

@end
