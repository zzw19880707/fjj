//
//  ZeroViewController.h
//  FjjCalendar
//
//  Created by tenyea on 14-9-15.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface ZeroViewController : TenyeaBaseViewController <UITextViewDelegate,UIAlertViewDelegate>
@property (strong, nonatomic) IBOutlet UITextView *textView;
- (IBAction)logAction:(UIButton *)sender;

@end
