//
//  My_ContractUs_AlertView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_ContractUs_AlertView.h"

@interface My_ContractUs_AlertView ()


@property (nonatomic, strong) UIView *alertView;// 弹框
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;
// 确认按钮
@property (nonatomic, strong) UIButton *confirmButton;
//关闭
@property(nonatomic,strong) UIButton *cancelButton;
@property(nonatomic,strong) UILabel *cancelLabel;
@end

@implementation My_ContractUs_AlertView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:[UIScreen mainScreen].bounds];
    if (self) {
        [self setUI];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    self.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    
    [self addSubview:self.alertView];
    
    [self.alertView addSubview:self.titleLabel];
    [self.alertView addSubview:self.messageLabel];
    [self.alertView addSubview:self.confirmButton];
    
    self.alertView.centerY = ScreenHeight / 2;
    [self addSubview:self.cancelButton];
    [self addSubview:self.cancelLabel];
    
}


-(UIView *)alertView
{
    if (nil == _alertView) {
        _alertView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), 0, ScreenWidth - ScaleW(30), ScaleW(200))];
        _alertView.backgroundColor = kBgColor;
        _alertView.layer.cornerRadius = 8.0f;
    }
    return _alertView;
}


- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel  = [FactoryUI createLabelWithFrame:CGRectMake(0, ScaleW(27), self.alertView.width, ScaleW(17)) text:SSKJLocalized(@"取消交易", nil) textColor:kTitleColor font:systemBoldFont(ScaleW(17))];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        _messageLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(10), self.titleLabel.bottom + ScaleW(25), self.alertView.width - ScaleW(20), ScaleW(15)) text:SSKJLocalized(@"是否确认要取消当前交易？", nil) textColor:kTitleColor font:systemBoldFont(ScaleW(15))];
    }
    return _messageLabel;
}



#pragma mark - 确认
-(UIButton *)confirmButton
{
    if (_confirmButton==nil)
    {
        _confirmButton=[[UIButton alloc]initWithFrame:CGRectMake(0, self.alertView.height - ScaleW(71), ScaleW(160), ScaleW(45))];
        
        _confirmButton.centerX = self.alertView.width / 2;
        
        [_confirmButton setTitle:SSKJLocalized(@"确定", nil) forState:UIControlStateNormal];
        
        _confirmButton.titleLabel.font = systemFont(ScaleW(14));
        
        [_confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_confirmButton setBackgroundColor:[UIColor redColor]];
        
        _confirmButton.layer.cornerRadius = ScaleW(6);
        
        _confirmButton.layer.masksToBounds=YES;
        
        [_confirmButton addTarget:self action:@selector(confirmButton_Event) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _confirmButton;
}



#pragma mark - 取消label

-(UILabel *)cancelLabel
{
    if (nil == _cancelLabel) {
        _cancelLabel  = [FactoryUI createLabelWithFrame:CGRectMake(0, self.cancelButton.bottom + ScaleW(8), ScaleW(100), ScaleW(13)) text:SSKJLocalized(@"取消", nil) textColor:[UIColor redColor] font:systemFont(ScaleW(13))];
        
    
        _cancelLabel.centerX = self.cancelButton.centerX;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
        [_cancelLabel addGestureRecognizer:tap];
        
    }
    return _cancelLabel;
}

#pragma mark - 取消按钮
-(UIButton *)cancelButton
{
    if (_cancelButton==nil)
    {
        
        UIImage *image=[UIImage imageNamed:@"quxiao-gb"];
        
        _cancelButton=[[UIButton alloc]initWithFrame:CGRectMake(0, self.alertView.bottom + ScaleW(27), ScaleW(27), ScaleW(27))];
        _cancelButton.centerX = self.alertView.centerX;
        
        _cancelButton.layer.cornerRadius = ScaleW(27) / 2;
        
        _cancelButton.layer.borderColor = [UIColor redColor].CGColor;
        
        _cancelButton.layer.borderWidth = 1.0f;
        
        [_cancelButton setImage:image forState:UIControlStateNormal];
        
        [_cancelButton addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _cancelButton;
}


#pragma mark - 确认点击
-(void)confirmButton_Event
{
    if (self.confirmBlock) {
        self.confirmBlock();
    }
    
    [self hide];
}


-(void)showWithTitle:(NSString *)title message:(NSString *)message
{
    self.titleLabel.text = title;
    self.messageLabel.text = message;
    
    CGFloat height = [message boundingRectWithSize:CGSizeMake(self.messageLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.messageLabel.font} context:nil].size.height;
    self.messageLabel.height = height;
    self.confirmButton.y = self.messageLabel.bottom + ScaleW(40);
    self.alertView.height = self.confirmButton.bottom + ScaleW(40);
    self.alertView.centerY = self.height / 2 - ScaleW(30);
    self.cancelButton.y = self.alertView.bottom + ScaleW(25);
    self.cancelLabel.y = self.cancelButton.bottom + ScaleW(10);
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
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
