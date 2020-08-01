//
//  Heyue_AllPingCang_AlertView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/5.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_AllPingCang_AlertView.h"

@interface Heyue_AllPingCang_AlertView()

@property (nonatomic, strong) UIView *showView;

@property(nonatomic, strong)UILabel *titleLabel;

@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *lineView;

@property (nonatomic, strong) UIButton *cancleButton;           // 取消按钮

@property (nonatomic, strong) UIButton *confirmButton;          // 确认按钮

@end

@implementation Heyue_AllPingCang_AlertView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.frame = [UIScreen mainScreen].bounds;
        // 修改蒙版颜色
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
        [self.showView addSubview:self.lineView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];

    }
    return self;
}


-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(30), ScaleW(200))];
        _showView.backgroundColor = kBgColor;
        _showView.layer.cornerRadius = ScaleW(10);
        _showView.layer.masksToBounds = YES;
    }
    return _showView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel createWithText:SSKJLanguage(@"提醒") textColor:kTitleColor font:kBoldFont(17)];
        _titleLabel.frame = CGRectMake(ScaleW(15), ScaleW(25), self.showView.width, ScaleW(20));
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, ScaleW(70), self.showView.width, ScaleW(15))];
        _messageLabel.font = [UIFont systemFontOfSize:ScaleW(15)];
        _messageLabel.textColor = kTitleColor;
        _messageLabel.numberOfLines = 2;
        _messageLabel.adjustsFontSizeToFitWidth = YES;
        _messageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _messageLabel;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(20), self.showView.height - ScaleW(65), self.showView.width / 2 - 40, ScaleW(40))];
        _cancleButton.layer.cornerRadius = ScaleW(5);
        
         _cancleButton.layer.borderColor = kBlueColor.CGColor;
        
        _cancleButton.layer.borderWidth = 1;
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancleButton.right + ScaleW(30), self.cancleButton.y, self.cancleButton.width, self.cancleButton.height)];
        _confirmButton.backgroundColor = kBlueColor;
        _confirmButton.layer.cornerRadius = ScaleW(5);
        _confirmButton.layer.masksToBounds = YES;
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirmAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(void)showWithMessage:(NSString *)message
{
    self.messageLabel.text = message;
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.showView.layer.position = self.center;
    self.showView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.showView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}


-(void)hide
{
    [self removeFromSuperview];
}

- (void)confirmAction{
    if (self.AllPingCangBlock) {
        self.AllPingCangBlock();
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
