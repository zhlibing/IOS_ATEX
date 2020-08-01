//
//  ZG_Notice_UpDown_View.m
//  zgxygj
//
//  Created by james on 2018/4/22.
//  Copyright © 2018年 WeiLv Technology. All rights reserved.
//

#import "ZG_Notice_UpDown_View.h"

#import "ZG_UpDownViews.h"

@interface ZG_Notice_UpDown_View()<CAAnimationDelegate>

@property (strong, nonatomic) ZG_UpDownViews *updownView;

@property (strong, nonatomic) NSArray *updownDataArray;

@end

@implementation ZG_Notice_UpDown_View

static int countInt=0;

static NSString *notice_index;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
- (void)createUI
{
    self.backgroundColor = [UIColor clearColor];
 
    //[self updownView];
    
    
    self.updownView = [[ZG_UpDownViews alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topNewsInfoClicked:)];
    self.updownView.userInteractionEnabled = YES;
    [self.updownView addGestureRecognizer:tap];
    [self addSubview:self.updownView];
    
    [self.updownView mas_makeConstraints:^(MASConstraintMaker *make)
     {
         make.top.left.right.equalTo(self);
         make.height.mas_equalTo(self.mas_height);
     }];
    
}

//-(ZG_UpDownViews *)updownView
//{
//    if (_updownView==nil)
//    {
//        _updownView = [[ZG_UpDownViews alloc] init];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(topNewsInfoClicked:)];
//        _updownView.userInteractionEnabled = YES;
//        [_updownView addGestureRecognizer:tap];
//        [self addSubview:_updownView];
//
//        [_updownView mas_makeConstraints:^(MASConstraintMaker *make)
//         {
//             make.top.left.right.equalTo(self);
//             make.height.mas_equalTo(self.mas_height);
//         }];
//    }
//
//    return _updownView;
//}



- (void)setViewWithUpDownArray:(NSArray *)upDownArray
{
    self.updownDataArray = upDownArray;
    
    [self setUpdownViewData];
}

#pragma mark ==== 上下滚动视图

- (void)setUpdownViewData
{
    if (self.updownDataArray.count>0)
    {
        notice_index=[self.updownDataArray objectAtIndex:0];
        
        [self.updownView setViewWithTitle:notice_index];
        [UIView animateWithDuration:0.7 delay:0 options:0 animations:^(){
            self.updownView.alpha = 0.2;
            [self.updownView exchangeSubviewAtIndex:1 withSubviewAtIndex:0];
            self.updownView.alpha = 1;
        } completion:^(BOOL finished){
            //设置定时器
            [NSTimer scheduledTimerWithTimeInterval:4.0 target:self selector:@selector(displayNews) userInfo:nil repeats:YES];
        }];
    }
   
    
  
}

-(void)displayNews
{
    countInt++;
 
    if (countInt >= [self.updownDataArray count])
        countInt=0;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = 0.5f ;
    
    animation.timingFunction = UIViewAnimationCurveEaseInOut;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    animation.type = @"cube";
    
    if (self.updownDataArray.count>0)
    {
        notice_index=[self.updownDataArray objectAtIndex:countInt];
        
        [self.updownView.layer addAnimation:animation forKey:@"animationID"];
        [self.updownView setViewWithTitle:notice_index];
    }
    
 
    
    
    
}
//点击上下滚动视图
-(void)topNewsInfoClicked:(id)sender
{
    
    if (self.clickNoticeUpDownBlock)
    {
        self.clickNoticeUpDownBlock(countInt);
    }
}

@end
