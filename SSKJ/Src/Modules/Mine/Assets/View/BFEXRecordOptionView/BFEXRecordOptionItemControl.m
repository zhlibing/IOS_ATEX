//
//  BFEXRecordOptionItemControl.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BFEXRecordOptionItemControl.h"

@implementation BFEXRecordOptionItemControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.titleLabel];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self.titleLabel setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
}




//!< 设置选中状态
-(void)setItemSelect:(BOOL)select
{
    if (select)
    {
        [self.titleLabel setTextColor:kTitleColor];
    }
    else
    {
        [self.titleLabel setTextColor:kSubTitleColor];
    }
}




@end
