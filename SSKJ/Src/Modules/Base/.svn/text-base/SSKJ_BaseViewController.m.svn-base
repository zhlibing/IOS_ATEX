//
//  SSKJ_BaseViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/12/6.
//  Copyright © 2018年 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_TitleView.h"
#import "UIImage+RoundedRectImage.h"
#import "SSKJ_BaseNavigationController.h"
#import "SSKJ_Default_AlertView.h"
#import "Mine_PrimaryCertificate_ViewController.h"
#import "Mine_SafeCenter_ViewController.h"
#import "Mine_SetFundPwd_ViewController.h"
#import "LoginViewController.h"
@interface SSKJ_BaseViewController ()
@property (nonatomic, strong) SSKJ_TitleView *titleView;

@end

@implementation SSKJ_BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.titleView = self.titleView;
    
    self.view.backgroundColor = kBgColor;
    
    [self.titleView setTintColor:kNavigationTitleColor];
    
    [self setTitleFont:[UIFont systemFontOfSize:ScaleW(18)]];
    
    
    self.modalPresentationStyle = 0;
    
    
    if (self.navigationController.viewControllers.count > 1) {
        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageWithOriginalName:@"mine_fanhui"]style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
        item.tintColor = kTitleColor;
        self.navigationItem.leftBarButtonItem = item;
        
    }
    
//    if (@available(iOS 13.0, *)){
//        self.overrideUserInterfaceStyle = UIUserInterfaceStyleLight;
//    }

    
    //    else if(self.isPush == YES){
    //        UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"fanhui-icon"] style:UIBarButtonItemStylePlain target:self action:@selector(backBtnAction:)];
    //
    //        self.navigationItem.leftBarButtonItem = item;
    //    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavgationBackgroundColor:kBgColor alpha:1];
    // 去除navigationbar下面的线
    //    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}


-(SSKJ_TitleView *)titleView
{
    if (nil == _titleView) {
        
        _titleView = [[SSKJ_TitleView alloc]initWithFrame:CGRectMake(0, 0,ScaleW(200), 40)];
        
    }
    return _titleView;
}

#pragma mark - 基本功能
/*
 * 修改导航栏字体颜色
 */
-(void)setTitleColor:(UIColor *)titleColor
{
    [self.titleView changeTitleColor:titleColor];
}

/*
 * 修改导航栏字体
 */
-(void)setTitleFont:(UIFont *)font
{
    [self.titleView changeTitleFont:font];
}

/*
 * 修改导航栏背景色
 */
-(void)setNavgationBackgroundColor:(UIColor *)navigationBackgroundColor alpha:(CGFloat)alpha
{
    UIImageView *barImageView = self.navigationController.navigationBar.subviews.firstObject;
    barImageView.alpha = alpha;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:navigationBackgroundColor] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc]init] ];
    
    self.navigationController.navigationBar.barTintColor = navigationBackgroundColor;
}



/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    self.navigationItem.leftBarButtonItem = item;
}
/*
 * 修改导航栏左侧按钮
 */
- (void)addLeftNavItemWithTitle:(NSString*)title color:(UIColor *)color
{
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnAction:)];
    item.tintColor = color;
    self.navigationItem.leftBarButtonItem = item;
    
}
/*
 * 返回按钮点击事件
 */
- (void)leftBtnAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavItemWithTitle:(NSString*)title color:(UIColor *)color font:(UIFont *)font
{
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:title style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    //    item.tintColor = color;
    [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,
                                  color, NSForegroundColorAttributeName,
                                  nil]
                        forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = item;
    
}

/*
 * 添加导航栏右侧按钮
 */
- (void)addRightNavgationItemWithImage:(UIImage*)image
{
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(rigthBtnAction:)];
    self.navigationItem.rightBarButtonItem = item;
}

/*
 * 导航栏右侧按钮点击事件
 */
- (void)rigthBtnAction:(id)sender
{
    
}

-(void)changeTitle:(NSString *)title
{

    self.title = title;
    [self.titleView changeTitle:title];


}



