//
//  HGMineCellModel.m
//  HuangGuan
//
//  Created by 李凯 on 2019/8/20.
//  Copyright © 2019 LK. All rights reserved.
//

#import "HGMineCellModel.h"
#import "MJExtension.h"

@implementation HGMineCellModel

+ (NSArray *)mineCellModelWithPlistName:(NSString *)plistName {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:plistName ofType:nil];
    NSArray *dictArrs = [NSArray arrayWithContentsOfFile:filePath];
    
    return [HGMineCellModel mj_objectArrayWithKeyValuesArray:dictArrs];
}

@end
