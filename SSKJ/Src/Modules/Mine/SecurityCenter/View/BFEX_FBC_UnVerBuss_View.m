//
//  BFEX_FBC_UnVerBuss_View.m
//  ZYW_MIT
//
//  Created by James on 2018/6/29.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEX_FBC_UnVerBuss_View.h"

@implementation BFEX_FBC_UnVerBuss_View

#pragma mark - 初始化
-(instancetype)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    if (self)
    {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        self.hidden=YES;
        
        [self setLayout];
        
    }
    
    return self;
}

#pragma mark - 创建UI
- (void)setLayout
{
    //弹出框
    [self alertView];
    
    //标题
    [self titleLabel];
    
    
    //信息内容1
    [self msgLabel1];
    
    
    //信息内容2
    [self msgLabel2];

    
    
    //取消按钮
    [self cancelButon];
    
    
    //确定按钮
    [self sureButton];
    
    //分割线
    [self lineView];
    
    
    
}

#pragma mark - 分割线
-(UIView *)lineView
{
    if (_lineView==nil)
    {
        _lineView=[[UIView alloc] init];
        
        _lineView.backgroundColor=[WLTools stringToColor:@"#eeeeee"];
        
        [self.alertView addSubview:_lineView];
        
        [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.bottom.equalTo(self.cancelButon.mas_top);
            
            make.height.equalTo(@0.5);
            
            make.left.equalTo(self.alertView.mas_left);
            
            make.right.equalTo(self.alertView.mas_right);
        }];
    }
    
    return _lineView;
}

#pragma mark - 标题
-(UILabel *)titleLabel
{
    if (_titleLabel==nil)
    {
        _titleLabel=[[UILabel alloc] init];
        
        _titleLabel.font=systemFont(ScaleW(18.0));
        
        _titleLabel.textColor=[WLTools stringToColor:@"#11324c"];
        
        _titleLabel.text=SSKJLocalized(@"解除商家认证", nil);
        
        [self.alertView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.alertView.mas_centerX);
            
            make.top.equalTo(self.alertView.mas_top).offset(23);
        }];
    }
    
    return _titleLabel;
}

#pragma mark - 信息内容1
-(UILabel *)msgLabel1
{
    if (_msgLabel1==nil)
    {
        _msgLabel1=[[UILabel alloc] init];
        
        _msgLabel1.numberOfLines=0;
        
        _msgLabel1.text=SSKJLocalized(@"解除详情", nil);
        
        _msgLabel1.font = systemFont(ScaleW(14.0));
        
        _msgLabel1.textColor=[WLTools stringToColor:@"#85959b"];
        
        [self.alertView addSubview:_msgLabel1];
        
        [_msgLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.alertView.mas_left).offset(10);
            
            make.right.equalTo(self.alertView.mas_right).offset(-10);
            
            make.centerX.equalTo(self.alertView.mas_centerX);
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(19);
        }];
    }
    
    return _msgLabel1;
}


#pragma mark - 信息内容2
-(UILabel *)msgLabel2
{
    if (_msgLabel2==nil)
    {
        _msgLabel2=[[UILabel alloc] init];
        
        _msgLabel2.numberOfLines=0;
        
        _msgLabel2.text=SSKJLocalized(@"解除详情一", nil);
        
        _msgLabel2.font=systemFont(ScaleW(14.0));
        
        _msgLabel2.textColor=[WLTools stringToColor:@"#85959b"];
        
        [self.alertView addSubview:_msgLabel2];
        
        [_msgLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.alertView.mas_left).offset(10);
            
            make.right.equalTo(self.alertView.mas_right).offset(-10);
            
            make.centerX.equalTo(self.alertView.mas_centerX);
            
            make.top.equalTo(self.msgLabel1.mas_bottom).offset(25);
        }];
    }
    
    return _msgLabel2;
}

#pragma mark - 取消按钮
-(UIButton *)cancelButon
{
    if (_cancelButon==nil)
    {
        
        _cancelButon=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_cancelButon setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        
        [_cancelButon setTitleColor:[WLTools stringToColor:@"#98a5a8"] forState:UIControlStateNormal];
        
        [_cancelButon addTarget:self action:@selector(cancelButton_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertView addSubview:_cancelButon];
        
        [_cancelButon mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.height.equalTo(@50);
            
            make.bottom.equalTo(self.alertView.mas_bottom);
            
            make.left.equalTo(self.alertView.mas_left);
            
            make.width.equalTo(@((ScreenWidth-25*2)/2));
            
        }];
    }
    
    return _cancelButon;
}

#pragma mark - 确认
-(UIButton *)sureButton
{
    if (_sureButton==nil)
    {
        _sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_sureButton setTitle:SSKJLocalized(@"申请", nil) forState:UIControlStateNormal];
        
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_sureButton setBackgroundColor:[UIColor redColor]];
        
        [_sureButton addTarget:self action:@selector(sureButton_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.alertView addSubview:_sureButton];
        
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.cancelButon.mas_right);
            
            make.top.equalTo(self.cancelButon.mas_top);
            
            make.bottom.equalTo(self.cancelButon.mas_bottom);
            
            make.width.equalTo(self.cancelButon.mas_width);
            
            make.right.equalTo(self.alertView.mas_right);
        }];
        
    }
    
    return _sureButton;
}


#pragma mark - 弹出层
-(UIView *)alertView
{
    if (_alertView==nil)
    {
        _alertView=[[UIView alloc] init];
        
        _alertView.layer.cornerRadius=2.5;
        
        _alertView.layer.masksToBounds=YES;
        
        _alertView.backgroundColor=[UIColor whiteColor];
        
        [self addSubview:_alertView];
        
        [_alertView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@25.0);
            
            make.centerY.equalTo(self.mas_centerY);
            
            make.width.equalTo(@(ScreenWidth-25*2));
            
            make.height.equalTo(@350);
        }];
    }
    
    return _alertView;
}


#pragma mark - 设置显示/隐藏
- (void)hide:(BOOL)hidden
{
    CATransition *animation = [CATransition animation];
    
    animation.duration = 0.3;
    
    animation.type = kCATransitionFade;
    
    [self.layer addAnimation:animation forKey:nil];
    
    self.hidden = hidden;
}

#pragma mark - 取消按钮 点击事件
-(void)cancelButton_Event:(UIButton *)sender
{
    [self hide:YES];
}

#pragma mark - 确认按钮 点击事件
-(void)sureButton_Event:(UIButton *)sender
{
    if (self.sureButtonBlock)
    {
        self.sureButtonBlock();
    }
}


#pragma mark - 手势点击事件
- (void)tapAction:(UITapGestureRecognizer *)tap
{
    [self hide:YES];
}

@end
