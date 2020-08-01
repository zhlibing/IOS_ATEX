//
//  HeyueTime_Confirm_View.h
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "HeyueTime_Confirm_View.h"

#define fontSize   13
#define kLeft_Gap   ScaleW(25)
#define kMiddle_Gap ScaleW(12)

@interface HeyueTime_Confirm_View()
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *showView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *firstLineView;
@property (nonatomic, strong) UILabel *statusTitleLabel;        // 方向：做多做空
@property (nonatomic, strong) UILabel *statusLabel;
//@property (nonatomic, strong) UILabel *typeTitleLabel;          // 类型：市价、限价
//@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *priceTitleLabel;         // 价格
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) UILabel *numberTitleLabel;        // 数量
@property (nonatomic, strong) UILabel *numberLabel;
@property (nonatomic, strong) UILabel *baozhengjinTitle;        // 保证金
@property (nonatomic, strong) UILabel *baozhengjinLabel;
@property (nonatomic, strong) UILabel *shouxufeiTitle;        // 手续费
@property (nonatomic, strong) UILabel *shouxufeiLabel;
@property (nonatomic, strong) UILabel *leverageTitle;       // 杠杆倍数
@property (nonatomic, strong) UILabel *leverageLabel;
@property (nonatomic, strong) UILabel *zhiyingTitle;       //止盈价
@property (nonatomic, strong) UILabel *zhiyingLabel;

@property (nonatomic, strong) UILabel *zhisunTitle;       //止损价
@property (nonatomic, strong) UILabel *zhisunLabel;

@property (nonatomic, strong) UIView *secondLineView;
@property (nonatomic, strong) UIButton *cancleButton;           // 取消按钮
@property (nonatomic, strong) UIButton *confirmButton;          // 确认按钮

@property (nonatomic, strong) NSMutableDictionary *dic;

@end

@implementation HeyueTime_Confirm_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backView];
        [self addSubview:self.showView];
        [self.showView addSubview:self.titleLabel];
        [self.showView addSubview:self.firstLineView];
        [self.showView addSubview:self.statusTitleLabel];
        [self.showView addSubview:self.statusLabel];
//        [self.showView addSubview:self.typeTitleLabel];
//        [self.showView addSubview:self.typeLabel];
        [self.showView addSubview:self.priceTitleLabel];
        [self.showView addSubview:self.priceLabel];
        [self.showView addSubview:self.numberTitleLabel];
        [self.showView addSubview:self.numberLabel];
        [self.showView addSubview:self.baozhengjinTitle];
        [self.showView addSubview:self.baozhengjinLabel];
        [self.showView addSubview:self.shouxufeiTitle];
        [self.showView addSubview:self.shouxufeiLabel];
        [self.showView addSubview:self.leverageTitle];
        [self.showView addSubview:self.leverageLabel];
//        [self.showView addSubview:self.zhiyingTitle];
//        [self.showView addSubview:self.zhiyingLabel];
//        [self.showView addSubview:self.zhisunTitle];
//        [self.showView addSubview:self.zhisunLabel];
        [self.showView addSubview:self.secondLineView];
        [self.showView addSubview:self.cancleButton];
        [self.showView addSubview:self.confirmButton];
        self.showView.height = self.confirmButton.bottom + ScaleW(30);
        self.showView.centerX = ScreenWidth / 2;
        self.showView.centerY = ScreenHeight / 2;
    }
    return self;
}

-(UIView *)backView
{
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.3;
    }
    return _backView;
}

-(UIView *)showView
{
    if (nil == _showView) {
        _showView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth - ScaleW(44), 0)];
        _showView.backgroundColor = kBgColor;
        _showView.layer.cornerRadius = 4.0f;
        _showView.layer.masksToBounds = YES;
    }
    return _showView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kLeft_Gap, ScaleW(22), self.showView.width - kLeft_Gap, ScaleW(16))];
        _titleLabel.textColor = kTitleColor;
        _titleLabel.text = SSKJLocalized(@"下单确认", nil);
        _titleLabel.font = systemBoldFont(ScaleW(17));
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

