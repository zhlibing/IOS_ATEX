//
//  Lion_Forget_ViewController.m
//  SSKJ
//
//  Created by cy5566 on 2020/3/13.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_Forget_ViewController.h"
#import "LoginTextFieldView.h"
#import "Lion_Forget_SetViewController.h"
@interface Lion_Forget_ViewController ()

@property (nonatomic,strong) LoginTextFieldView *accountView;
@property (nonatomic,strong) UILabel *accountLabel;
@property (nonatomic,strong) UIButton *commitBtn;
@property (nonatomic,copy) NSString *validate;


@end

@implementation Lion_Forget_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = YES;
//    [self.navigationController setNavigationBarHidden:YES animated:NO];;

}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)setupUI {
    UILabel *label1 = [WLTools allocLabel:SSKJLocalized(@"忘记密码", nil) font:kFont(22) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(125), ScaleW(200), ScaleW(22)) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label1];
    
    UILabel *label2 = [WLTools allocLabel:SSKJLocalized(@"验证您的账户", nil) font:kFont(14) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), label1.bottom + ScaleW(10), ScaleW(300), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    [self.view addSubview:label2];
    self.accountLabel = label2;
    
    [self accountView];
    
    [self commitBtn];

}

- (void)backBtnAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)commitBtnAction {
    if (self.accountView.field.text.length == 0) {
        [MBProgressHUD showError:@"请输入账号"];
        return;
    }
    
    WS(weakSelf);
    NSDictionary *params = @{@"account":self.accountView.field.text};
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_CheckRegister_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netModel.status.integerValue == 200)
         {
             Lion_Forget_SetViewController *vc = [Lion_Forget_SetViewController new];
             vc.account = self.accountView.field.text;
             [weakSelf.navigationController pushViewController:vc animated:YES];
         }
         else
         {
             [MBProgressHUD showError:responseObject[@"msg"]];
         }
        
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
         [SSTool error:SSKJLanguage(@"网络异常")];
     }];
    
}


- (LoginTextFieldView *)accountView {
    if (_accountView == nil) {
        _accountView = [[LoginTextFieldView alloc] initWithImageName:@"" placeholder:SSKJLanguage(@"手机号或邮箱") rightBtn:NO];
        _accountView.frame = CGRectMake(ScaleW(15), self.accountLabel.bottom + ScaleW(45), ScreenWidth - ScaleW(30), ScaleW(60));
        [self.view addSubview:_accountView];

    }
    return _accountView;
}

- (UIButton *)commitBtn{
    if (_commitBtn == nil) {
        _commitBtn = [WLTools allocButton:SSKJLanguage(@"下一步") textColor:kWhiteColor nom_bg:[UIImage imageNamed:@""] hei_bg:nil frame:CGRectZero];
        _commitBtn.backgroundColor = kBlueColor;
        _commitBtn.titleLabel.font = kFont(16);
        [_commitBtn addTarget:self action:@selector(commitBtnAction) forControlEvents:UIControlEventTouchUpInside];
        _commitBtn.layer.masksToBounds = YES;
        _commitBtn.layer.cornerRadius = ScaleW(5);
//        _commitBtn.backgroundColor = kBlueColor;
        [self.view addSubview:_commitBtn];
        
        [_commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(15)));
            make.right.equalTo(@(ScaleW(-15)));
            make.top.equalTo(self.accountView.mas_bottom).offset(ScaleW(55));
            make.height.equalTo(@(ScaleW(44)));
        }];
    }
    return _commitBtn;
}
@end
