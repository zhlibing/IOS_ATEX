//
//  HeYue_EditWinLoss_AlertView.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//
//修改弹框  设置止盈 止损
#import "HeYue_EditWinLoss_AlertView.h"
#import "Heyue_PriceAdjust_View.h"

@interface HeYue_EditWinLoss_AlertView()<UITextFieldDelegate>

@property (nonatomic,strong) UIView *alertView;

@property (nonatomic,strong) UILabel * typeTitle;

@property (nonatomic,strong) UILabel * typelabel;

@property (nonatomic,strong) UILabel * nowPriceTitle;

@property (nonatomic,strong) UILabel * nowPriceLabel;

@property(nonatomic, strong)Heyue_PriceAdjust_View *zhiyingView;

@property(nonatomic, strong)Heyue_PriceAdjust_View *zhisunView;

@property (nonatomic,strong) UIButton * cancelBtn;

@property (nonatomic,strong) UIButton * sureBtn;

@property (nonatomic,strong) Heyue_OrderDdetail_Model * orderModel;

@property (nonatomic,assign) NSInteger type;

@end

@implementation HeYue_EditWinLoss_AlertView

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
        
        [self nowPriceTitle];
        
        [self nowPriceLabel];
        
//        UIView *line = [UIView new];
//        line.backgroundColor = kLineColor;
//        [self.alertView addSubview:line];
//        [line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_equalTo(ScaleW(20));
//            make.right.mas_equalTo(ScaleW(-20));
//            make.top.equalTo(self.typeTitle.mas_bottom).offset(ScaleW(30));
//            make.height.mas_equalTo(ScaleW(0.5));
//        }];
        
        [self zhiyingView];
        
        [self zhisunView];
                
        [self cancelBtn];
        
        [self sureBtn];
        
    }
    return self;
}

- (UIView *)alertView{
    if (_alertView == nil) {
        _alertView = [[UIView alloc]init];
        _alertView.backgroundColor = kBgColor;
        _alertView.layer.masksToBounds = YES;
        _alertView.layer.cornerRadius = ScaleW(10);
        [self addSubview:_alertView];
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY).offset(-10);
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
            make.height.equalTo(@(ScaleW(260)));
        }];
    }
    return _alertView;
}

- (UILabel *)typeTitle{
    if (_typeTitle == nil) {
        _typeTitle = [WLTools allocLabel:SSKJLocalized(@"方向", nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _typeTitle.adjustsFontSizeToFitWidth = YES;
        [self.alertView addSubview:_typeTitle];
        [_typeTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.top.equalTo(@(ScaleW(24)));
            make.width.equalTo(@(ScaleW(40)));
        }];
    }
    return _typeTitle;
}

- (UILabel *)typelabel{
    if (_typelabel == nil) {
        _typelabel = [WLTools allocLabel:SSKJLocalized(@"做空", nil) font:systemFont(ScaleW(15)) textColor:kMarketDown frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _typelabel.adjustsFontSizeToFitWidth = YES;
        [self.alertView addSubview:_typelabel];
        [_typelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeTitle.mas_right).offset(ScaleW(5));
            make.centerY.equalTo(self.typeTitle.mas_centerY);
            make.width.equalTo(@(ScaleW(40)));
        }];
    }
    return _typelabel;
}

- (UILabel *)nowPriceTitle{
    if (_nowPriceTitle == nil) {
        _nowPriceTitle = [WLTools allocLabel:SSKJLocalized(@"最新价", nil) font:systemFont(ScaleW(15)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _nowPriceTitle.adjustsFontSizeToFitWidth = YES;
        [self.alertView addSubview:_nowPriceTitle];
        [_nowPriceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.alertView.mas_centerX);
            make.centerY.equalTo(self.typeTitle.mas_centerY);
            make.width.equalTo(@(ScaleW(55)));
//            make.height.equalTo(@(ScaleW(15)));
        }];
    }
    return _nowPriceTitle;
}

- (UILabel *)nowPriceLabel{
    if (_nowPriceLabel == nil) {
        _nowPriceLabel = [WLTools allocLabel:SSKJLocalized(@"0.00", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        _nowPriceLabel.adjustsFontSizeToFitWidth = YES;
        [self.alertView addSubview:_nowPriceLabel];
        [_nowPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(245)));
            make.top.equalTo(@(ScaleW(25)));
            make.right.equalTo(@(ScaleW(-15)));
            
        }];
    }
    return _nowPriceLabel;
}

- (Heyue_PriceAdjust_View *)zhiyingView{
    if (!_zhiyingView) {
        _zhiyingView = [[Heyue_PriceAdjust_View alloc] initWithTitle:SSKJLanguage(@"止盈价")];
        [self.alertView addSubview:_zhiyingView];
        _zhiyingView.isZhiYing = YES;
        [_zhiyingView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.typeTitle.mas_bottom).offset(ScaleW(25));
            make.left.mas_equalTo(ScaleW(20));
//            make.right.mas_equalTo(ScaleW(-110));
            make.right.mas_equalTo(ScaleW(-20));
            make.height.mas_equalTo(ScaleW(44));
        }];

    }
    return _zhiyingView;
}

