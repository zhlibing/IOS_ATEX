//
//  BI_Sign_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/7/2.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "BI_Sign_AlertView.h"

@interface BI_Sign_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UILabel *countDownLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancleButton;


@property (nonatomic, assign) NSInteger countDownTime;
@end

@implementation BI_Sign_AlertView


-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
        [self.showView addSubview:self.countDownLabel];
        [self addSubview:self.cancleButton];
        
        self.showView.centerY = ScreenHeight / 2;
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:self.bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.7;
        
    }
    return _backView;
}

-(UIImageView *)showView
{
    if (nil == _showView) {
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(12), 0, self.width - ScaleW(24), ScaleW(190))];
        _showView.backgroundColor = kSubBgColor;
        _showView.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
        _showView.layer.masksToBounds = YES;
        _showView.layer.cornerRadius = 6.0f;
        _showView.userInteractionEnabled = YES;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"签到成功", nil) font:systemFont(ScaleW(16)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(30), self.showView.width - ScaleW(30), ScaleW(16)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(30), self.showView.width - ScaleW(30), ScaleW(30)) textAlignment:NSTextAlignmentCenter];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

-(UILabel *)countDownLabel
{
    if (nil == _countDownLabel) {
        _countDownLabel = [WLTools allocLabel:@"" font:systemThinFont(ScaleW(10)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom + ScaleW(30), self.showView.width - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _countDownLabel.numberOfLines = 0;
    }
    return _countDownLabel;
}

- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), 0, self.showView.width - ScaleW(24), 0.5)];
        _lineView.backgroundColor = kSubTitleColor;
    }
    return _lineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.showView.bottom + ScaleW(14),ScaleW(34), ScaleW(34))];
        _cancleButton.layer.masksToBounds = YES;
        [_cancleButton setImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
        _cancleButton.centerX = self.showView.centerX;

        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}


+(void)showWithNumber:(NSString *)number;
{
    
    BI_Sign_AlertView *alertView = [[BI_Sign_AlertView alloc]init];
    
    alertView.messageLabel.text = [NSString stringWithFormat:SSKJLocalized(@"签到成功，送BIB%@个", nil),number];
    
    alertView.messageLabel.attributedText = [WLTools setAttributeTextWithString:alertView.messageLabel.text colorString:number color:UIColorFromRGB(0xd5a566)];
    
    CGFloat height = [alertView.messageLabel.text boundingRectWithSize:CGSizeMake(alertView.messageLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:alertView.messageLabel.font} context:nil].size.height;
    alertView.messageLabel.height = height;
    if (alertView.messageLabel.text.length == 0) {
        alertView.lineView.y = alertView.titleLabel.bottom + ScaleW(26);
    }
    alertView.countDownLabel.y = alertView.messageLabel.bottom + ScaleW(10);
    
    
    alertView.showView.height = alertView.countDownLabel.bottom + ScaleW(20);
    alertView.showView.centerY = ScreenHeight / 2;
    
    alertView.cancleButton.y = alertView.showView.bottom + ScaleW(20);

    
    alertView.countDownTime = 6;
    [alertView couneDown];
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:alertView];
}

-(void)hide
{
    [self removeFromSuperview];
}


-(void)confirmEvent
{
    [self hide];
}


-(void)couneDown
{
    self.countDownTime--;
    
    if (self.countDownTime > 0) {
        self.countDownLabel.text = [NSString stringWithFormat:SSKJLocalized(@"%lds后自动关闭...", nil) ,self.countDownTime];
        [self performSelector:@selector(couneDown) withObject:nil afterDelay:1];
    }else{
        [self hide];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
