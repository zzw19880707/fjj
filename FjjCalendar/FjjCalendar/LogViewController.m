//
//  LogViewController.m
//  FjjCalendar
//
//  Created by tenyea on 14-9-16.
//  Copyright (c) 2014年 zzw. All rights reserved.
//

#import "LogViewController.h"
#import "FileUrl.h"
#import "LogDetailViewController.h"
@interface LogViewController ()
{
    NSArray *_dataArr;
}
@end

@implementation LogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"出错日志";
    _dataArr = [FileUrl selectAllLog];
    _po(_dataArr);
    [_tableView reloadData];
}

- (IBAction)deleteAllLog:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"其实我有强迫症" message:@"你确定要删除么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

//UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [FileUrl deleteAllLog];
        [_tableView reloadData];
    }
}

//UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArr count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentity = @"cellIdentity";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentity];

    NSDate *date =  [[_dataArr  objectAtIndex:indexPath.row] objectForKey:@"nowDate"];
    cell.textLabel.text = [date description];
    return cell;
}

//UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    LogDetailViewController *Vc = [self.storyboard instantiateViewControllerWithIdentifier:@"logDetailViewController"];
    Vc.dic = [_dataArr objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:Vc animated:YES];
}

@end
