//
//  HeBi_Convert_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_Convert_ViewController.h"

//view
#import "HeBi_Convert_TopView.h"

#import "HeBi_Convert_MiddleView.h"

#import "FB_TitleAndInput_View.h"

#import "HeBi_Select_TableView.h"

// controller
#import "HeBi_ConvertRecord_ViewController.h"

// model
#import "HeBi_ConvertCoin_Model.h"
#import "HeBi_ConvertToCoin_Model.h"


@interface HeBi_Convert_ViewController ()
@property (nonatomic, strong) HeBi_Convert_TopView *topView;

@property (nonatomic, strong) UILabel *warninglabel;

@property (nonatomic, strong) HeBi_Convert_MiddleView *middleView;

@property (nonatomic, strong) UIView *bottomView;
//@property (nonatomic, strong) HeBi_TitleAndInput_View *pwdView;// 密码
@property (nonatomic, strong) FB_TitleAndInput_View *smsCodeView;// 验证码

@property (nonatomic, strong) UIView *pwdBackView;
@property (nonatomic, strong) UILabel *pwdTitleLabel;
@property (nonatomic, strong) UITextField *pwdTextField;

@property (nonatomic, strong) UIButton *smsCodeButton;  // 获取验证码按钮
@property (nonatomic, strong) UIButton *confirmButton;  // 确认按钮

@property (nonatomic, strong) NSArray *coinArray;
@property (nonatomic, strong) NSArray *convertCoinArray;

// 选择持有币种
@property (nonatomic, strong) HeBi_Select_TableView *coinTableView;

// 选择兑换币种
@property (nonatomic, strong) HeBi_Select_TableView *convertTableView;


// 持有资产model
@property (nonatomic, strong) HeBi_ConvertCoin_Model *coinModel;
// 要兑换的资产model
@property (nonatomic, strong) HeBi_ConvertToCoin_Model *convertModel;

@end

@implementation HeBi_Convert_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"兑换", nil);
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"Mine_duihuanjilu"]];
    [self setUI];
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self requestCoinList];
}

-(void)rigthBtnAction:(id)sender
{
    HeBi_ConvertRecord_ViewController *vc = [[HeBi_ConvertRecord_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UI

-(void)setUI
{
    [self.view addSubview:self.topView];
    [self.view addSubview:self.warninglabel];
    [self.view addSubview:self.middleView];
//    [self.view addSubview:self.pwdView];
//    [self.view addSubview:self.smsCodeView];
//    [self.smsCodeView addSubview:self.smsCodeButton];
    [self.view addSubview:self.pwdBackView];
    [self.pwdBackView addSubview:self.pwdTitleLabel];
    [self.pwdBackView addSubview:self.pwdTextField];
    [self.view addSubview:self.confirmButton];
}


-(HeBi_Convert_TopView *)topView
{
    if (nil == _topView) {
        _topView = [[HeBi_Convert_TopView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScaleW(80))];
        WS(weakSelf);
        _topView.selectCoinBlock = ^{
            if (weakSelf.coinTableView.superview) {
                [weakSelf.coinTableView removeFromSuperview];
            }else{
                [weakSelf.view addSubview:weakSelf.coinTableView];
                [weakSelf.convertTableView removeFromSuperview];

            }
        };
        
        _topView.selectConvertBlock = ^{
            if (weakSelf.convertTableView.superview) {
                [weakSelf.convertTableView removeFromSuperview];
            }else{
                [weakSelf.view addSubview:weakSelf.convertTableView];
                [weakSelf.coinTableView removeFromSuperview];

            }
        };
        
    }
    return _topView;
}

-(UILabel *)warninglabel
{
    if (nil == _warninglabel) {
        
        NSString *title = SSKJLocalized(@"账户中持有资产可按比例兑换为其他资产，兑换比例以行情为准", nil);
       
        _warninglabel = [WLTools allocLabel:title font:systemFont(ScaleW(11.5)) textColor:kSubTitleColor frame:CGRectMake(0, self.topView.bottom, ScreenWidth, ScaleW(35)) textAlignment:NSTextAlignmentCenter];
        
        CGFloat height = [title boundingRectWithSize:CGSizeMake(_warninglabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_warninglabel.font} context:nil].size.height;
        
        _warninglabel.height = height + ScaleW(15);
    }
    return _warninglabel;
}

-(HeBi_Convert_MiddleView *)middleView
{
    if (nil == _middleView) {
        _middleView = [[HeBi_Convert_MiddleView alloc]initWithFrame:CGRectMake(0, self.warninglabel.bottom, ScreenWidth, ScaleW(0))];
    }
    return _middleView;
}
//
//-(HeBi_TitleAndInput_View *)pwdView
//{
//    if (nil == _pwdView) {
//        _pwdView = [[HeBi_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.middleView.bottom + ScaleW(10), ScreenWidth, ScaleW(85)) leftGap:ScaleW(15) title:SSKJLocalized(@"资金密码", nil) placeHolder:SSKJLocalized(@"请输入资金密码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:YES];
//        _pwdView.secureButton.hidden = YES;
//    }
//    return _pwdView;
//}

-(UIView *)pwdBackView
{
    if (nil == _pwdBackView) {
        _pwdBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.middleView.bottom + ScaleW(10), ScreenWidth, ScaleW(50))];
        _pwdBackView.backgroundColor = kSubBgColor;
    }
    return _pwdBackView;
}

-(UILabel *)pwdTitleLabel
{
    if (nil == _pwdTitleLabel) {
        _pwdTitleLabel = [WLTools allocLabel:SSKJLocalized(@"资金密码", nil) font:systemFont(ScaleW(15)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), 0, ScaleW(62), self.pwdBackView.height) textAlignment:NSTextAlignmentLeft];
    }
    return _pwdTitleLabel;
}

