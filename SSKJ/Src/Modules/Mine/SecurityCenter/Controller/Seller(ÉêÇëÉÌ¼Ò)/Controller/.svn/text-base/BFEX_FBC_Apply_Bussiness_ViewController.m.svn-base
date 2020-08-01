//
//  BFEX_FBC_Apply_Bussiness_ViewController.m
//  ZYW_MIT
//
//  Created by James on 2018/7/2.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEX_FBC_Apply_Bussiness_ViewController.h"

@interface BFEX_FBC_Apply_Bussiness_ViewController ()


@property (nonatomic, strong) UIView *lineView;

@property(nonatomic,strong)UIButton *checkBoxButton;

@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,strong)UIButton *applyButton;

@property(nonatomic,strong)UILabel *howLabel;

@property(nonatomic,strong)UILabel *stepLabel1;

@property(nonatomic,strong)UILabel *stepLabel2;

@property(nonatomic,strong)UILabel *contentLabel1;

@property(nonatomic,strong)UILabel *contentLabel2;

@property(nonatomic,strong)UIButton *alphaButton;

@end

@implementation BFEX_FBC_Apply_Bussiness_ViewController

#pragma mark - LifeCycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title=SSKJLocalized(@"商家申请", nil);
    
    self.view.backgroundColor=kBgColor;
    
    
    
    
    [self lineView];
    [self howLabel];
    
    [self applyButton];
    
    [self checkBoxButton];
    
    [self tipLabel];
    
    
    
    [self stepLabel1];
    
    [self contentLabel1];
    
    [self stepLabel2];
    
    [self contentLabel2];
    
    [self alphaButton];
}


#pragma mark  内存警告
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}





#pragma mark - Private Method
#pragma mark  复选框 点击事件
-(void)checkbox_Button_Event:(UIButton *)sender
{
    sender.selected=!sender.selected;
    
    self.checkBoxButton.selected=sender.selected;
}


#pragma mark  申请按钮 点击事件
-(void)apply_Button_Event:(UIButton *)sender
{
    if (self.checkBoxButton.selected)
    {
        NSDictionary *dict = @{@"id":kUserID};
        
        
        WS(weakSelf);
        [MBHUD showHUDAddedTo:self.view];
        [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_ApplyShop_URL RequestType:RequestTypePost Parameters:dict Success:^(NSInteger statusCode, id responseObject)
         {
             [MBHUD hideHUDForView:self.view];
             WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
             if (netWorkModel.status.integerValue == SUCCESSED )
             {
                 [[SSKJ_User_Tool sharedUserTool].userInfoModel setShopAuthenticationStatus:@"2"];
                 [weakSelf.navigationController popViewControllerAnimated:YES];
             }
             else
             {
                 [MBHUD showError:netWorkModel.msg];
             }
             
         } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
             
             [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
             
         }];
        
        
        
    }
    else
    {
        NSString *usdt=[kUserDefaults objectForKey:@"usdt"];
        
        NSString *msgStr = SSKJLocalized(@"您还未同意冻结1000USTD作为商家保证金", nil);
        
        [MBProgressHUD showError:msgStr];
    }
}





#pragma mark - Getter / Setter
- (UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]init];
        _lineView.backgroundColor = kBgColor;
        [self.view addSubview:_lineView];
        [_lineView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.left.right.equalTo(self.view);
            make.height.mas_equalTo(ScaleW(10));
        }];
    }
    return _lineView;
}



#pragma mark  如何成为商家
-(UILabel *)howLabel
{
    if (_howLabel==nil)
    {
        _howLabel=[[UILabel alloc] init];
        
        _howLabel.text=SSKJLocalized(@"如何申请成为商家?", nil);
        
        _howLabel.font=systemFont(ScaleW(18.0));
        
        _howLabel.textColor=kTitleColor;
        
        [self.view addSubview:_howLabel];
        
        [_howLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.top.equalTo(self.lineView.mas_bottom).offset(40);
        }];
    }
    
    return _howLabel;
}

#pragma mark  步骤一
-(UILabel *)stepLabel1
{
    if (_stepLabel1==nil)
    {
        _stepLabel1=[[UILabel alloc] init];
        
        _stepLabel1.text=SSKJLocalized(@"步骤一", nil);
        
        _stepLabel1.font=systemFont(ScaleW(16.0));
        
        _stepLabel1.textColor=kSubTitleColor;
        
        [self.view addSubview:_stepLabel1];
        
        [_stepLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.howLabel.mas_left);
            
            make.top.equalTo(self.howLabel.mas_bottom).offset(38);
        }];
    }
    
    return _stepLabel1;
}


#pragma mark 步骤一内容
-(UILabel *)contentLabel1
{
    if (_contentLabel1==nil)
    {
        _contentLabel1=[[UILabel alloc] init];
        
        NSString *usdt=[kUserDefaults objectForKey:@"usdt"];
        
        _contentLabel1.text=SSKJLocalized(@"买卖商户必须为平台认证商户，并在本页面点击“确认申请”按钮，提交申请，并同意冻结1000USDT作为商家保证金", nil);
        
        _contentLabel1.numberOfLines=0;
        
        _contentLabel1.textColor=kTitleColor;
        
        _contentLabel1.font=systemFont(ScaleW(14.0));
        
        [self.view addSubview:_contentLabel1];
        
        [_contentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.stepLabel1.mas_bottom).offset(20);
            
            make.left.equalTo(@15);
            
            make.right.equalTo(self.view.mas_right).offset(-15);
        }];
    }
    return _contentLabel1;
}



