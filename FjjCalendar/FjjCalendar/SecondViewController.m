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
    NSArray *titleArr;
    UIView *_view;
    NSArray *_weekArr;
}
@end

@implementation SecondViewController



- (void)viewDidLoad
{
    [super viewDidLoad];

    _weekArr = @[@"",@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    
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
//        nowday = 1;
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

        
        NSMutableArray *nextMonth = [[NSMutableArray alloc]init];
//        下个月
////        下个月第一天
        NSDate *nextMonthFirstDay = nowDate.firstDayOfTheFollowingMonth;
//        下个月最后一天
        NSDate *nextMonthLastDay = nowDate.firstDayOfTheFollowingMonth.lastDayOfTheMonth;
        int nextMonthlastday = nextMonthLastDay.day;
//        计算下个月第一天是什么班
        int nextMonthtype = [[Date defaultDate] getTodayTypebyNowDate:nextMonthFirstDay andCurrentDate:date];
        if (nextMonthtype == 0 ) {
            for (int i = nextMonthlastday ; i > 0; i -- ) {
                [nextMonth insertObject:@(i) atIndex:0];
            }
        }else{
            for (int i = nextMonthlastday ; i > 0; i -- ) {
                [nextMonth insertObject:@(i) atIndex:0];
            }
            for (int i = 0; i < nextMonthtype; i ++ ) {
                [nextMonth insertObject:@"" atIndex:0];
            }
        }
        nextMonthArr = [[NSArray alloc]initWithArray:nextMonth];
        
        
        titleArr = @[@(nowDate.month),@(nextMonthLastDay.month)];
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
    
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
    
    UILabel *label = (UILabel *)VIEWWITHTAG(cell.contentView, 100);
    label.textColor = [UIColor grayColor];
    if (indexPath.section == 0) {
        label.text = [NSString stringWithFormat:@"%@",thisMonthArr[indexPath.row]];
        if ([thisMonthArr[indexPath.row ] intValue] == [NSDate date].day) {
            label.textColor = [UIColor redColor];
        }
    }else{
        label.text = [NSString stringWithFormat:@"%@",nextMonthArr[indexPath.row]];
    }

    UILabel *weekLabel = (UILabel *)VIEWWITHTAG(cell.contentView, 200);
    NSDate *date =[self getdate:indexPath];
    if (date) {
        weekLabel.hidden = NO;
        weekLabel.text = _weekArr[date.weekday];
    }else{
        weekLabel.hidden = YES;
    }
    return cell;
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view ;
    if (kind == UICollectionElementKindSectionHeader) {
         view  = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"collectionIdentifier" forIndexPath:indexPath];

    }
    UILabel *label = (UILabel *)VIEWWITHTAG(view, 101);
    label.text = [NSString stringWithFormat:@"%@月",titleArr[indexPath.section]];
    return view;
}

#pragma mark -
#pragma mark UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

//    NSDate *selectDate = [NSDate date];
    NSDate *date =[self getdate:indexPath];
    if (!date) {
        return;
    }
    int type = [[Date defaultDate]getTodayTypebyNowDate:date andCurrentDate: [Date defaultDate].currentDate];
    NSArray *dateArr = @[@"第一个白班",@"第二个白班",@"第三个白班",@"夜班",@"下夜",@"休息"];
    NSArray *weekdayArr = @[@"星期一",@"星期日",@"星期一",@"星期二",@"星期三",@"星期四",@"星期五",@"星期六"];
    NSString *week = weekdayArr[date.weekday];
    NSString *string = [NSString stringWithFormat:@"%d年%d月%d日是%@,%@。",date.year,date.month,date.day,week,dateArr[type]];
    if (!_view) {
        _view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _view.hidden = YES;
        _view.backgroundColor = [UIColor blackColor];
        _view.alpha = .5;
        [self.view addSubview:_view];
        _view.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancel )];
        [_view addGestureRecognizer:tapGesture];
        UILabel *label = [[UILabel alloc]init];
        label.frame = _view.frame;
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = 1000;
        label.font = FONT(17);
        label.textColor = [UIColor whiteColor];
        [_view addSubview:label];
    }

    _view.hidden = NO;
    UILabel *label = (UILabel *)VIEWWITHTAG(_view, 1000);
    label.text = string;
    
}
-(void)cancel{
    _view.hidden = YES;

}


#pragma mark -
#pragma mark UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex == 1){
        [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"firstViewController"]] animated:NO];
    }
}

#pragma mark -
#pragma mark method 
-(NSDate *)getdate :(NSIndexPath *)indexPath{
    if (indexPath.section == 1&&[nextMonthArr[indexPath.row] intValue] == 0 ) {
        return nil;
    }
    
    NSDateComponents *dateComponents = [[[NSDate date] beginingOfDay]componentsOfDay];
    if (indexPath.section == 0 ) {
        [dateComponents setDay: [thisMonthArr[indexPath.row] integerValue]];
    }else{
        dateComponents.day = [nextMonthArr[indexPath.row] integerValue];
    }
    dateComponents.month = [[titleArr objectAtIndex:indexPath.section] intValue];
    if (indexPath.section == 1 && [titleArr[1] intValue] == 1) {
        dateComponents.year +=1;
    }
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date =  [gregorian dateFromComponents:dateComponents];
    return date;
}
@end
