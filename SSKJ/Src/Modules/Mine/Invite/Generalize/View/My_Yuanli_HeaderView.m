//
//  My_Yuanli_HeaderView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/25.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_HeaderView.h"

@interface My_Yuanli_HeaderView ()

@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *numLabel;
@property (nonatomic, strong) UILabel *timeLabel;
//@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation My_Yuanli_HeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = kSubBgColor;
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    
    [self addSubview:self.typeLabel];
    [self addSubview:self.numLabel];
    [self addSubview:self.timeLabel];
    
        
}




-(UILabel *)typeLabel
{
    if (nil == _typeLabel) {
        

        _typeLabel = [WLTools allocLabel:SSKJLocalized(@"返佣类型", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(96), self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _typeLabel;
}

-(UILabel *)numLabel
{
    if (nil == _numLabel) {

        CGFloat width = ScaleW(80);

        _numLabel = [WLTools allocLabel:SSKJLocalized(@"数量", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.typeLabel.right, 0, width, self.height) textAlignment:NSTextAlignmentLeft];
    }
    return _numLabel;
}
-(UILabel *)timeLabel
{
    if (nil == _timeLabel) {
        
        CGFloat width = ScreenWidth - ScaleW(15) - self.numLabel.right;

        _timeLabel = [WLTools allocLabel:SSKJLocalized(@"时间", nil) font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.numLabel.right, 0, width, self.height) textAlignment:NSTextAlignmentRight];
    }
    return _timeLabel;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