-(UIView *)firstLineView
{
    if (nil == _firstLineView) {
        _firstLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(7), self.showView.width, 0.5)];
        _firstLineView.backgroundColor = kBgColor;
        _firstLineView.hidden = YES;
    }
    return _firstLineView;
}


-(UILabel *)statusTitleLabel
{
    if (nil == _statusTitleLabel) {
        _statusTitleLabel = [self createLabelWithFrame:CGRectMake(kLeft_Gap, self.firstLineView.bottom + ScaleW(25), ScaleW(70), ScaleW(fontSize)) textColor:kSubTitleColor];
        _statusTitleLabel.text = SSKJLocalized(@"方向", nil);
        
    }
    return _statusTitleLabel;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [self createLabelWithFrame:CGRectMake(self.statusTitleLabel.right - 10 , self.statusTitleLabel.y, self.showView.width / 2 - ScaleW(5) - 2 * kLeft_Gap - self.statusTitleLabel.width + ScaleW(15), self.statusTitleLabel.height) textColor:kTitleColor];
        _statusLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    return _statusLabel;
}

//-(UILabel *)typeTitleLabel
//{
//    if (nil == _typeTitleLabel) {
//        _typeTitleLabel = [self createLabelWithFrame:CGRectMake(kLeft_Gap + self.showView.width / 2, self.firstLineView.bottom + ScaleW(25), self.statusTitleLabel.width , self.statusLabel.height) textColor:kSubTitleColor];
//        _typeTitleLabel.text = SSKJLocalized(@"类型", nil);
//
//    }
//    return _typeTitleLabel;
//}

//-(UILabel *)typeLabel
//{
//    if (nil == _typeLabel) {
//        _typeLabel = [self createLabelWithFrame:CGRectMake(self.typeTitleLabel.right + ScaleW(5), self.typeTitleLabel.y, self.statusLabel.width + ScaleW(8), self.typeTitleLabel.height) textColor:kTitleColor];
//        _typeLabel.adjustsFontSizeToFitWidth = YES;
//    }
//    return _typeLabel;
//}

-(UILabel *)priceTitleLabel
{
    if (nil == _priceTitleLabel) {
        _priceTitleLabel = [self createLabelWithFrame:CGRectMake(self.statusTitleLabel.x, self.statusTitleLabel.bottom + kMiddle_Gap, self.statusTitleLabel.width, self.statusTitleLabel.height) textColor:kSubTitleColor];
        _priceTitleLabel.text = SSKJLocalized(@"价格", nil);
        
    }
    return _priceTitleLabel;
}

-(UILabel *)priceLabel
{
    if (nil == _priceLabel) {
        _priceLabel = [self createLabelWithFrame:CGRectMake(self.statusLabel.x, self.priceTitleLabel.y, self.statusLabel.width + 40, self.statusTitleLabel.height) textColor:kTitleColor];
        
    }
    return _priceLabel;
}

-(UILabel *)numberTitleLabel
{
    if (nil == _numberTitleLabel) {
//        _numberTitleLabel = [self createLabelWithFrame:CGRectMake(self.typeTitleLabel.x, self.priceTitleLabel.y, self.statusTitleLabel.width, self.statusLabel.height) textColor:kSubTitleColor];
        _numberTitleLabel = [self createLabelWithFrame:CGRectMake(kLeft_Gap + self.showView.width / 2, self.priceTitleLabel.y, self.statusTitleLabel.width , self.statusLabel.height) textColor:kSubTitleColor];

        _numberTitleLabel.text = SSKJLocalized(@"数量", nil);
        
    }
    return _numberTitleLabel;
}

-(UILabel *)numberLabel
{
    if (nil == _numberLabel) {
        _numberLabel = [self createLabelWithFrame:CGRectMake(self.numberTitleLabel.right + ScaleW(5), self.numberTitleLabel.y, self.statusLabel.width + ScaleW(8), self.numberTitleLabel.height) textColor:kTitleColor];
        
    }
    return _numberLabel;
}

-(UILabel *)baozhengjinTitle
{
    if (nil == _baozhengjinTitle) {
        _baozhengjinTitle = [self createLabelWithFrame:CGRectMake(self.statusTitleLabel.x, self.priceTitleLabel.bottom + kMiddle_Gap, self.statusTitleLabel.width, self.statusTitleLabel.height) textColor:kSubTitleColor];
        _baozhengjinTitle.text = SSKJLocalized(@"保证金", nil);
        
    }
    return _baozhengjinTitle;
}

