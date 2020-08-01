//
//  HeBi_Default_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "SSKJ_Default_AlertView.h"

@interface SSKJ_Default_AlertView ()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIImageView *showView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *lineView2;

@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *confirmButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@end

@implementation SSKJ_Default_AlertView


-(instancetype)init
{
    if (self = [super initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)]) {
        
        
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.messageLabel];
//        [self.showView addSubview:self.lineView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];

        self.showView.height = self.confirmButton.bottom + ScaleW(22);
        self.showView.centerY = ScreenHeight / 2 - 20;
        
        
        
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
        _showView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, self.width - ScaleW(30), ScaleW(190))];
        _showView.backgroundColor = kBgColor;
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
        _titleLabel = [WLTools allocLabel:@"退出登录" font:systemFont(ScaleW(17)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(30), self.showView.width - ScaleW(30), ScaleW(17)) textAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.titleLabel.bottom+ScaleW(28), self.showView.width - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        _messageLabel.numberOfLines = 0;
    }
    return _messageLabel;
}

- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), self.titleLabel.bottom+ScaleW(10), self.showView.width - ScaleW(24), 0.5)];
        _lineView.backgroundColor = kLineColor;
        
       _lineView2 = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(12), _messageLabel.bottom+ScaleW(10), self.showView.width - ScaleW(24), 0.5)];
        [self.showView addSubview:_lineView2];
        
        _lineView2.backgroundColor = kLineColor;
    }
    return _lineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(35), self.messageLabel.bottom + ScaleW(44), (self.showView.width - ScaleW(90)) * 0.5, ScaleW(40))];
        [_cancleButton setTitle:SSKJLocalized(@"取消",nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemFont(ScaleW(14));
        _cancleButton.layer.masksToBounds = YES;
        _cancleButton.layer.cornerRadius = ScaleW(5);
        _cancleButton.layer.borderWidth = 1;
        _cancleButton.layer.borderColor = kSubTitleColor.CGColor;
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancleButton.right + ScaleW(20), self.cancleButton.y, self.cancleButton.width, self.cancleButton.height)];
        [_confirmButton setTitle:SSKJLocalized(@"确定",nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemFont(ScaleW(14));
        _confirmButton.layer.masksToBounds = YES;
        _confirmButton.layer.cornerRadius = ScaleW(5);
        _confirmButton.backgroundColor = kBlueColor;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

+(void)showWithTitle:(NSString *)title message:(NSString *)message cancleTitle:(NSString *)cancleTitle confirmTitle:(NSString *)confirmTitle confirmBlock:(nonnull void (^)(void))confirmblock
{
    
    SSKJ_Default_AlertView *alertView = [[SSKJ_Default_AlertView alloc]init];
    
    alertView.confirmBlock = confirmblock;
    alertView.titleLabel.text = title;
    alertView.messageLabel.text = message;
    [alertView.confirmButton setTitle:confirmTitle forState:UIControlStateNormal];
    CGFloat height = [message boundingRectWithSize:CGSizeMake(alertView.messageLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:alertView.messageLabel.font} context:nil].size.height;
    alertView.messageLabel.height = height;
    
    
    alertView.cancleButton.y = alertView.messageLabel.bottom + ScaleW(44);
    alertView.confirmButton.y = alertView.messageLabel.bottom + ScaleW(44);

    alertView.showView.height = alertView.confirmButton.bottom + ScaleW(22);
    alertView.showView.centerY = ScreenHeight / 2 - 20;
    
    if (cancleTitle.length == 0) {
        alertView.cancleButton.hidden = YES;
        
        alertView.confirmButton.centerX = alertView.showView.width * 0.5;
    }else{
            
        [alertView.cancleButton setTitle:cancleTitle forState:UIControlStateNormal];

        alertView.cancleButton.hidden = NO;
    }
    
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
    if (self.confirmBlock) {
        self.confirmBlock();
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
