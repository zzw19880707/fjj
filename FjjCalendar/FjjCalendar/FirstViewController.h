//
//  FirstViewController.h
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"
#import "RESideMenu.h"

@interface FirstViewController : TenyeaBaseViewController
@property (strong, nonatomic) IBOutlet UILabel *currentTime;
- (IBAction)valueChange:(UIDatePicker *)sender;
- (IBAction)createAction;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@end
