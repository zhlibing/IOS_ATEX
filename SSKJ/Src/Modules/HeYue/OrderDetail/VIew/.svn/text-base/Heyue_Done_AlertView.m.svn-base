//
//  Heyue_Done_AlertView.m
//  SSKJ
//
//  Created by zpz on 2019/9/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_Done_AlertView.h"

@interface Heyue_Done_AlertView()

@property (nonatomic,strong) UIView *alertView;


@property (nonatomic,strong) UILabel * typeTitle;

@property (nonatomic,strong) UILabel * typelabel;

@property (nonatomic,strong) UILabel * PriceTitle;

@property (nonatomic,strong) UILabel * PriceLabel;

@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UILabel * messageLabel;


@property (nonatomic,strong) UIButton * cancelBtn;

@property (nonatomic,strong) UIButton * sureBtn;


@property (nonatomic,strong) Heyue_OrderDdetail_Model *weituoModel;//数据

@end

@implementation Heyue_Done_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.frame = [UIScreen mainScreen].bounds;
        // 修改蒙版颜色
        self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
        
        [self alertView];
        
        
        [self typeTitle];
        
        [self typelabel];
        
        
        [self PriceTitle];
        
        [self PriceLabel];
        
        [self lineView];
        
        [self messageLabel];
        
        
        
        [self cancelBtn];
        
        [self sureBtn];
        
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
            
            make.centerY.equalTo(self.mas_centerY).offset(-ScaleW(10));
            
            make.left.equalTo(@(ScaleW(15)));
            
            make.right.equalTo(@(ScaleW(-15)));
            
            make.height.equalTo(@(ScaleW(220)));
            
        }];
        
    }
    return _alertView;
}


- (UILabel *)typeTitle
{
    if (_typeTitle == nil) {
        _typeTitle = [WLTools allocLabel:SSKJLocalized(@"方向", nil) font:systemFont(ScaleW(14)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        
        _typeTitle.adjustsFontSizeToFitWidth = YES;
        
        [self.alertView addSubview:_typeTitle];
        
        [_typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(ScaleW(50)));
            
            make.top.equalTo(@(ScaleW(30)));
            
            make.width.equalTo(@(ScaleW(40)));
            
            make.height.equalTo(@(ScaleW(20)));
            
        }];
    }
    return _typeTitle;
}

- (UILabel *)typelabel
{
    if (_typelabel == nil) {
        
        _typelabel = [WLTools allocLabel:SSKJLocalized(@"做空", nil) font:systemFont(ScaleW(14)) textColor:kMarketDown frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        
        _typelabel.adjustsFontSizeToFitWidth = YES;
        
        [self.alertView addSubview:_typelabel];
        
        [_typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.typeTitle.mas_right).offset(ScaleW(5));
            
            make.top.equalTo(self.typeTitle);
            
            make.width.equalTo(@(ScaleW(40)));
            
            make.height.equalTo(@(ScaleW(20)));
            
        }];
    }
    return _typelabel;
}


- (UILabel *)PriceLabel
{
    if (_PriceLabel == nil) {
        
        _PriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.00", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentRight];
        
        _PriceLabel.adjustsFontSizeToFitWidth = YES;
        
        [self.alertView addSubview:_PriceLabel];
        
        [_PriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.alertView.mas_right).offset(ScaleW(-50));
            make.centerY.equalTo(self.typeTitle.mas_centerY);
            make.left.greaterThanOrEqualTo(self.alertView.mas_left).offset(ScaleW(-240));
        }];
    }
    return _PriceLabel;
}
- (UILabel *)PriceTitle
{
    if (_PriceTitle == nil) {
        _PriceTitle = [WLTools allocLabel:SSKJLocalized(@"最新价", nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentRight];
        
        _PriceTitle.adjustsFontSizeToFitWidth = YES;
        
        [self.alertView addSubview:_PriceTitle];
        
        [_PriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.PriceLabel.mas_left).offset(ScaleW(-12));
            make.centerY.equalTo(self.typeTitle.mas_centerY);
            make.width.equalTo(@(ScaleW(54)));
        }];
    }
    return _PriceTitle;
}



- (UIView *)lineView
{
    if (_lineView == nil) {
        
        _lineView = [[UIView alloc]init];
        
        _lineView.backgroundColor = kLineColor;
        
        [self.alertView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.PriceTitle.mas_bottom).offset(ScaleW(10));
            
            make.left.equalTo(@(ScaleW(18)));
            
            make.right.equalTo(@(ScaleW(-18)));
            
            make.height.equalTo(@(ScaleW(1)));
            
        }];
    }
    return _lineView;
}

- (UILabel *)messageLabel
{
    if (_messageLabel == nil) {
        
        _messageLabel = [WLTools allocLabel:SSKJLocalized(@"是否确认要平仓？", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentCenter];
        
        _messageLabel.adjustsFontSizeToFitWidth = YES;
        
        _messageLabel.numberOfLines = 1;
        
        _messageLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.alertView addSubview:_messageLabel];
        
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeTitle.mas_bottom).offset(ScaleW(40));
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
        }];
    }
    return _messageLabel;
}


- (UIButton *)cancelBtn
{
    if (_cancelBtn == nil) {
        
        _cancelBtn = [WLTools allocButton:SSKJLocalized(@"取消", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        
        _cancelBtn.titleLabel.font = systemFont(ScaleW(15));
        
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _cancelBtn.layer.cornerRadius = ScaleW(5);
        
        _cancelBtn.layer.borderWidth = 1;
        
        
        _cancelBtn.layer.borderColor = kBlueColor.CGColor;
        
        [self.alertView addSubview:_cancelBtn];
        
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-23));
            make.height.equalTo(@(ScaleW(40)));
            make.width.equalTo(@(ScaleW(136)));
        }];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn
{
    if (_sureBtn == nil) {
        
        _sureBtn = [WLTools allocButton:SSKJLocalized(@"确认", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        
        _sureBtn.backgroundColor = kBlueColor;
        
        _sureBtn.titleLabel.font = systemFont(ScaleW(15));
        
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        
        _sureBtn.layer.cornerRadius = ScaleW(5);
        
        _sureBtn.layer.masksToBounds = YES;
        
        [self.alertView addSubview:_sureBtn];
        
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(@(ScaleW(-18)));
            
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-23));
            
            make.height.equalTo(@(ScaleW(40)));
            
            make.width.equalTo(@(ScaleW(136)));
            
        }];
    }
    return _sureBtn;
}


- (void)cancelBtnAction
{
    [self removeFromSuperview];
}

- (void)sureBtnAction
{
    if (self.DoneBlock) {
        self.DoneBlock(self.weituoModel);
    }
    
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

- (void)initDataWithWeituoModel:(Heyue_OrderDdetail_Model *)weituoModel{
    self.weituoModel = weituoModel;
    
    NSString *type = weituoModel.otype;
    
    self.typelabel.text = [NSString stringWithFormat:@"%@",type.integerValue == 1?SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil)];
    
    self.typelabel.textColor = type.integerValue == 1?kMarketUp:kMarketDown;
    
    self.PriceLabel.text = [SSTool HeyueCoin:weituoModel.code price:weituoModel.buyprice];
    
    
}


-(void)setNePrice:(NSString *)nePrice
{
    _nePrice = nePrice;
    
    
    self.PriceLabel.text = [SSTool HeyueCoin:_weituoModel.code price:nePrice];
}


@end