- (Heyue_PriceAdjust_View *)zhisunView{
    if (!_zhisunView) {
        _zhisunView = [[Heyue_PriceAdjust_View alloc] initWithTitle:SSKJLanguage(@"止损价")];
        [self.alertView addSubview:_zhisunView];
        _zhisunView.isZhiYing = NO;

        [_zhisunView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.zhiyingView.mas_bottom).offset(ScaleW(10));
            make.left.mas_equalTo(ScaleW(20));
            make.right.equalTo(self.zhiyingView);
            make.height.mas_equalTo(ScaleW(44));
        }];
        
    }
    return _zhisunView;
}

- (UIButton *)cancelBtn{
    if (_cancelBtn == nil) {
        _cancelBtn = [WLTools allocButton:SSKJLocalized(@"取消", nil) textColor:kBlueColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_cancelBtn addTarget:self action:@selector(cancelBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _cancelBtn.titleLabel.font = systemFont(ScaleW(15));
        _cancelBtn.layer.cornerRadius = ScaleW(5);
        _cancelBtn.layer.borderWidth = 1;
        _cancelBtn.layer.borderColor = kBlueColor.CGColor;

        [self.alertView addSubview:_cancelBtn];
        [_cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(20)));
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-23));
            make.height.equalTo(@(ScaleW(40)));
            make.width.equalTo(@(ScaleW(130)));
        }];
    }
    return _cancelBtn;
}

- (UIButton *)sureBtn{
    if (_sureBtn == nil) {
        _sureBtn = [WLTools allocButton:SSKJLocalized(@"确认", nil) textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectZero];
        [_sureBtn addTarget:self action:@selector(sureBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _sureBtn.titleLabel.font = systemFont(ScaleW(15));
        _sureBtn.backgroundColor = kBlueColor;
        _sureBtn.layer.cornerRadius = ScaleW(5);
        _sureBtn.layer.masksToBounds = YES;
        [self.alertView addSubview:_sureBtn];
        [_sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(@(ScaleW(-20)));
            
            make.bottom.equalTo(self.alertView.mas_bottom).offset(ScaleW(-25));
            
            make.height.equalTo(@(ScaleW(40)));
            
            make.width.equalTo(@(ScaleW(130)));
        }];
    }
    return _sureBtn;
}

- (void)cancelBtnAction{
    [self removeFromSuperview];
}

- (void)sureBtnAction
{
//    double zhiying = self.zhiyingView.field.text.doubleValue;
//    double zhisun = self.zhisunView.field.text.doubleValue;
//
//
//    if (self.orderModel.buyBillType.intValue == 2) {//做多
//        //止盈必须大于：最新价+最小止盈
//
//        if (zhiying < [_orderModel.marketPrice doubleValue] + [self.setModel.minStopProfit doubleValue]) {
//
//        }
//
//        //止损必须小于：最新价-最小止损
//        if (zhisun > [_orderModel.marketPrice doubleValue] - [self.setModel.minStopLoss doubleValue]) {
//
//        }
//    }else{//做空
//        //止盈必须小于：最新价-最小止盈
//        if (zhiying > [_orderModel.marketPrice doubleValue] - [self.setModel.minStopProfit doubleValue]) {
//
//        }
//
//        if (zhisun < [_orderModel.marketPrice doubleValue] + [self.setModel.minStopLoss doubleValue]) {
//
//        }
//
//    }
    

    
    if (self.EditWinLossBlock) {
        self.EditWinLossBlock(self.zhiyingView.field.text.length ? self.zhiyingView.field.text : @"0", self.zhisunView.field.text.length ? self.zhisunView.field.text : @"0");
    }
    
    [self removeFromSuperview];

}

#pragma mark - 弹出 -
- (void)showAlertView{

    UIWindow *rootWindow = [UIApplication sharedApplication].keyWindow;
    [rootWindow addSubview:self];
    [self creatShowAnimation];
}

- (void)creatShowAnimation{
    self.alertView.layer.position = self.center;
    self.alertView.transform = CGAffineTransformMakeScale(0.90, 0.90);
    [UIView animateWithDuration:0.25 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:1 options:UIViewAnimationOptionCurveLinear animations:^{
        self.alertView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    } completion:^(BOOL finished) {
    }];
}

-(void)updateNowPriceUI:(Heyue_OrderWinLoss_Model *)model nowPrice:(NSString *)nowPrice{
    
    
    self.orderModel.marketPrice = nowPrice;
    
    self.nowPriceLabel.text = [SSTool HeyueCoin:_orderModel.code price:_orderModel.marketPrice];

}
#pragma mark 填充数据
- (void)setViewWithOrderDic:(Heyue_OrderDdetail_Model *)orderModel{
    self.orderModel = orderModel;
    
    self.zhiyingView.field.text = [WLTools noroundingStringWith:orderModel.stopwin.doubleValue afterPointNumber:[SSTool MarketPrice:orderModel.code]];
    self.zhisunView.field.text = [WLTools noroundingStringWith:orderModel.stoploss.doubleValue afterPointNumber:[SSTool MarketPrice:orderModel.code]];
        
    self.type = orderModel.otype.integerValue;
    
    self.typelabel.text = [NSString stringWithFormat:@"%@",self.type == 1?SSKJLocalized(@"做多", nil):SSKJLocalized(@"做空", nil)];

    self.typelabel.textColor = self.type == 1?kMarketUp:kMarketDown;

    self.nowPriceLabel.text = [SSTool HeyueCoin:orderModel.code price:orderModel.marketPrice];
    
    self.zhiyingView.coin = orderModel.code;
    self.zhisunView.coin = orderModel.code;
    
}

    
- (void)setSetModel:(Heyue_Leverage_Model *)setModel{
    _setModel = setModel;
    
}

@end
