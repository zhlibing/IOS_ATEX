//
//  BFEX_System_Version_View.m
//  ZYW_MIT
//
//  Created by James on 2018/7/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEX_System_Version_View.h"

@implementation BFEX_System_Version_View

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
    [self mainView];
 
    //图标
    [self versionIMV];
    
    //标题
    [self titleLabel];
    

    //取消
    [self cancelButton];
    
    //确认
    [self sureButton];
    

    
    //信息
    [self msgTextView];
    
    [self guanbilabel];
    
    
}
#pragma mark - 主视图
-(UIView *)mainView
{
    if (_mainView==nil)
    {
        UIImage *image=[UIImage imageNamed:@"bfex_version_bg"];
        
        CGFloat leftSpace=(ScreenWidth-image.size.width)/2;
        
        _mainView=[[UIView alloc] init];
        
        _mainView.backgroundColor=kBgColor;
        
        _mainView.layer.masksToBounds=YES;
        
        _mainView.layer.cornerRadius=5.0;
        
        [self addSubview:_mainView];
        
        [_mainView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@(leftSpace));
            
            make.centerY.equalTo(self.mas_centerY);
            
            make.width.equalTo(@(image.size.width));
            
            make.height.equalTo(@380);
        }];
    }
    
    return _mainView;
}


#pragma mark - 图标
-(UIImageView *)versionIMV
{
    if (_versionIMV==nil)
    {
        UIImage *image=[UIImage imageNamed:@"bfex_version_bg"];
        
        _versionIMV=[[UIImageView alloc] initWithImage:image];
        
        [self.mainView addSubview:_versionIMV];
        
        [_versionIMV mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.top.equalTo(@0);
            
            make.width.equalTo(@(image.size.width));
            
            make.height.equalTo(@(image.size.height));
        }];
    }
    
    return _versionIMV;
}

#pragma mark - 标题
-(UILabel *)titleLabel
{
    if (_titleLabel==nil)
    {
        _titleLabel=[[UILabel alloc] init];
        
        _titleLabel.font=systemFont(ScaleW(18.0));
        
        _titleLabel.text=@"";
        
        _titleLabel.textColor=kBgColor;
        
        [self.mainView addSubview:_titleLabel];
        
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.mainView.mas_left).offset(25);
            
            make.top.equalTo(self.versionIMV.mas_bottom).offset(15);
            
        }];
    }
    
    return _titleLabel;
}

#pragma mark - 提示语
-(UITextView *)msgTextView
{
    if (_msgTextView==nil)
    {
        _msgTextView=[[UITextView alloc] init];
        
        _msgTextView.backgroundColor = kBgColor;
        
        _msgTextView.text=@"";
        
        _msgTextView.font=systemFont(ScaleW(15.0));
        
        _msgTextView.textColor=[UIColor redColor];
        
        _msgTextView.editable=NO;
        
        [self.mainView addSubview:_msgTextView];
        
        [_msgTextView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.titleLabel.mas_left).offset(-3);
            
            make.right.equalTo(self.mainView.mas_right).offset(-25);
            
            make.top.equalTo(self.titleLabel.mas_bottom).offset(18);
            
            make.bottom.equalTo(self.sureButton.mas_top).offset(-15);
        }];
    }
    
    return _msgTextView;
}



#pragma mark - 确认
-(UIButton *)sureButton
{
    if (_sureButton == nil)
    {
        _sureButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_sureButton setTitle:@"立即升级" forState:UIControlStateNormal];
        
        _sureButton.layer.cornerRadius = 22.5;
        
        _sureButton.layer.masksToBounds = YES;
        
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [_sureButton setBackgroundColor:[UIColor redColor]];
        
        [_sureButton addTarget:self action:@selector(sureButton_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.mainView addSubview:_sureButton];
        
        [_sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerX.equalTo(self.mas_centerX);
            
            make.width.equalTo(@(ScaleW(160)));
            
            make.height.equalTo(@(45));
            
            make.bottom.equalTo(self.mainView.mas_bottom).offset(-20);
        }];
        
    }
    
    return _sureButton;
}

#pragma mark - 取消按钮
-(UIButton *)cancelButton
{
    if (_cancelButton == nil)
    {
        UIImage *image=[UIImage imageNamed:@"bfex_version_bg"];
        
        _cancelButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
//        [_cancelButton setTitle:@"跳过更新" forState:UIControlStateNormal];
        [_cancelButton setImage:[UIImage imageNamed:@"Market_GUANBI"] forState:UIControlStateNormal];
        
//        [_cancelButton setTitleColor:[WLTools stringToColor:@"#a4a4a4"] forState:UIControlStateNormal];
        
        _cancelButton.titleLabel.font=systemFont(ScaleW(14.0));
        
//        [_cancelButton setBackgroundColor:[UIColor whiteColor]];
        
        [_cancelButton addTarget:self action:@selector(cancelButton_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_cancelButton];
        
        [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mainView.mas_bottom).offset(ScaleW(10));
            
            make.centerX.equalTo(self.mainView.mas_centerX);
            
            make.width.equalTo(@50);
            
            make.height.equalTo(@50);
        }];
    }
    
    return _cancelButton;
}

- (UILabel *)guanbilabel
{
    if (_guanbilabel == nil) {
        
        _guanbilabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"关闭", nil) textColor:[UIColor redColor] font:systemFont(ScaleW(15))];
        
        _guanbilabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_guanbilabel];
        
        [_guanbilabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.cancelButton.mas_bottom);
            
            make.centerX.equalTo(self.mainView.mas_centerX);
            
            make.height.equalTo(@15);
            
            make.width.equalTo(@(ScaleW(100)));
            
        }];
        
    }
    return _guanbilabel;
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
    if (self.cancleButtonBlock) {
        self.cancleButtonBlock();
    }
    [self hide:YES];
}

#pragma mark - 确认按钮 点击事件
-(void)sureButton_Event:(UIButton *)sender
{
    if (self.sureButtonBlock)
    {
        self.sureButtonBlock();
    }
    [self hide:YES];
}

#pragma mark - 标题和内容复制
-(void)initWithTitle:(NSString *)title andMessage:(NSString *)message
{
    self.titleLabel.text=title;
    
    self.msgTextView.text=message;
}
@end
