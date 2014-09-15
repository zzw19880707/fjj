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
//        判断时间
//
        /**
         *  中心时间早于当前时间
         */
        if ([nowDate earlierDate:date]) {
            _po(@"中心时间早于当前时间");
        }
        /**
         *  中心时间等于当前时间
         */
        else if ([nowDate isEqualToDate:date]){
            _po(@"中心时间等于当前时间");
        }
        /**
         *  中心时间晚育当前时间
         */
        else{
            _po(@"中心时间晚于当前时间");
            
        }
        
        
    }
}
#pragma mark -
#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
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
    label.text = [NSString stringWithFormat:@"{%d,%d}",indexPath.section,indexPath.row];
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
