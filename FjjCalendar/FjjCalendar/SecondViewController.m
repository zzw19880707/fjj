//
//  SecondViewController.m
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "SecondViewController.h"
#import "Date.h"
#import "FirstViewController.h"
#import "NSDate+Calendar.h"
@interface SecondViewController ()
{
    NSArray *thisMonthArr;
    NSArray *nextMonthArr;
}
@end

@implementation SecondViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *date = [Date defaultDate].currentDate;
    NSDate *nowDate = [NSDate date];
//  date不存在，提示
    if (date == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"还没有选择日期,是否前往选择日期" delegate:self cancelButtonTitle:@"不去了" otherButtonTitles:@"好的", nil];
        [alert show];
    }else{
//        本月
//        获取今天班的类型
        int type = [[Date defaultDate] getTodayTypebyNowDate:nowDate andCurrentDate:date];
//        获取今天日期
        int nowday = nowDate.day;
        
        int lastday = nowDate.lastDayOfTheMonth.day;
        NSMutableArray *thisMonth = [[NSMutableArray alloc]initWithCapacity: (lastday - nowday + 1 + type)];
        if (nowday- type- 1>0) {
            for (int i = lastday ; i > nowday - type - 1; i -- ) {
                [thisMonth insertObject:@(i) atIndex:0];
            }
        }else{
//            本月
            for (int i = lastday ; i > nowday - 1; i -- ) {
                [thisMonth insertObject:@(i) atIndex:0];
            }
//            获取上个月最后一天
            int lastMonthLastDay = nowDate.associateDayOfThePreviousMonth.lastDayOfTheMonth.day;
//            下月
            for (int i = lastMonthLastDay; i >lastMonthLastDay - type ; i --) {
                [thisMonth insertObject:@(i) atIndex:0];

            }
        }
        thisMonthArr = thisMonth;

//        下个月
        
    
    }
}
#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section == 0) {
        return thisMonthArr.count;
    }else{
        return nextMonthArr.count;
    }
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    static NSString *cellIdentity = @"cellIdentity";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentity forIndexPath:indexPath];
    if (cell == nil) {
        
    }
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
    label.tag = 100;
    label.textColor = [UIColor redColor];
    [cell.contentView addSubview:label];
    if (indexPath.section == 0) {
        label.text = [NSString stringWithFormat:@"%@",thisMonthArr[indexPath.row]];
    }else{
        label.text = [NSString stringWithFormat:@"%@",nextMonthArr[indexPath.row]];

    }
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

#pragma mark -
#pragma mark UICollectionViewDelegate



#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]] animated:NO];
    }
}
@end
