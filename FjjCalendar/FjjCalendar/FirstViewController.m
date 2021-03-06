//
//  FirstViewController.m
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "FirstViewController.h"
#import "Date.h"
@interface FirstViewController ()

@end

@implementation FirstViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"设置";
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    if ([Date defaultDate].currentDate) {
        self.datePicker.date = [Date defaultDate].currentDate;
        self.currentTime.text = [dateFormatter stringFromDate:[[Date defaultDate] currentDate]];
    }else{
        NSString *strDate = [dateFormatter stringFromDate: [NSDate date]];
        self.currentTime.text = strDate;
        self.datePicker.date = [NSDate date];
    }
    
}



- (IBAction)valueChange:(UIDatePicker *)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *strDate = [dateFormatter stringFromDate:sender.date];
    self.currentTime.text = strDate;
}

- (IBAction)createAction {
    [Date defaultDate].currentDate = self.datePicker.date;
    [self.sideMenuViewController setContentViewController:[[UINavigationController alloc] initWithRootViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"zeroViewController"]] animated:NO];
    
}
@end
