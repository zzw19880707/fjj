//
//  Date.m
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "Date.h"
#import "NSDate+Calendar.h"
static Date *sigleton = nil;
@implementation Date

/**
 *  返回今日是什么班
 *
 *  @param nowDate 今天的日期
 *  @param date    设置的日期
 *
 *  @return 上班的类型
 */
-(int)getTodayTypebyNowDate:(NSDate *)nowDate andCurrentDate:(NSDate *)date{
    //    时间差
    NSTimeInterval t = [[nowDate beginingOfDay] timeIntervalSinceDate:[date beginingOfDay]]/(60 * 60 *24 );
    int count = t /6 ;
    if(t < 0){
        t = (-count+1)*6 +t;
    }else{
        t =t - count*6;
    }
    /**
     *  设置最近一次中心时间
     */
    NSDate *newDate = [[NSDate alloc]initWithTimeInterval:count *6 *60 *60 *24 sinceDate:[date beginingOfDay]];
    [self setCurrentDate:newDate];
    return (int)t;
}

-(void)setCurrentDate:(NSDate *)currentDate{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[currentDate beginingOfDay] forKey:@"currentDate"];
    [userDefault synchronize];
}
-(NSDate *)currentDate{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    return [userDefault objectForKey:@"currentDate"];
}

+(Date *)defaultDate{
    if (sigleton == nil) {
        @synchronized(self){
            sigleton = [[Date alloc] init];
        }
    }
    return sigleton;
}


//限制当前对象创建多实例
#pragma mark - sengleton setting
+ (id)allocWithZone:(NSZone *)zone {
    @synchronized(self) {
        if (sigleton == nil) {
            sigleton = [super allocWithZone:zone];
        }
    }
    return sigleton;
}

+ (id)copyWithZone:(NSZone *)zone {
    return self;
}
@end
