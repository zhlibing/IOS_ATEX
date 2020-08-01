//
//  HeYue_BaoCang_AlertView.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/4.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HeYue_BaoCang_AlertView.h"

@interface HeYue_BaoCang_AlertView()

@property (nonatomic,strong) UIView *alertView;

@property (nonatomic,strong) UILabel * titleLabel;

@property (nonatomic,strong) UILabel * detailLabel;

//确认按钮
@property (nonatomic,retain) UIButton *sureBtn;

//取消按钮
@property (nonatomic,retain) UIButton *cancleBtn;

@end

@implementation HeYue_BaoCang_AlertView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message sureBtn:(NSString *)sureTitle cancleBtn:(NSString *)cancleTitle
{
    if (self == [super init]) {
        
        
        self.frame = [UIScreen mainScreen].bounds;
        // 修改蒙版颜色
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        [self alertView];
        
        [self titleLabel];
        
        [self sureBtn];
        
        [self detailLabel];
        
        self.titleLabel.text = title;
        
        self.detailLabel.text = message;
        
        [self.sureBtn setTitle:sureTitle forState:UIControlStateNormal];
        
    }
    
    return self;
}

- (UIView *)alertView
{
    if (_alertView == nil) {
        
        _alertView = [[UIView alloc]init];
        
        _alertView.backgroundColor = kBgColor;
        
        _alertView.layer.masksToBounds = YES;
        
        _alertView.layer.cornerRadius = ScaleW(10);
        
        [self addSubview:_alertView];
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.mas_centerY);
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.height.equalTo(@(ScaleW(180)));
            
        }];
        
    }
    return _alertView;
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"提醒", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        
        [self.alertView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.top.equalTo(@(ScaleW(15)));

            make.height.equalTo(@(ScaleW(15)));

        }];
    }
    return _titleLabel;
}

- (UILabel *)detailLabel
{
    if (_detailLabel == nil) {
        
        _detailLabel = [WLTools allocLabel:SSKJLocalized(@"当风险率小于90%时，系统会自动平仓", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        
        _detailLabel.adjustsFontSizeToFitWidth = YES;
        
        _detailLabel.numberOfLines = 2;
        
        [self.alertView addSubview:_detailLabel];
        
        [_detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.right.equalTo(@(-15));
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(15);
            
            make.bottom.equalTo(self.sureBtn.mas_top).offset(-15);
            
        }];
    }
    return _detailLabel;
}

- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        _sureBtn = [WLTools allocButton:SSKJLocalized(@"确认", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _sureBtn.titleLabel.font = systemFont(ScaleW(14));
        
        _sureBtn.backgroundColor = UIColorFromRGB(0xff5755);
        
        _sureBtn.layer.cornerRadius = 20;
        
        _sureBtn.layer.masksToBounds = YES;
        
        [self.alertView addSubview:_sureBtn];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(@(-15));
            
            make.height.equalTo(@(40));
            
            make.centerX.equalTo(self.alertView.mas_centerX);
            
            make.width.equalTo(@(ScaleW(160)));
            
        }];
    }
    return _sureBtn;
}

- (void)sureBtnAction
{
    [self removeFromSuperview];
}


#pragma mark - 弹出 -
- (void)showAlertView
{
    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation
{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
