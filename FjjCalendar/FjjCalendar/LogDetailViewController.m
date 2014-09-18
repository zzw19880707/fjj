//
//  LogDetailViewController.m
//  FjjCalendar
//
//  Created by tenyea on 14-9-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LogDetailViewController.h"

@interface LogDetailViewController ()

@end

@implementation LogDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_dic) {
        _nowDate.text = [[_dic objectForKey:@"nowDate"] description];
        
        NSString *weekdayStr ;
        switch ([[_dic objectForKey:@"weekday"] intValue]) {
            case 7:
                weekdayStr = @"星期六";
                break;
            case 1:
                weekdayStr = @"星期日";
                break;
            case 2:
                weekdayStr = @"星期一";
                break;
            case 3:
                weekdayStr = @"星期二";
                break;
            case 4:
                weekdayStr = @"星期三";
                break;
            case 5:
                weekdayStr = @"星期四";
                break;
            case 6:
                weekdayStr = @"星期五";
                break;
            default:
                break;
        }
        _weekdayLabel.text = weekdayStr;
    }
    NSArray *dateArr = @[@"第一个白班",@"第二个白班",@"第三个白班",@"夜班",@"下夜",@"休息"];
    _typeLabel.text = dateArr[[[_dic objectForKey:@"todayType"] intValue]];
    
    _contentTextView.text = [_dic objectForKey:@"content"];
    _contentTextView.delegate = self;
    _rightTextView.text = [_dic objectForKey:@"right"];
    _rightTextView.delegate = self;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}



@end