-(UITextField *)pwdTextField
{
    if (nil == _pwdTextField) {
        _pwdTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.pwdTitleLabel.right + ScaleW(12), 0, ScreenWidth - ScaleW(15) - self.pwdTitleLabel.right - ScaleW(12), self.pwdBackView.height)];
        _pwdTextField.placeholder = SSKJLocalized(@"请输入资金密码", nil);
        _pwdTextField.textColor = kTitleColor;
        _pwdTextField.font = systemFont(ScaleW(14));
//        [_pwdTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
        _pwdTextField.keyboardType = UIKeyboardTypeASCIICapable;
        
    }
    return _pwdTextField;
}

-(FB_TitleAndInput_View *)smsCodeView
{
    if (nil == _smsCodeView) {
        _smsCodeView = [[FB_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdBackView.bottom, ScreenWidth, ScaleW(85)) leftGap:ScaleW(15) title:SSKJLocalized(@"手机验证码", nil) placeHolder:SSKJLocalized(@"请输入手机验证码", nil) keyBoardType:UIKeyboardTypeASCIICapable isSecured:NO];
    }
    return _smsCodeView;
}

-(UIButton *)smsCodeButton
{
    if (nil == _smsCodeButton) {
        _smsCodeButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(85), 0, ScaleW(85), ScaleW(40))];
        _smsCodeButton.titleLabel.numberOfLines = 0;
        _smsCodeButton.centerY = self.smsCodeView.textField.centerY;
        [_smsCodeButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsCodeButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _smsCodeButton.titleLabel.font = systemFont(ScaleW(13));
        [_smsCodeButton addTarget:self action:@selector(getSmsCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsCodeButton;
}


-(UIButton *)confirmButton
{
    if (nil == _confirmButton) {
        
        _confirmButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - Height_NavBar - ScaleW(45) - ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(45))];
        _confirmButton.backgroundColor = kBlueColor;
        [_confirmButton setTitle:SSKJLocalized(@"提交", nil) forState:UIControlStateNormal];
        [_confirmButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        _confirmButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _confirmButton.layer.cornerRadius = 4.0f;
        [_confirmButton addTarget:self action:@selector(confirmEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmButton;
}

-(HeBi_Select_TableView *)coinTableView
{
    if (nil == _coinTableView) {
        _coinTableView = [[HeBi_Select_TableView alloc]initWithFrame:CGRectMake(self.topView.bottom, self.topView.bottom, ScaleW(100), ScaleW(100))];
        _coinTableView.centerX = ScaleW(72);
        WS(weakSelf);
        _coinTableView.selectCoinBlock = ^(NSInteger index) {
            weakSelf.coinModel = weakSelf.coinArray[index];
            [weakSelf.middleView clearView];
            [weakSelf requestConvertListWithModel:weakSelf.coinModel];
            [weakSelf.coinTableView removeFromSuperview];

        };
    }
    return _coinTableView;
}

-(HeBi_Select_TableView *)convertTableView
{
    if (nil == _convertTableView) {
        _convertTableView = [[HeBi_Select_TableView alloc]initWithFrame:CGRectMake(self.topView.bottom, self.topView.bottom, ScaleW(100), ScaleW(100))];
        _convertTableView.centerX = ScreenWidth - ScaleW(72);
        WS(weakSelf);
        _convertTableView.selectCoinBlock = ^(NSInteger index) {
            [weakSelf.middleView clearView];
            weakSelf.convertCoinArray = weakSelf.convertCoinArray[index];
            [weakSelf.convertTableView removeFromSuperview];
        };
    }
    return _convertTableView;
}

#pragma mark - 用户操作

#pragma makr 获取验证码
-(void)getSmsCode
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"mobile"] = kAccount;
    
    params[@"type"] = @"3";
    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:nil RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf changeCheckcodeButtonState];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}


#pragma mark - 倒计时
// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    WS(weakSelf);
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:SSKJLocalized(@"重新获取", nil) forState:UIControlStateNormal];
                weakSelf.smsCodeButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%lds", seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.smsCodeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                weakSelf.smsCodeButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 网络请求
