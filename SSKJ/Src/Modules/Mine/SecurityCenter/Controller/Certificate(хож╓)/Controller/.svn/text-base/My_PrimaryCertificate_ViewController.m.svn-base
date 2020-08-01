//
//  My_PrimaryCertificate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_PrimaryCertificate_ViewController.h"
#import "My_TitleAndInput_View.h"
#import "My_Certificate_ViewController.h"

@interface My_PrimaryCertificate_ViewController ()

@property (nonatomic, strong) My_TitleAndInput_View *nameView;  //!< 用户名视图
@property (nonatomic, strong) My_TitleAndInput_View *idView;  //!< 身份证视图
@property (nonatomic, strong) UIButton *submitButton;

@property(nonatomic, strong)UIView *topView;

@end

@implementation My_PrimaryCertificate_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"实名认证", nil);
    
    self.view.backgroundColor = kBgColor;
    
    [self setUI];
}






#pragma mark - Getter / Setter
-(void)setUI
{
    [self setupTopView];
    [self.view addSubview:self.nameView];
    [self.view addSubview:self.idView];
    [self.view addSubview:self.submitButton];
}

- (void)setupTopView{
    self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(220))];
    self.topView.backgroundColor = kBgColor;
    [self.view addSubview:self.topView];
    
    UIView *line = [UIView new];
    line.backgroundColor = kSubBgColor;
    [self.topView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(10)));
    }];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageNamed(@"mine_auth_top")];
    [self.topView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(ScaleW(70)));
        make.centerX.equalTo(@0);
    }];
    
    UILabel *label = [UILabel createWithText:SSKJLanguage(@"为保障您的账户安全，需要进行身份验证\n身份一旦认证无法修改，请仔细填写您的真实信息") textColor:kSubTitleColor font:kFont(13)];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    [self.topView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(20)));
        make.right.equalTo(@(ScaleW(-20)));
        make.bottom.equalTo(@(ScaleW(-15)));
    }];
}


-(My_TitleAndInput_View *)nameView
{
    if (nil == _nameView) {
        _nameView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.topView.bottom + ScaleW(10), ScreenWidth, ScaleW(98)) title:SSKJLocalized(@"姓名", nil) placeHolder:SSKJLocalized(@"请输入您的真实姓名", nil) keyBoardType:UIKeyboardTypeDefault];
    }
    return _nameView;
}


-(My_TitleAndInput_View *)idView
{
    if (!_idView)
    {
        _idView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.nameView.bottom, ScreenWidth, self.nameView.height) title:SSKJLocalized(@"身份证号", nil) placeHolder:SSKJLocalized(@"请输入您的身份证号码", nil) keyBoardType:UIKeyboardTypeDefault];
    }
    return _idView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.view.bottom - ScaleW(20) - Height_NavBar, ScreenWidth - ScaleW(24), ScaleW(45))];
        _submitButton.layer.cornerRadius = 4.0f;
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(void)submitEvent
{
    
    NSString *name = self.nameView.valueString;
    NSString *idNumber = self.idView.valueString;
    if (name.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的真实姓名", nil)];
        return;
    }
    
    if (idNumber.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的身份证号码", nil)];
        return;
    }
    
    
    [self requestPrimaryCertificate:name withIDentity:idNumber];
}


#pragma mark - NetWork Method 网络请求
- (void)requestPrimaryCertificate:(NSString*)name withIDentity:(NSString*)identity
{
    
    [MBHUD showHUDAddedTo:self.view];
    
    NSDictionary *params = @{@"username":name,
                             @"idCardNo":identity,
                             @"id":kUserID};
    
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BaseAuth_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
         [MBHUD hideHUDForView:self.view];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
            [MBHUD showSuccess:SSKJLocalized(@"提交成功", nil)];
            if (weakSelf.successBlock)
            {
                weakSelf.successBlock(name,identity);
                
                [[SSKJ_User_Tool sharedUserTool].userInfoModel setBasicAuthenticationStatus:@"1"];
                [[SSKJ_User_Tool sharedUserTool].userInfoModel setUsername:name];
                [[SSKJ_User_Tool sharedUserTool].userInfoModel setIdCard:identity];
                
            }
            [self.navigationController popViewControllerAnimated:YES];
//            for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
//                if ([vc isKindOfClass:[My_Certificate_ViewController class]]) {
//                    [weakSelf.navigationController popToViewController:vc animated:YES];
//                    return;
//                }
//            }
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBHUD hideHUDForView:self.view];
        
    }];
}


@end
