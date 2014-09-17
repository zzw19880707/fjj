//
//  LogDetailViewController.h
//  FjjCalendar
//
//  Created by tenyea on 14-9-17.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface LogDetailViewController : TenyeaBaseViewController <UITextViewDelegate>
@property (nonatomic,strong) NSDictionary *dic ;
@property (strong, nonatomic) IBOutlet UILabel *nowDate;
@property (strong, nonatomic) IBOutlet UILabel *weekdayLabel;
@property (strong, nonatomic) IBOutlet UILabel *typeLabel;
@property (strong, nonatomic) IBOutlet UITextView *contentTextView;
@property (strong, nonatomic) IBOutlet UITextView *rightTextView;

@end