#pragma mark 请求币种列表
-(void)requestCoinList
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ConvertCoinList_URL RequestType:RequestTypeGet Parameters:@{@"id":kUserID} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleConvertListWithModel:net_model];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleConvertListWithModel:(WL_Network_Model *)net_model
{
    self.coinArray = [HeBi_ConvertCoin_Model mj_objectArrayWithKeyValuesArray:net_model.data];
    
    if (self.coinArray.count != 0) {
        self.coinModel = self.coinArray.firstObject;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (HeBi_ConvertCoin_Model *model in self.coinArray) {
        [array addObject:model.code];
    }
    
    self.coinTableView.dataSource = array;
    
    [self requestConvertListWithModel:self.coinModel];
}

-(void)setCoinModel:(HeBi_ConvertCoin_Model *)coinModel
{
    _coinModel = coinModel;
    self.topView.coinModel = coinModel;
    self.middleView.coinModel = coinModel;
    
}

#pragma mark 请求要兑换的币种列表

-(void)requestConvertListWithModel:(HeBi_ConvertCoin_Model *)model
{
    
    NSDictionary *param = @{
                            @"code":model.code
                            };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetExchange_URL RequestType:RequestTypeGet Parameters:param Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleConvertToListWithModel:net_model];
        }else{
            weakSelf.convertModel = nil;
            weakSelf.convertTableView.dataSource = nil;
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

-(void)handleConvertToListWithModel:(WL_Network_Model *)net_model
{
    self.convertCoinArray = [HeBi_ConvertToCoin_Model mj_objectArrayWithKeyValuesArray:net_model.data];
    
    if (self.convertCoinArray.count != 0) {
        self.convertModel = self.convertCoinArray.firstObject;
    }
    
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:10];
    for (HeBi_ConvertToCoin_Model *model in self.convertCoinArray) {
        [array addObject:model.dealCode];
    }
    
    self.convertTableView.dataSource = array;
    
}


-(void)setConvertModel:(HeBi_ConvertToCoin_Model *)convertModel
{
    _convertModel = convertModel;
    self.topView.convertModel = convertModel;
    self.middleView.convertModel = convertModel;
}


#pragma makr 确认兑换
-(void)confirmEvent
{
    if (self.middleView.ammount.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入兑换数量", nil)];
        return;
    }
    if (self.middleView.ammount.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"兑换数量不能为0", nil)];
        return;
    }
    
    if (self.pwdTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return;
    }
    
//    if (self.smsCodeView.valueString.length == 0) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入手机验证码", nil)];
//        return;
//    }
    
    [self requestConvert];
    
}

#pragma mark 请求兑换

-(void)requestConvert
{
    
    NSDictionary *param = @{
                            @"baseCode":self.coinModel.code,
                            @"dealCode":self.convertModel.dealCode,
                            @"dealNum":self.middleView.ammount,
                            @"dealPswd":[WLTools md5:self.pwdTextField.text],
                            @"id":kUserID
                            };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_PropertyChange_URL RequestType:RequestTypePost Parameters:param Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [weakSelf handleConfirConvertWithModel:net_model];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}


-(void)handleConfirConvertWithModel:(WL_Network_Model *)net_model
{
    [self.middleView clearView];
    self.pwdTextField.text = @"";
    self.smsCodeView.valueString = @"";
    
    [self rigthBtnAction:@""];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
