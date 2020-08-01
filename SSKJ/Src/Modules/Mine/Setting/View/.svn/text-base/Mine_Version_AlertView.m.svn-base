//
//  HeBi_Version_AlertView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Mine_Version_AlertView.h"

@interface Mine_Version_AlertView ()
@property (nonatomic, strong) UIView *alertView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *updateTipLabel;
@property (nonatomic, strong) UILabel *enLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) UILabel *contengLabel;    // 更新内容
@property (nonatomic, strong) UIButton *confirmButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, copy) void (^confirmBlock)(void);
@property (nonatomic, copy) void (^cancleBlock)(void);

@end

@implementation Mine_Version_AlertView

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
//    [self.alertView addSubview:self.updateTipLabel];
//    [self.alertView addSubview:self.enLabel];
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.versionLabel];
    [self.alertView addSubview:self.contengLabel];
    [self.alertView addSubview:self.confirmButton];
    [self.alertView addSubview:self.lineView];
    self.alertView.height = self.confirmButton.bottom + ScaleW(30);
    [self.alertView addSubview:self.cancleButton];
    
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(ScaleW(174));
        make.left.equalTo(self.imageView.mas_centerX).offset(ScaleW(5));
        make.width.mas_equalTo(ScaleW(40));
        make.height.mas_equalTo(ScaleW(12));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imageView.mas_centerX).offset(ScaleW(-5));
        make.centerY.equalTo(self.versionLabel);
    }];
}

-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(54), 0, ScreenWidth - ScaleW(108), 0)];
        _alertView.centerX = ScreenWidth / 2;
        _alertView.backgroundColor = kBgColor;
        _alertView.layer.cornerRadius = ScaleW(12);
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
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(31.5), ScaleW(20), self.alertView.width - ScaleW(63), ScaleW(140))];
        _imageView.image = [UIImage imageNamed:SSKJLocalized(@"home_version_bg", nil)];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"最新版本",nil) font:systemFont(ScaleW(16)) textColor:kTitleColor frame:CGRectMake(ScaleW(25), ScaleW(148), ScaleW(200), ScaleW(21)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


-(UILabel *)versionLabel
{
    if (nil == _versionLabel) {
        _versionLabel = [WLTools allocLabel:SSKJLocalized(@"",nil) font:systemFont(ScaleW(12)) textColor:kTitleColor frame:CGRectMake(ScaleW(25), ScaleW(174), ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        _versionLabel.backgroundColor = kBlueColor;
        _versionLabel.layer.cornerRadius = 2.0f;
        _versionLabel.layer.masksToBounds = YES;
    }
    return _versionLabel;
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
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.contengLabel.bottom + ScaleW(32), ScaleW(130), ScaleW(45))];
        _confirmButton.centerX = self.alertView.width / 2;
//        _confirmButton.backgroundColor = kBlueColor;
        [_confirmButton setTitle:SSKJLocalized(@"立即更新", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = ScaleW(5);
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(self.alertView.width / 2, 0, 0.5, ScaleW(15))];
        _lineView.backgroundColor = kSubTitleColor;
        _lineView.centerY = self.confirmButton.centerY;
    }
    return _lineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.contengLabel.bottom + ScaleW(32), ScaleW(130), ScaleW(45))];
        _cancleButton.centerX = self.alertView.width / 2;
//        _cancleButton.backgroundColor = kSubBgColor;
        [_cancleButton setTitle:SSKJLocalized(@"残忍拒绝", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kSubTitleColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _cancleButton.layer.cornerRadius = ScaleW(5);
        [_cancleButton addTarget:self action:@selector(cancleEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(void)confirmEvent
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
}


+(void)showWithModel:(Mine_Version_Model *)model confirmBlock:(void(^)(void))confirmblock cancleBlock:(void(^)(void))cancleBlock
{
    
    Mine_Version_AlertView *versionAlertView = [[Mine_Version_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    versionAlertView.confirmBlock = confirmblock;
    versionAlertView.cancleBlock = cancleBlock;
//    versionAlertView.titleLabel.text = model.title;
//    versionAlertView.titleLabel.text = model.title;
    versionAlertView.titleLabel.width = versionAlertView.alertView.width - ScaleW(50);
    versionAlertView.versionLabel.text = [NSString stringWithFormat:@"V%@",model.vercode];
    [versionAlertView.titleLabel sizeToFit];
    
    versionAlertView.contengLabel.text = model.content;
    CGFloat height = [model.content boundingRectWithSize:CGSizeMake(versionAlertView.contengLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:versionAlertView.contengLabel.font} context:nil].size.height;
    versionAlertView.contengLabel.height = height;
    versionAlertView.contengLabel.y = versionAlertView.imageView.bottom + ScaleW(50);
    versionAlertView.confirmButton.y = versionAlertView.contengLabel.bottom + ScaleW(32);
    
    
    versionAlertView.cancleButton.hidden = (model.uptype.integerValue == 1);

    if (model.uptype.integerValue == 1) {
        versionAlertView.confirmButton.centerX = versionAlertView.alertView.width * 0.5;
        versionAlertView.lineView.hidden = YES;
    }else{
        versionAlertView.lineView.hidden = NO;

        versionAlertView.cancleButton.y = versionAlertView.confirmButton.y;
        versionAlertView.cancleButton.right = versionAlertView.alertView.width * 0.5 - ScaleW(12);
        versionAlertView.confirmButton.left = versionAlertView.alertView.width * 0.5 + ScaleW(12);

    }
    versionAlertView.lineView.centerY = versionAlertView.confirmButton.centerY;

    
    versionAlertView.alertView.height = versionAlertView.confirmButton.bottom + ScaleW(20);
    versionAlertView.alertView.centerY = ScreenHeight / 2;
        
    
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
