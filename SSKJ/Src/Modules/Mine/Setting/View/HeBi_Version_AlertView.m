//
//  HeBi_Version_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Version_AlertView.h"

@interface HeBi_Version_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *updateTipLabel;
@property (nonatomic, strong) UILabel *enLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contengLabel;    // 更新内容
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancleBlock)(void);

@end

@implementation HeBi_Version_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
        [self setUI];
    }
    return self;
}

-(void)setUI
{
    [self addSubview:self.alertView];
    [self.alertView addSubview:self.imageView];
    [self.alertView addSubview:self.updateTipLabel];
    [self.alertView addSubview:self.enLabel];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.contengLabel];
    [self.alertView addSubview:self.confirmButton];
    self.alertView.height = self.confirmButton.bottom + ScaleW(30);
    [self addSubview:self.cancleButton];
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(35), 0, ScaleW(305), 0)];
        _alertView.centerX = ScreenWidth / 2;
        _alertView.backgroundColor = kBgColor;
        _alertView.layer.cornerRadius = ScaleW(5);
    }
    return _alertView;
}


-(UILabel *)updateTipLabel
{
    if (nil == _updateTipLabel) {
        _updateTipLabel = [WLTools allocLabel:SSKJLocalized(@"版本更新！",nil) font:systemFont(ScaleW(20)) textColor:kWhiteColor frame:CGRectMake(ScaleW(25), ScaleW(43), self.alertView.width - ScaleW(50), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
        _updateTipLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _updateTipLabel;
}


-(UILabel *)enLabel
{
    if (nil == _enLabel) {
        _enLabel = [WLTools allocLabel:SSKJLocalized(@"Version update",nil) font:systemFont(ScaleW(17)) textColor:kWhiteColor frame:CGRectMake(ScaleW(25), self.updateTipLabel.bottom + ScaleW(15), self.alertView.width - ScaleW(50), ScaleW(17)) textAlignment:NSTextAlignmentLeft];
        _enLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _enLabel;
}



-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.alertView.width, ScaleW(141))];
        _imageView.image = [UIImage imageNamed:SSKJLocalized(@"home_notice_bg", nil)];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"更新内容",nil) font:systemFont(ScaleW(16)) textColor:kTitleColor frame:CGRectMake(ScaleW(25), ScaleW(148), ScaleW(200), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}

-(UILabel *)contengLabel
{
    if (nil == _contengLabel) {
        _contengLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(13.5)) textColor:kTitleColor frame:CGRectMake(ScaleW(25), self.titleLabel.bottom + ScaleW(20), self.alertView.width - ScaleW(50), 0) textAlignment:NSTextAlignmentLeft];
    }
    return _contengLabel;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.contengLabel.bottom + ScaleW(32), self.alertView.width - ScaleW(124), ScaleW(45))];
        _confirmButton.centerX = self.alertView.width / 2;
//        [_confirmButton setImage:[UIImage imageNamed:SSKJLocalized(@"version_update",nil)] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = kBlueColor;
        [_confirmButton setTitle:SSKJLocalized(@"立即升级", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = ScaleW(5);
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}


-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScaleW(40), ScaleW(40))];
        [_cancleButton setImage:[UIImage imageNamed:@"home_x_w"] forState:UIControlStateNormal];
        _cancleButton.centerX = self.alertView.centerX;
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    
    [self hide];
}


+(void)showWithModel:(HeBi_Version_Model *)model confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock
{
    
    HeBi_Version_AlertView *versionAlertView = [[HeBi_Version_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    versionAlertView.confirmBlock = confirmblock;
    versionAlertView.cancleBlock = cancleBlock;
    versionAlertView.titleLabel.text = model.title;
//    versionAlertView.titleLabel.text = model.title;
    [versionAlertView.titleLabel sizeToFit];
    
    versionAlertView.contengLabel.text = model.details;
    CGFloat height = [model.details boundingRectWithSize:CGSizeMake(versionAlertView.contengLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:versionAlertView.contengLabel.font} context:nil].size.height;
    versionAlertView.contengLabel.height = height;
    versionAlertView.contengLabel.y = versionAlertView.titleLabel.bottom + ScaleW(20);
    versionAlertView.confirmButton.y = versionAlertView.contengLabel.bottom + ScaleW(32);
    versionAlertView.alertView.height = versionAlertView.confirmButton.bottom + ScaleW(40);
    versionAlertView.alertView.centerY = ScreenHeight / 2;
    versionAlertView.cancleButton.y = versionAlertView.alertView.bottom + ScaleW(22);
    
    versionAlertView.cancleButton.hidden = model.isForcedUpdate.boolValue;
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:versionAlertView];
}

-(void)cancleEvent
{
    if (self.cancleBlock) {
        self.cancleBlock();
    }
    [self hide];
}

-(void)hide
{
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
