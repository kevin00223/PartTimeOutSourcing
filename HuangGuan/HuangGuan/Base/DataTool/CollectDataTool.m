//
//  CollectDataTool.m
//  JZJSG
//
//  Created by Gerhard Z on 2019/6/5.
//  Copyright © 2019 lakers JH. All rights reserved.
//

#import "CollectDataTool.h"
#import <BGFMDB/FMDB.h>
#import "JHUserDefaults.h"
#import <BGFMDB/FMDatabaseQueue.h>
#import "HGItemModel.h"
@interface CollectDataTool()

@property (nonatomic, strong) FMDatabase *fmdb;

@property (nonatomic, strong) NSArray *dataArr;

@property (nonatomic, strong) FMDatabaseQueue *queue;

@property (nonatomic, copy) NSString *mobile;

@end

static NSString *const dbName = @"CollectDB.db";
static NSString *const locationTableName = @"CollectDB";

@implementation CollectDataTool

- (NSString *)mobile {
    if (!_mobile) {
        _mobile = [[JHUserDefaults shareInstance].mobile isNotBlank] ? [JHUserDefaults shareInstance].mobile : @"13119663587";
    }
    return _mobile;
}

// 懒加载数据库队列
- (FMDatabaseQueue *)queue {
    if (_queue == nil) {
        _queue = [FMDatabaseQueue databaseQueueWithPath:[self pathForName:locationTableName]];
    }
    return _queue;
}

static CollectDataTool *shareInstance = nil;

+ (CollectDataTool *)sharedManger {
    @synchronized (self) {
        if (!shareInstance) {
            shareInstance = [[self alloc] init];
        }
    }
    return shareInstance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    @synchronized (self) {
        if (!shareInstance) {
            shareInstance = [super allocWithZone:zone];
        }
    }
    return shareInstance;
}

- (id)copy {
    return shareInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self creatDB];
    }
    return self;
}

- (void)creatDB {
    NSString *dbPath = [self pathForName:dbName];
    self.fmdb = [FMDatabase databaseWithPath:dbPath];
    if (![self isTableOK]) {
        [self createTable];
    }
}


//获得指定名字的文件的全路径
- (NSString *)pathForName:(NSString *)name {
    NSString * dbPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),dbName];
    NSLog(@"数据库地址：\n%@", dbPath);
    return dbPath;
}

// 判断是否存在表
- (BOOL) isTableOK {
    BOOL openSuccess = [self.fmdb open];
    static BOOL isOk = NO;
    if (!openSuccess) {
        NSLog(@"地址数据库打开失败");
    } else {
        NSLog(@"地址数据库打开成功");
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            FMResultSet *rs = [self.fmdb executeQuery:@"SELECT count(*) as 'count' FROM sqlite_master WHERE type ='table' and name = ?", locationTableName];
            while ([rs next]) {
                // just print out what we've got in a number of formats.
                NSInteger count = [rs intForColumn:@"count"];
                if (0 == count) {
                    [self.fmdb close];
                    isOk = NO;
                } else {
                    [self.fmdb close];
                    isOk = YES;
                }
            }
        }];
    }
    [self.fmdb close];
    return isOk;
}


//创建表
- (BOOL)createTable {
    BOOL result = NO;
    BOOL openSuccess = [self.fmdb open];
    if (!openSuccess) {
        NSLog(@"地址数据库打开失败");
    } else {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key AUTOINCREMENT,itemId integer,itemName text,itemImg text,amount text,memberMobile text);",locationTableName];
        result = [self.fmdb executeUpdate:sql];
        if (!result) {
            NSLog(@"创建地址表失败");
            
        } else {
            NSLog(@"创建地址表成功");
        }
    }
    [self.fmdb close];
    return result;
}

//往表插入数据
- (void)insertRecords:(HGItemModel *)item {
    
    // 开启事务
    if ([self.fmdb open] && [self.fmdb beginTransaction]) {
        
        BOOL isRollBack = NO;
        @try {
            NSString *insertSql= [NSString stringWithFormat:
                                  @"INSERT OR IGNORE INTO %@ ('itemId','itemName','itemImg','amount','memberMobile') VALUES (%lu,'%@','%@','%@','%@')", locationTableName,item.Id,item.itemTitle,item.itemImage,item.itemPrice,self.mobile];
            BOOL a = [self.fmdb executeUpdate:insertSql];
            if (!a) {
                NSLog(@"插入信息数据失败");
            }
            else {
                NSLog(@"批量插入信息数据成功！");
            };
        }
        @catch (NSException *exception) {
            isRollBack = YES;
            [self.fmdb rollback];
        }
        @finally {
            if (!isRollBack) {
                [self.fmdb commit];
            }
        }
        [self.fmdb close];
        
    } else {
        [self insertRecords:item];
    }
}

- (void)deleteRecord:(HGItemModel *)item {
    if ([self.fmdb open]) {
        NSString *sql = [NSString stringWithFormat:@"delete FROM %@ WHERE memberMobile = '%@' and itemId = %lu",locationTableName,self.mobile,item.Id];
        BOOL success = [self.fmdb executeUpdate:sql];
        if (success) {
            NSLog(@"删除商品成功");
        } else {
            NSLog(@"删除商品失败");
        }
    }
}


- (NSMutableArray *)queryCollect {
    if ([self.fmdb open]) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
        [self.queue inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE memberMobile = '%@' order by id DESC"  , locationTableName,self.mobile];
            FMResultSet *result = [self.fmdb  executeQuery:sql];
            NSLog(@"读取消息 线程:%@",[NSThread currentThread]);
            while ([result next]) {
                HGItemModel *model = [[HGItemModel alloc] init];
                model.Id = [result intForColumn:@"itemId"];
                model.itemImage = [result stringForColumn:@"itemImg"];
                model.itemTitle = [result stringForColumn:@"itemName"];
                model.itemPrice = [result stringForColumn:@"amount"];
                [array addObject:model];
            }
        }];
        if (array.count > 0) {
            return array;
        }
        
    }
    return nil;
}

- (BOOL)queryIsSelect:(HGItemModel *)item {
    if ([self.fmdb open]) {
        NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) as isSelect FROM %@ WHERE itemId = %lu and memberMobile = '%@' ",locationTableName,item.Id,self.mobile];
        FMResultSet *result = [self.fmdb  executeQuery:sql];
        while ([result next]) {
            int totalCount = [result intForColumn:@"isSelect"];
            if (totalCount > 0) {
                return YES;
            }
        }
    }
    return NO;
}

@end
