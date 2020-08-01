//
//  SSKJ_TableView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/10/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_TableView.h"

@implementation SSKJ_TableView




- (instancetype)initWitDeletage:(UIViewController*)delegate
{
    self = [super init];
    if (self)
    {
        [self setDelegate:(id)delegate];
        [self  setDataSource:(id)delegate];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        if (@available(iOS 11.0, *))
        {
            [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
            [self setEstimatedRowHeight:0];
            [self setEstimatedSectionHeaderHeight:0];
            [self setEstimatedSectionFooterHeight:0];
        }
        else
        {
            [delegate setAutomaticallyAdjustsScrollViewInsets:NO];
        }
    }
    return self;
}




- (instancetype)initWithFrame:(CGRect)frame witDeletage:(UIViewController*)delegate
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setDelegate:(id)delegate];
        [self  setDataSource:(id)delegate];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        if (@available(iOS 11.0, *))
        {
            [self setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
            [self setEstimatedRowHeight:0];
            [self setEstimatedSectionHeaderHeight:0];
            [self setEstimatedSectionFooterHeight:0];
        }
        else
        {
            [delegate setAutomaticallyAdjustsScrollViewInsets:NO];
        }
    }
    return self;
}



-(void)endRefresh
{
    [self reloadData];
    if (self.mj_header.state == MJRefreshStateRefreshing)
    {
        [self.mj_header endRefreshing];
    }
    
    if (self.mj_footer.state == MJRefreshStateRefreshing)
    {
        [self.mj_footer endRefreshing];
    }
}



@end
