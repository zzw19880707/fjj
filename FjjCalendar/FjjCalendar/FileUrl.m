//
//  FileUrl.m
//  东北新闻网
//
//  Created by tenyea on 13-12-24.
//  Copyright (c) 2013年 佐筱猪. All rights reserved.
//

#import "FileUrl.h"

@implementation FileUrl
//返回cache文件路径
+(NSString *)getCacheFile {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *cachesDir = [paths objectAtIndex:0];
    return cachesDir;
}
//返回cache缓存数据文件路径
+(NSString *)getCacheFileURL {
    return  [[self getCacheFile] stringByAppendingPathComponent:@"com.tenyea.data/"];
}
//返回cache图片路径
+(NSString *)getCacheImageURL {
    return  [[self getCacheFile] stringByAppendingPathComponent:@"com.tenyea.img/"];
}
//返回document文件路径
+ (NSString *)getDocumentsFile {
    NSArray *paths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *plistPath1 = [paths objectAtIndex:0];
    return plistPath1;
}
//返回数据库文件名
+ (NSString *)getDBFile{
    return  [[self getDocumentsFile] stringByAppendingPathComponent:@"tenyea.db"];
}
+ (FMDatabase *)getDB{
    FMDatabase *db = [FMDatabase databaseWithPath:[self getDBFile] ];
    return  db;
}


+(NSString *)getLogPath {
    NSString *path = [[self getDocumentsFile] stringByAppendingPathComponent:@"log.plist"];
    NSFileManager *manager=  [NSFileManager defaultManager];

    if (![manager fileExistsAtPath:path]) {
        _po(@"log.plist文件不存在");
        NSArray *arr = [[NSArray alloc]init];
        [arr writeToFile:path atomically:YES];
    }
    return path;
}
+(BOOL)insertLogInPlist:(NSDictionary *)dictionary{
    NSString *path = [self getLogPath];
    NSMutableArray *allArr = [[NSMutableArray alloc]initWithArray:[self selectAllLog]];
    [allArr insertObject:dictionary atIndex:0];
    [allArr writeToFile:path atomically:YES];
    return YES;
}
+(NSArray *)selectAllLog{
    NSString *path = [self getLogPath];
    NSArray *arr = [[NSArray alloc]initWithContentsOfFile:path];
    return arr;
}

+(void )deleteAllLog{
    NSString *path = [self getLogPath];
    NSArray *arr = [[NSArray alloc]init];
    [arr writeToFile:path atomically:YES];
}

@end
