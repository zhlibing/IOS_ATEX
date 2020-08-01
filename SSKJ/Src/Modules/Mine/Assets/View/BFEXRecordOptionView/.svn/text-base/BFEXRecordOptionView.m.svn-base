//
//  BFEXRecordOptionView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BFEXRecordOptionView.h"

@implementation BFEXRecordOptionView


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.oneControl];
        [self addSubview:self.twoControl];
        [self addSubview:self.threeControl];
        [self addSubview:self.lineView];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self.oneControl resetFrame:CGRectMake(0, 0, frame.size.width/3.0, frame.size.height)];
    [self.twoControl resetFrame:CGRectMake(self.oneControl.right, self.oneControl.top, self.oneControl.width, self.oneControl.height)];
    [self.threeControl resetFrame:CGRectMake(self.twoControl.right, self.twoControl.top, self.twoControl.width, self.twoControl.height)];
    
    [self.lineView setFrame:CGRectMake((frame.size.width- ScaleW(50))/2.0, frame.size.height-ScaleW(1.0), ScaleW(50),ScaleW(1.0))];
}


-(void)optionItemControl:(BFEXRecordOptionItemControl*)sender
{
    [self.oneControl setItemSelect:NO];
    [self.twoControl setItemSelect:NO];
    [self.threeControl setHidden:NO];
    switch (sender.tag)
    {
        case 1:
        {
            [self.oneControl setItemSelect:YES];
        }
            break;
        case 2:
        {
            [self.twoControl setItemSelect:YES];
        }
            break;
        case 3:
        {
            [self.threeControl setItemSelect:YES];
        }
            break;
    }
    
    [UIView animateWithDuration:0.15 animations:^{
        
        [self.lineView setCenterX:sender.centerX];
        [self.lineView setCenterY:(sender.bottom-ScaleW(1.0))];
    }];
    
}




#pragma mark - Getter / Setter
-(BFEXRecordOptionItemControl *)oneControl
{
    if (!_oneControl)
    {
        _oneControl = [[BFEXRecordOptionItemControl alloc]init];
        [_oneControl addTarget:self action:@selector(optionItemControl:) forControlEvents:UIControlEventTouchUpInside];
        [_oneControl setTag:1];
    }
    return _oneControl;
}

-(BFEXRecordOptionItemControl *)twoControl
{
    if (!_twoControl)
    {
        _twoControl = [[BFEXRecordOptionItemControl alloc]init];
        [_twoControl addTarget:self action:@selector(optionItemControl:) forControlEvents:UIControlEventTouchUpInside];
        [_twoControl setTag:2];
    }
    return _twoControl;
}

-(BFEXRecordOptionItemControl *)threeControl
{
    if (!_threeControl)
    {
        _threeControl = [[BFEXRecordOptionItemControl alloc]init];
        [_threeControl addTarget:self action:@selector(optionItemControl:) forControlEvents:UIControlEventTouchUpInside];
        [_threeControl setTag:3];
    }
    return _threeControl;
}


-(UIView *)lineView
{
    if (!_lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kBlueColor];
    }
    return _lineView;
}




@end
