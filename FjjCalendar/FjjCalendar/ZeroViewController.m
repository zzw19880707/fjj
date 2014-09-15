//
//  ZeroViewController.m
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "ZeroViewController.h"
#import "Date.h"
#import "FirstViewController.h"
#import "NSDate+Calendar.h"
@interface ZeroViewController ()
{
    int todayType;
}
@end

@implementation ZeroViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"首页";
    
    NSDate *date = [Date defaultDate].currentDate;
    
    //  date不存在，提示
    if (date == nil) {
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]] animated:NO];
        return ;
    }
    NSArray *dateArr = @[@"第一个白班",@"第二个白班",@"第三个白班",@"夜班",@"下夜班",@"休息"];

    todayType = [[Date defaultDate] getTodayTypebyNowDate:[NSDate date] andCurrentDate:date];
    self.title = dateArr[todayType];
    
    _pn([NSDate date].weekday);

    
}


@end
