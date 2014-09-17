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
#import "FileUrl.h"
@interface ZeroViewController ()
{
    int todayType;//第几个班
    int weekday;//星期几
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

    todayType = [[Date defaultDate] getTodayTypebyNowDate:[NSDate date] andCurrentDate:date];
    weekday = [NSDate date].weekday;
    NSString *weekdayString = [self getStringByWeekDay:weekday];
    NSString *todayTypeString = [self getStringByTodayType];
    NSString *string = [NSString stringWithFormat:@"\t%@%@",weekdayString,todayTypeString];
    
    NSMutableAttributedString *attributeString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, string.length)];
    
    //    设置字体大小
    [attributeString addAttribute:NSFontAttributeName  value:FONT(20) range:NSMakeRange(0, string.length)];

//    红色
    NSString *redWeekdayString ;
    switch (weekday) {
        case 1:
            redWeekdayString = @"星期日";
            break;
        case 2:
            redWeekdayString = @"星期一";
            break;
        case 3:
            redWeekdayString = @"星期二";
            break;
        case 4:
            redWeekdayString = @"星期三";
            break;
        case 5:
            redWeekdayString = @"星期四";
            break;
        case 6:
            redWeekdayString = @"星期五";
            break;
        case 7:
            redWeekdayString = @"星期六";
            break;
        default:
            break;
    }
    NSRange redRange = [string rangeOfString:redWeekdayString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
//    绿色
    NSString *greenString;
    if (todayType == 0||todayType == 1||todayType == 2) {
        greenString = @"白班";
    }else if (todayType == 3){
        greenString = @"夜班";
    }else if (todayType == 4){
        greenString = @"下夜班";
    }else{
        greenString = @"休息";
    }
    NSRange greenRange = [string rangeOfString:greenString];
    [attributeString addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:greenRange];
    self.textView.attributedText = attributeString;
    
}
/**
 *  返回今日是什么班
 *
 *  @param weekday 星期几
 *
 *  @return
 */
-(NSString *)getStringByWeekDay:(int)thisweekday{
    switch (thisweekday) {
        case 1://日
            return @"今天是星期日。";
            break;
            case 2://一
            if (todayType == 0 ||todayType == 1 ||todayType == 2) {
                return @"今天是星期一,早上七点半上班。";
            }else{
                return @"今天是星期一。";
            }
            break;
            case 3://二
            return @"今天是星期二。";
            break;
            case 4://三
            return @"今天是星期三。";
            break;
            case 5://四
            return @"今天是星期四。";
            break;
            case 6://五
            return @"今天是星期五,下午三点半开会。";
            break;
            case 7://六
            return @"今天是星期六。";
            break;
        default:
            break;
    }
    return nil;
}
/**
 *  返回上班类型
 *
 *  @return
 */
-(NSString *)getStringByTodayType{
    NSArray *dateArr = @[@"第一个白班,在二楼上班,",@"第二个白班,在二楼上班,",@"第三个白班,在一楼上班,",@"夜班,",@"八点下夜班",@"休息"];
    NSMutableString *string  = [[NSMutableString alloc]initWithString:[NSString stringWithFormat:@"%@",dateArr[todayType]]];
    switch (todayType) {
        case 0:{//白
            if (weekday !=2) {//周一
                [string appendString:[NSString stringWithFormat:@"八点上班,十一点半休息,一点上班，四点下班"]];
            }else {
                [string appendString:[NSString stringWithFormat:@"十一点半休息,一点上班，四点下班"]];
            }
        }
            break;
        case 1://白
            if (weekday !=2) {//周一
                [string appendString:[NSString stringWithFormat:@"七点半上班,十一点吃饭,"]];
            }
            if (weekday == 6) {//周五
                [string appendString:@"四点下班"];
            }else{
                [string appendString:@"三点下班"];
            }
            break;
        case 2://白
            if (weekday !=2) {//周一
                [string appendString:[NSString stringWithFormat:@"八点上班,四点多下班"]];
            }else {
                [string appendString:[NSString stringWithFormat:@"十一点半休息,一点上班,四点多下班"]];
            }
            break;
        case 3://夜
            if (weekday == 6) {//周五
                [string appendString:@"三点半上班"];
            }else{
                [string appendString:@"四点上班"];
            }
            break;
        case 4://下
            break;
        case 5://休
            break;
        default:
            break;
    }
    [string appendString:@"。"];
    return string;
}
#pragma mark -
#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}
#pragma mark -
#pragma mark UIAlertViewDelegate
- (IBAction)logAction:(UIButton *)sender {
    UIAlertView *alertView = [[UIAlertView alloc]init];
    [alertView setTitle:@"那您说呢?"];
    alertView.delegate = self;
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView  addButtonWithTitle:@"取消"];
    [alertView addButtonWithTitle:@"确认"];
    [alertView show];
    

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
        [dictionary setObject:@(weekday) forKey:@"weekday"];
        [dictionary setObject:@(todayType) forKey:@"todayType"];
        [dictionary setObject:[_textView.attributedText string] forKey:@"content"];
        [dictionary setObject:[NSDate date] forKey:@"nowDate"];
        UITextField *textField = [alertView textFieldAtIndex:0];
        if (![textField.text isEqualToString:@""]) {
            [dictionary setObject:textField.text forKey:@"right"];
        }else{
            [dictionary setObject:@"大神没给纠正啊" forKey:@"right"];
        }
        [FileUrl insertLogInPlist:dictionary];

        
    }
}
@end
