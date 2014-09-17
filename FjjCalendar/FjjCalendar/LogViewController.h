//
//  LogViewController.h
//  FjjCalendar
//
//  Created by tenyea on 14-9-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "TenyeaBaseViewController.h"

@interface LogViewController : TenyeaBaseViewController <UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
- (IBAction)deleteAllLog:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