-(UILabel *)baozhengjinLabel
{
    if (nil == _baozhengjinLabel) {
        _baozhengjinLabel = [self createLabelWithFrame:CGRectMake(self.statusLabel.x, self.baozhengjinTitle.y, self.priceLabel.width, self.statusTitleLabel.height) textColor:kTitleColor];
        _baozhengjinLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _baozhengjinLabel;
}

-(UILabel *)shouxufeiTitle
{
    if (nil == _shouxufeiTitle) {
        _shouxufeiTitle = [self createLabelWithFrame:CGRectMake(self.statusTitleLabel.x, self.baozhengjinTitle.bottom + kMiddle_Gap, self.statusTitleLabel.width, self.statusTitleLabel.height) textColor:kSubTitleColor];
        _shouxufeiTitle.text = SSKJLocalized(@"手续费", nil);
        _shouxufeiTitle.hidden = YES;
        
    }
    return _shouxufeiTitle;
}

-(UILabel *)shouxufeiLabel
{
    if (nil == _shouxufeiLabel) {
        _shouxufeiLabel = [self createLabelWithFrame:CGRectMake(self.statusLabel.x, self.shouxufeiTitle.y, self.priceLabel.width, self.statusTitleLabel.height) textColor:kTitleColor];
        _shouxufeiLabel.adjustsFontSizeToFitWidth = YES;
        _shouxufeiLabel.hidden = YES;
    }
    return _shouxufeiLabel;
}

-(UILabel *)zhiyingTitle
{
    if (nil == _zhiyingTitle) {
        _zhiyingTitle = [self createLabelWithFrame:CGRectMake(self.statusTitleLabel.x, self.baozhengjinTitle.bottom + kMiddle_Gap, self.statusTitleLabel.width, self.statusTitleLabel.height) textColor:kSubTitleColor];
        _zhiyingTitle.text = SSKJLocalized(@"止盈价", nil);
        
    }
    return _zhiyingTitle;
}

-(UILabel *)zhiyingLabel
{
    if (nil == _zhiyingLabel) {
        _zhiyingLabel = [self createLabelWithFrame:CGRectMake(self.statusLabel.x, self.zhiyingTitle.y, self.priceLabel.width, self.statusTitleLabel.height) textColor:kTitleColor];
        _zhiyingLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _zhiyingLabel;
}


-(UILabel *)zhisunTitle
{
    if (nil == _zhisunTitle) {
        _zhisunTitle = [self createLabelWithFrame:CGRectMake(self.numberTitleLabel.x, self.zhiyingTitle.y, self.statusTitleLabel.width, self.statusTitleLabel.height) textColor:kSubTitleColor];
        _zhisunTitle.text = SSKJLocalized(@"止损价", nil);
        
    }
    return _zhisunTitle;
}

-(UILabel *)zhisunLabel
{
    if (nil == _zhisunLabel) {
        _zhisunLabel = [self createLabelWithFrame:CGRectMake(self.numberLabel.x, self.zhiyingTitle.y, self.numberLabel.width, self.numberLabel.height) textColor:kTitleColor];
        _zhisunLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _zhisunLabel;
}


-(UILabel *)leverageTitle
{
    if (nil == _leverageTitle) {
        _leverageTitle = [self createLabelWithFrame:CGRectMake(self.numberTitleLabel.x, self.baozhengjinTitle.y, self.statusTitleLabel.width, self.statusLabel.height) textColor:kSubTitleColor];
        _leverageTitle.text = SSKJLocalized(@"杠杆倍数", nil);
        
    }
    return _leverageTitle;
}

-(UILabel *)leverageLabel
{
    if (nil == _leverageLabel) {
        _leverageLabel = [self createLabelWithFrame:CGRectMake(self.numberLabel.x, self.leverageTitle.y, self.numberLabel.width, self.numberLabel.height) textColor:kTitleColor];
        
    }
    return _leverageLabel;
}
-(UIView *)secondLineView
{
    if (nil == _secondLineView) {
        _secondLineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.shouxufeiTitle.bottom + ScaleW(32), self.firstLineView.width, 0.5)];
        _secondLineView.backgroundColor = kBgColor;
        _secondLineView.hidden = YES;
    }
    return _secondLineView;
}

-(UIButton *)cancleButton
{
    if (nil == _cancleButton) {
        _cancleButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.secondLineView.bottom, self.showView.width / 2 - ScaleW(30), ScaleW(45))];
        _cancleButton.layer.borderColor = kBlueColor.CGColor;
        _cancleButton.layer.borderWidth = ScaleW(1);
        _cancleButton.cornerRadius = ScaleW(5);
        _cancleButton.titleLabel.font = systemFont(16);
        [_cancleButton setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        [_cancleButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        [_cancleButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(self.cancleButton.right+ ScaleW(30), self.cancleButton.y, self.cancleButton.width, self.cancleButton.height)];
        _confirmButton.titleLabel.font = systemFont(16);
        _confirmButton.cornerRadius=ScaleW(5);
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _confirmButton.backgroundColor = kWhiteColor;
        _confirmButton.backgroundColor = kBlueColor;
        [_confirmButton setTitle:SSKJLocalized(@"确认", nil) forState:UIControlStateNormal];
        [_confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [_confirmButton setBackgroundImage:[UIImage imageNamed:@"confirm"] forState:UIControlStateNormal];
    }
    return _confirmButton;
}

-(UILabel *)createLabelWithFrame:(CGRect)frame textColor:(UIColor *)textColor
{
    UILabel *label = [[UILabel alloc]initWithFrame:frame];
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:ScaleW(fontSize)];
    return label;
}

- (void)setIsTimer:(BOOL)isTimer{
    _isTimer = isTimer;
}

-(void)showWithData:(NSDictionary *)data

{
    _dic = [data mutableCopy];
    [_dic setValue:self.selectCycleTime forKey:@"cycleTime"];
    //是否是时间合约
    if (self.isTimer) {
        self.statusTitleLabel.text = SSKJLocalized(@"期数", nil);
        self.priceTitleLabel.text  =SSKJLocalized(@"方向", nil);
        self.numberTitleLabel.text = SSKJLocalized(@"价格", nil);
        self.leverageTitle.text = SSKJLocalized(@"持仓周期", nil);

          
        self.statusLabel.text = [NSString stringWithFormat:@"%@", data[@"cycleNum"]];
//        self.numberLabel.text = [WLTools noroundingStringWith:[data[@"buyMoney"]  doubleValue] afterPointNumber:8];
        self.numberLabel.text = @"--";

        self.baozhengjinLabel.text = data[@"bondMoney"] ;
        
        NSArray *array = [data[@"cycleTime"] componentsSeparatedByString:@","];
        NSString *str = [NSString stringWithFormat:SSKJLanguage(@"%@分钟"), data[@"cycleTime"] ? array[0] : @"-"];
        self.leverageLabel.text = str;
        if (self.selectCycleTime.length) {
                    self.leverageLabel.text = [NSString stringWithFormat:SSKJLanguage(@"%@分钟"), self.selectCycleTime ? self.selectCycleTime : @"-"];
        }

//        self.leverageLabel.backgroundColor = KRedColor;
        self.priceLabel.text = [data[@"billType"] integerValue] == 0 ? SSKJLocalized(@"买涨", nil):SSKJLocalized(@"买跌", nil);
        
        if (([data[@"billType"] integerValue] == 0)) {
            self.priceLabel.text = SSKJLocalized(@"买涨", nil);
            self.priceLabel.textColor = KgreenColor;
        }else{
            self.priceLabel.text = SSKJLocalized(@"买跌", nil);
            self.priceLabel.textColor = KRedColor;
        }
        
        
        
        self.leverageLabel.textColor = kTitleColor;
        
    }
    
    
    

    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    
    [window addSubview:self];
    
    [self creatShowAnimation];
}

- (void)setSelectCycleTime:(NSString *)selectCycleTime {
    _selectCycleTime = selectCycleTime;


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

-(void)confirm
{
    if (self.confirmBlock) {
        self.confirmBlock(self.dic);
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
