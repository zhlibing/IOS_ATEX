//
//  alertSelectView.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/4/13.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "alertSelectView.h"

#define cellHeight 30.f
#define cellWidth  80.f
#define labeltag(a)  100000 + a
@implementation alertSelectView
-(instancetype)init
{
    self = [super init];
    if (self)
    {
        self.backgroundColor= kSubBgColor;
    }
    return self;
}

-(void)setAllCountIndex:(NSInteger)allCountIndex
{
   
    
}

-(void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    self.frame = CGRectMake(0, 0, cellWidth, dataArray.count * cellHeight);
    for (int i = 0; i<_dataArray.count; i++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, i*cellHeight, cellWidth, cellHeight)];
        [self label:label font:14 textColor:kTitleColor text:dataArray[i]];
        label.tag = labeltag(i);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addSubview:label];
        label.textAlignment = NSTextAlignmentCenter;
        label.backgroundColor = [UIColor clearColor];
        label.userInteractionEnabled = YES;
        [label addGestureRecognizer:tap];
    }
}
-(void)tapAction:(UITapGestureRecognizer *)tap
{
    UILabel *l = (UILabel *)tap.view;
    NSInteger index = l.tag - labeltag(0);
    self.selectIndexBlock(index);
    self.hidden = YES;
}
@end
