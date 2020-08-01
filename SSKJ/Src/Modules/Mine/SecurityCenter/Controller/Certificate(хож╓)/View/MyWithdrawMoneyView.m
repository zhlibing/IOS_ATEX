//
//  MyWithdrawMoneyView.m
//  SSKJ
//
//  Created by mac on 2019/9/12.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MyWithdrawMoneyView.h"
@interface MyWithdrawMoneyView()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation MyWithdrawMoneyView

-(instancetype)initWithFrame:(CGRect )frame title:(NSString *)title placeHolder:(NSString *)placeHolder keyBoardType:(UIKeyboardType)keyBoardType
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kBgColor;
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.textView];
        [self addSubview:self.lineView];
        [self.textView setPlaceholder:placeHolder];
        [self.textView setKeyboardType:keyBoardType];
        
#pragma mark 重置Frame
        [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(10), frame.size.width-ScaleW(20), ScaleW(30))];
        
        [self.textView setFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom+ScaleW(10), self.titleLabel.width - ScaleW(30), ScaleW(40))];
        
        if (title==nil) {
            
            [self.titleLabel setFrame:CGRectMake(ScaleW(10), ScaleW(10), frame.size.width-ScaleW(20), ScaleW(0))];
            [self.textView setFrame:CGRectMake(self.titleLabel.left, ScaleW(10), self.titleLabel.width, ScaleW(40))];
        }
        self.textView.placeholderColor = kSubTitleColor;
        [self.lineView setFrame:CGRectMake(self.textView.left, frame.size.height-ScaleW(0.5), self.textView.width, ScaleW(0.5))];
        
        
#pragma mark 赋值
        [self.titleLabel setText:SSKJLocalized(title, nil)];
    }
    return self;
}


-(UILabel *)titleLabel
{
    
    if (nil == _titleLabel)
    {
        _titleLabel  = [[UILabel alloc]init];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setFont:systemFont(ScaleW(16.0))];
    }
    return _titleLabel;
}

-(FSTextView *)textView
{
    if (nil == _textView)
    {
        _textView = [[FSTextView alloc]init];
        _textView.textColor = kTitleColor;
        _textView.font = systemFont(ScaleW(15));
        
        
    }
    return _textView;
}

-(UIView *)lineView
{
    if (nil == _lineView)
    {
        _lineView = [[UIView alloc]init];
        [_lineView setBackgroundColor:kLineColor];
    }
    return _lineView;
}

-(NSString *)valueString
{
    return self.textView.text;
}

-(void)setValueString:(NSString *)valueString
{
    self.textView.text = valueString;
}


@end