-(void)setTitle:(NSString *)title
{
    CGSize sizeToFit = [title sizeWithFont:[UIFont systemFontOfSize:ScaleW(18)] constrainedToSize:CGSizeMake(CGFLOAT_MAX, 40) lineBreakMode:NSLineBreakByWordWrapping];
    self.titleView.frame=CGRectMake(0, 0, sizeToFit.width+40, 40);
    [self.titleView changeTitle:title];
    
}

-(void)setNavigationBarHidden:(BOOL)isHidden
{
    
    [self.navigationController setNavigationBarHidden:isHidden];
}


// 弹出登录页面
-(void)presentLoginController
{
    
//    LoginViewController *vc = [LoginViewController new];
//    SSKJ_BaseNavigationController *naviVC = [[SSKJ_BaseNavigationController alloc] initWithRootViewController:vc];
//    [self.navigationController presentViewController:naviVC animated:YES completion:nil];
    LoginViewController *loginVc = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:loginVc animated:YES];
}

-(BOOL)judgePayPassword
{
    NSString *tpwd = [SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set;
    //资金密码设置状态  1已设置  0未设置
    WS(weakSelf);
    if (tpwd.integerValue == 1) {
        return YES;
    }else{
        
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"资金密码", nil) message:SSKJLocalized(@"您还未设置资金密码，去设置？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"前往", nil) confirmBlock:^{
            Mine_SetFundPwd_ViewController *vc = [[Mine_SetFundPwd_ViewController alloc]init];
            vc.phoneNumber = kAccount;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        }];
        return NO;
    }
}


-(void)showLoginAlert
{
    WS(weakSelf);
    [SSKJ_Default_AlertView showWithTitle:@"" message:SSKJLocalized(@"您当前还未登录，请先登录或注册", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"登录/注册", nil) confirmBlock:^{
        [weakSelf presentLoginController];
    }];
    
}


// 判断初级认证
-(BOOL)judgeFristCertificate
{
    //初级认证状态   1已认证  0未认证
    NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.authentication.integerValue;

    if (status == 0) {                  // 未认证
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提醒", nil) message:SSKJLocalized(@"您还未完成身份认证，去完成?", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"去认证", nil) confirmBlock:^{
            Mine_PrimaryCertificate_ViewController *vc = [[Mine_PrimaryCertificate_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        
    }else if (status == 3){         // 已认证
        return YES;
    }else if (status == 4){
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提醒", nil) message:SSKJLocalized(@"您的身份认证被拒绝，请重新认证", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"重新认证", nil) confirmBlock:^{
            Mine_PrimaryCertificate_ViewController *vc = [[Mine_PrimaryCertificate_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }];
        return NO;
    }else if (status == 2){
        [MBProgressHUD showError:SSKJLocalized(@"您的身份认证正在审核中，请耐心等待！", nil)];
        return NO;
    }
    return NO;
}






- (UIView *)getLineView{
 
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(10))];
    line.backgroundColor = kSubBgColor;
    return line;
}

- (UIView *)getLine{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    line.backgroundColor = kLineColor;
    return line;
}


//-(HeBi_ApplyShop_AlertView *)applyAlertView
//{
//    if (nil == _applyAlertView) {
//        _applyAlertView = [[HeBi_ApplyShop_AlertView alloc]init];
//        WS(weakSelf);
//        _applyAlertView.confirmBlock = ^{
//            [weakSelf requestApplyShop];
//        };
//    }
//    return _applyAlertView;
//}

//
//#pragma mark - 申请商家认证
//
//-(void)requestApplyShop
//{
//    NSString *Account=[[SSKJ_User_Tool sharedUserTool] getAccount];
//
//    NSDictionary *params = @{
//                             @"account":Account
//                             };
//    WS(weakSelf);
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JB_ApplyShop_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//            [MBProgressHUD showSuccess:SSKJLocalized(@"提交成功", nil)];
//            [weakSelf.applyAlertView hide];
//            [SSKJ_User_Tool sharedUserTool].userInfoModel.is_shop = @"2";
//            [weakSelf.applyAlertView hide];
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//
//    }];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