#pragma mark 步骤二
-(UILabel *)stepLabel2
{
    if (_stepLabel2==nil)
    {
        _stepLabel2=[[UILabel alloc] init];
        
        _stepLabel2.text=SSKJLocalized(@"步骤二", nil);
        
        _stepLabel2.font=systemFont(ScaleW(16.0));
        
        _stepLabel2.textColor=kSubTitleColor;
        
        [self.view addSubview:_stepLabel2];
        
        [_stepLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.stepLabel1.mas_left);
            
            make.top.equalTo(self.contentLabel1.mas_bottom).offset(20);
        }];
    }
    
    return _stepLabel2;
}

#pragma mark 步骤二内容
-(UILabel *)contentLabel2
{
    if (_contentLabel2==nil)
    {
        _contentLabel2=[[UILabel alloc] init];
        
        _contentLabel2.text=SSKJLocalized(@"我们系统自动审核商家申请资料及匹配以往交易，确认符合商家申请条件，您可以在法币交易区发布广告。如申请条件未符合，我们将12小时内联系您，请保持通讯畅通。", nil);
        
        _contentLabel2.numberOfLines=0;
        
        _contentLabel2.textColor=kTitleColor;
        
        _contentLabel2.font=systemFont(ScaleW(14.0));
        
        [self.view addSubview:_contentLabel2];
        
        [_contentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.stepLabel2.mas_bottom).offset(20);
            
            make.left.equalTo(@15);
            
            make.right.equalTo(self.view.mas_right).offset(-15);
        }];
    }
    return _contentLabel2;
}


#pragma mark  提示语
-(UILabel *)tipLabel
{
    if (_tipLabel==nil)
    {
        _tipLabel=[[UILabel alloc] init];
        _tipLabel.text=SSKJLocalized(@"同意冻结1000USTD作为商家保证金", nil);
        
        _tipLabel.textColor=[WLTools stringToColor:@"#a0a0a0"];
        
        _tipLabel.font=systemFont(ScaleW(14.0));
        
        [self.view addSubview:_tipLabel];
        
        [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.checkBoxButton.mas_centerY);
            
            make.left.equalTo(self.checkBoxButton.mas_right).offset(5);
        }];
    }
    
    return _tipLabel;
}



#pragma mark  复选框 透明按钮
-(UIButton *)alphaButton
{
    if (_alphaButton==nil)
    {
        _alphaButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_alphaButton setBackgroundColor:[UIColor clearColor]];
        
        [_alphaButton addTarget:self action:@selector(checkbox_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_alphaButton];
        
        [_alphaButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.centerY.equalTo(self.checkBoxButton.mas_centerY);
            
            make.height.equalTo(@30);
            
            make.width.equalTo(@50);
        }];
    }
    
    return _alphaButton;
}




#pragma mark 复选框
-(UIButton *)checkBoxButton
{
    if (_checkBoxButton==nil)
    {
        UIImage *normalImage=[UIImage imageNamed:@"reg_box_normal"];
        
        UIImage *selectImage=[UIImage imageNamed:@"reg_box_selected"];
        
        _checkBoxButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_checkBoxButton setBackgroundImage:normalImage forState:UIControlStateNormal];
        
        [_checkBoxButton setBackgroundImage:selectImage forState:UIControlStateSelected];
        
        [self.view addSubview:_checkBoxButton];
        
        [_checkBoxButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.bottom.equalTo(self.applyButton.mas_top).offset(-30);
            
            make.height.equalTo(@(normalImage.size.width));
            
            make.height.equalTo(@(selectImage.size.height));
        }];
        
        
    }
    
    return _checkBoxButton;
}

#pragma mark 申请按钮
-(UIButton *)applyButton
{
    if (_applyButton==nil)
    {
        _applyButton=[UIButton buttonWithType:UIButtonTypeCustom];
        
        [_applyButton setTitle:SSKJLocalized(@"申请成为商家", nil) forState:UIControlStateNormal];
        
        [_applyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        _applyButton.layer.cornerRadius = 5;
        
        _applyButton.layer.masksToBounds = YES;
        
        _applyButton.titleLabel.font=systemFont(ScaleW(13.0));
        
        [_applyButton setBackgroundColor:kSubTitleColor];
        
        [_applyButton addTarget:self action:@selector(apply_Button_Event:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:_applyButton];
        
        [_applyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@15);
            
            make.width.equalTo(@(ScreenWidth-15*2));
            
            make.height.equalTo(@45);
            
            make.bottom.equalTo(self.view.mas_bottom).offset(ScaleW(-20));
        }];
    }
    
    return _applyButton;
}






@end
