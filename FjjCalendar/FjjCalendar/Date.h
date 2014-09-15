//
//  Date.h
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject

+(Date *)defaultDate;

@property (nonatomic, strong) NSDate *currentDate;
/**
 *  返回今日是什么班
 *
 *  @param nowDate 今天的日期
 *  @param date    设置的日期
 *
 *  @return 上班的类型
 */
-(int)getTodayTypebyNowDate:(NSDate *)nowDate andCurrentDate:(NSDate *)date;
@end
