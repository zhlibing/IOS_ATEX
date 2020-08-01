//
//  My_Extract_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_Tibi_ViewController.h"
// controller
#import "Mine_AddressManager_ViewController.h"
#import "MyWithdrawMoneyView.h"

// view
#import "FB_Action_TitleView.h"
#import "My_TitleAndInput_View.h"

// model
#import "WLLAssetsInfoModel.h"
#import "BI_AssetExtractInfo_Model.h"

#import "My_TB_ChooseCoin_AlertView.h"

#import "Mine_RechargeTiRecord_ViewController.h"

@interface Mine_Tibi_ViewController ()
@property (nonatomic, strong) FB_Action_TitleView *mainTitleView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) MyWithdrawMoneyView *addressView;
@property (nonatomic, strong) My_TitleAndInput_View *usedNumView;

@property (nonatomic, strong) UIButton *addressButton;
@property (nonatomic, strong) My_TitleAndInput_View *amountView;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UILabel *usableLabel;
@property (nonatomic, strong) UILabel *feeLabel;
@property (nonatomic, strong) My_TitleAndInput_View *pwdView;
@property (nonatomic, strong) My_TitleAndInput_View *smsCodeView;
@property (nonatomic, strong) UIButton *smsButton;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, strong) WLLAssetsInfoModel *model;
@property (nonatomic, strong) BI_AssetExtractInfo_Model *entractInfoModel;

@property (nonatomic,strong) My_TB_ChooseCoin_AlertView * tbAlertView;

@property (nonatomic,copy) NSString *eosAccount;

@end

@implementation Mine_Tibi_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
//    [self requestCoinList];
    
    WLLAssetsInfoModel *model = [WLLAssetsInfoModel new];
    model.stockCode = @"USDT";
    model.stockType = @"2";
    self.model = model;
    
    [self setUI];
    
    [self requestCoinInfo];
    
    [self addRightNavgationItemWithImage:UIImageNamed(@"mine_tibi_record")];
}

- (void)rigthBtnAction:(id)sender{
    
    Mine_RechargeTiRecord_ViewController *vc = [Mine_RechargeTiRecord_ViewController new];
    vc.model = self.model;
    vc.type = 2;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - UI

-(void)setUI
{
//    self.navigationItem.titleView = self.mainTitleView;
    
    self.title = SSKJLanguage(@"提币");

    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.usedNumView];
    [self.scrollView addSubview:self.addressView];
    [self.addressView addSubview:self.addressButton];
    [self.scrollView addSubview:self.amountView];
    [self.amountView addSubview:self.unitLabel];
//    [self.scrollView addSubview:self.usableLabel];
    [self.scrollView addSubview:self.feeLabel];
    [self.scrollView addSubview:self.pwdView];
    [self.scrollView addSubview:self.smsCodeView];
    [self.smsCodeView addSubview:self.smsButton];
    
    [self.scrollView addSubview:self.submitButton];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.submitButton.bottom + ScaleW(20));
    
    UIView *style = [[UIView alloc] initWithFrame:CGRectMake(315, 302, 1, 15)];
    style.backgroundColor = kLineColor;
    [self.scrollView addSubview:style];
    [style mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.unitLabel.mas_left).offset(-ScaleW(2));
        make.width.mas_equalTo(ScaleW(1));
        make.height.mas_equalTo(ScaleW(15));
        make.centerY.equalTo(self.unitLabel);
        
        
    }];
    
}
-(My_TitleAndInput_View *)usedNumView{
    
    if (nil == _usedNumView) {
        
        _usedNumView=[[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, ScaleW(20), ScreenWidth, ScaleW(102)) title:SSKJLocalized(@"可用", nil) placeHolder:@"0" keyBoardType:UIKeyboardTypeASCIICapable];
        
        _usedNumView.textField.text=@"0.00";
        
        _usedNumView.textField.enabled=NO;
        
    }
    return _usedNumView;
}
- (FB_Action_TitleView *)mainTitleView
{
    if (nil == _mainTitleView) {
        
        NSMutableArray *coinNameArray = [NSMutableArray arrayWithCapacity:10];
        for (WLLAssetsInfoModel *model in self.coinArray) {
            [coinNameArray addObject:model.stockCode];
        }
        
        _mainTitleView = [[FB_Action_TitleView alloc]initWithFrame:CGRectMake(0, 0, 90, 44) titles:coinNameArray];
        
        
        WS(weakSelf);
        _mainTitleView.titleChangeBlock = ^(NSInteger index) {
            weakSelf.model = weakSelf.coinArray[index];
            [weakSelf requestCoinInfo];
        };
        
    }
    return _mainTitleView;
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
        //Base style for 矩形 14 拷贝
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth , ScaleW(10))];
        style.layer.backgroundColor = [[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor];
        style.alpha = 1;
        
        [_scrollView addSubview:style];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
    }
    return _scrollView;
}

-(MyWithdrawMoneyView *)addressView
{
    if (nil == _addressView) {
        _addressView = [[MyWithdrawMoneyView alloc]initWithFrame:CGRectMake(0, self.usedNumView.bottom, ScreenWidth, ScaleW(102)) title:SSKJLocalized(@"提币地址", nil) placeHolder:SSKJLocalized(@"输入或长按粘贴地址", nil) keyBoardType:UIKeyboardTypeASCIICapable];
    }
    return _addressView;
}

-(UIButton *)addressButton
{
    if (nil == _addressButton) {
        _addressButton =[[UIButton alloc]initWithFrame:CGRectMake(self.addressView.width - ScaleW(15) - ScaleW(17), ScaleW(56), ScaleW(17), ScaleW(16))];
        [_addressButton setImage:[UIImage imageNamed:@"mine_tibi_address"] forState:UIControlStateNormal];
        [_addressButton addTarget:self action:@selector(selectAddress) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:_addressButton];
        
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(315, 302, 1, 15)];
        style.backgroundColor = kLineColor;
        style.alpha = 1;
        
        [self.scrollView addSubview:style];
        
        [style mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.equalTo(self->_addressButton.mas_left).offset(-ScaleW(9));
            
            make.width.mas_equalTo(1);
            
            make.height.mas_equalTo(ScaleW(15));
            
            make.centerY.equalTo(self->_addressButton);
            
        }];
            
    }
    return _addressButton;
}

-(My_TitleAndInput_View *)amountView
{
    if (nil == _amountView) {
        _amountView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.addressView.bottom, ScreenWidth, ScaleW(102)) title:SSKJLocalized(@"数量", nil) placeHolder:SSKJLocalized(@"最小提币数量", nil) keyBoardType:UIKeyboardTypeDecimalPad];
    }
    return _amountView;
}

-(UILabel *)unitLabel
{
    if (nil == _unitLabel) {
        _unitLabel = [WLTools allocLabel:@"" font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(60), 0, ScaleW(60), ScaleW(20)) textAlignment:NSTextAlignmentRight];
        _unitLabel.centerY = self.amountView.textField.centerY;
        //Base style for 矩形 7
        [self.scrollView addSubview:_unitLabel];

    }
    return _unitLabel;
}

-(UILabel *)usableLabel
{
    if (nil == _usableLabel) {
        
        UIView *mideBackView=[[UIView alloc]initWithFrame:CGRectMake(0, self.amountView.bottom, ScreenWidth, ScaleW(40))];
        
        mideBackView.backgroundColor=kSubBgColor;
        
        [self.scrollView addSubview:mideBackView];
        
        _usableLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@:--",SSKJLocalized(@"可用", nil)] font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.amountView.bottom + ScaleW(12), ScreenWidth / 2 - ScaleW(15), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
    }
    return _usableLabel;
}

-(UILabel *)feeLabel
{
    if (nil == _feeLabel) {
        _feeLabel = [WLTools allocLabel:[NSString stringWithFormat:@"%@--",SSKJLocalized(@"手续费", nil)]  font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(0, self.amountView.bottom + ScaleW(12), ScaleW(200), ScaleW(12)) textAlignment:NSTextAlignmentRight];
        _feeLabel.right = ScreenWidth - ScaleW(15);
    }
    return _feeLabel;
}

-(My_TitleAndInput_View *)pwdView
{
    if (nil == _pwdView) {
        _pwdView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.feeLabel.bottom + ScaleW(10), ScreenWidth, ScaleW(102)) title:SSKJLocalized(@"资金密码", nil) placeHolder:SSKJLocalized(@"请输入资金密码", nil) keyBoardType:UIKeyboardTypeASCIICapable];
        _pwdView.textField.secureTextEntry = YES;
    }
    return _pwdView;
}

-(My_TitleAndInput_View *)smsCodeView
{
    #pragma mark 处理
    if (nil == _smsCodeView) {
        NSString *string = SSKJLocalized(@"输入手机验证码", nil);
        if ([RegularExpression validateEmail:kAccount]) {
            string = SSKJLocalized(@"输入邮箱验证码", nil);
        }
        _smsCodeView = [[My_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.pwdView.bottom, ScreenWidth, ScaleW(102)) title:SSKJLocalized(@"安全验证", nil) placeHolder:string keyBoardType:UIKeyboardTypeASCIICapable];
    }
    return _smsCodeView;
}

-(UIButton *)smsButton
{
    if (nil == _smsButton) {
        _smsButton = [[UIButton alloc]initWithFrame:CGRectMake(self.smsCodeView.width - ScaleW(15) - ScaleW(100), ScaleW(50), ScaleW(100), ScaleW(30))];
        [_smsButton setTitle:SSKJLocalized(@"获取验证码", nil) forState:UIControlStateNormal];
        [_smsButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _smsButton.titleLabel.font = systemFont(ScaleW(15));
//        _smsButton.layer.masksToBounds = YES;
//        _smsButton.layer.cornerRadius = _smsButton.height / 2;
//        _smsButton.layer.borderColor = kBlueColor.CGColor;
//        _smsButton.layer.borderWidth = 1;
        [_smsButton addTarget:self action:@selector(getCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _smsButton;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton) {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.smsCodeView.bottom + ScaleW(50), ScreenWidth - ScaleW(24), ScaleW(45))];
        _submitButton.layer.cornerRadius = ScaleW(5);
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提币", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}


-(void)setModel:(WLLAssetsInfoModel *)model
{
    _model = model;
    self.unitLabel.text = model.stockCode;
}

#pragma mark - 获取支持的币种
-(void)requestCoinList
{
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ChargeCoinList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (netModel.status.integerValue == SUCCESSED) {
            
            weakSelf.coinArray = [WLLAssetsInfoModel mj_objectArrayWithKeyValuesArray:netModel.data];
            
            [weakSelf setUI];
            
            weakSelf.model = weakSelf.coinArray.firstObject;
            [weakSelf requestCoinInfo];

            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
    }];
}

#pragma mark - 用户操作

#pragma mark 选择地址

-(void)selectAddress
{
    Mine_AddressManager_ViewController *vc = [[Mine_AddressManager_ViewController alloc]init];
    WS(weakSelf);
    vc.fromVC = 1;
    vc.getAddressBlock = ^(NSString *addressStr) {
        weakSelf.addressView.valueString = addressStr;
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 获取验证码
-(void)getCode
{
    
    
    [self.view endEditing:YES];
    [[WYVerifyTool sharedInstance] startVerifyCompletion:^(BOOL result, NSString * _Nullable validate, NSString * _Nonnull message) {
        if (result) {
            [self getSmsCodeEvent:validate];
        }
    }];
}

// 获取手机验证码
-(void)getSmsCodeEvent:(NSString *)sender
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"account"] = kAccount;
    params[@"codeType"] = @"7";
    params[@"sliderCode"] = sender;
    params[@"areaCode"] = [SSTool myAreaCode];

    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_GetCode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:netModel.msg];
            [weakSelf changeCheckcodeButtonState];
        } else {
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];

}


// 倒计时
- (void)changeCheckcodeButtonState {
    __block int timeout= 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(timeout<=0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsButton setTitle:SSKJLocalized(@"重新发送", nil) forState:UIControlStateNormal];
                self.smsButton.enabled = YES;
                
            });
            
        }else{
            
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:SSKJLocalized(@"%lds", nil), seconds];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.smsButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateDisabled];
                self.smsButton.enabled = NO;
                
            });
            
            timeout--;
            
        }
        
    });
    
    dispatch_resume(_timer);
}

#pragma mark - 请求提币信息

-(void)requestCoinInfo
{
    
    NSDictionary *params = @{
                             @"stockUserId":kUserID,
                             @"code":self.model.stockCode
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ExtractInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            weakSelf.entractInfoModel = [BI_AssetExtractInfo_Model mj_objectWithKeyValues:netModel.data];
            [weakSelf resetView];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}


-(void)resetView
{
    self.amountView.textField.placeholder = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"最小提取", nil),self.entractInfoModel.tbMinRate,self.model.stockCode];
    self.feeLabel.text = [NSString stringWithFormat:@"%@%@%%",SSKJLocalized(@"手续费", nil),self.entractInfoModel.tbFeeRate];
    
//    self.usableLabel.text = [NSString stringWithFormat:@"%@:%@%@",SSKJLocalized(@"可用", nil),[WLTools noroundingStringWith:self.entractInfoModel.useFund.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:self.model.stockCode]],self.model.stockCode];
    
    self.usedNumView.textField.text=[NSString stringWithFormat:@"%@ %@",[WLTools noroundingStringWith:self.entractInfoModel.useFund.doubleValue afterPointNumber:[WLTools dotNumberOfCoinName:self.model.stockCode]],self.model.stockCode];
    
}

#pragma mark - 提币请求
-(void)submitEvent
{
    //个数范围校验
    
    
    
    double num =  self.amountView.valueString.doubleValue;
    NSString *min = self.entractInfoModel.tbMinRate;
    
    if (num < min.doubleValue) {
        [MBProgressHUD showSuccess:[NSString stringWithFormat:@"%@%@",SSKJLocalized(@"最小提币数量为", nil),min]];
        return;
    }
    
    if (self.addressView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入提币地址", nil)];
        return;
    }
    
//    if (self.amountView.valueString.length == 0) {
//        [MBProgressHUD showError:SSKJLocalized(@"请输入提币数量", nil)];
//        return;
//    }
    
    if (self.pwdView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return;
    }
    
    if (self.smsCodeView.valueString.length == 0) {
        
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
        
        return;
    }
    
    [self requestGetCoin];
    
}


-(void)requestGetCoin
{
    WS(weakSelf);
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setObject:kUserID forKey:@"id"];
    [params setObject:self.amountView.valueString forKey:@"usdFee"];
    [params setObject:[WLTools md5:self.pwdView.valueString] forKey:@"tradePwd"];
    //先不添加
    [params setObject:self.model.stockCode forKey:@"stockCode"];
    [params setObject:self.model.stockType forKey:@"coinType"];

    [params setObject:self.addressView.valueString forKey:@"walletAddr"];
    [params setObject:self.smsCodeView.valueString forKey:@"code"];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ConfirmExtract_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            [MBProgressHUD showSuccess:responseObject[@"msg"]];
//            weakSelf.addressView.valueString = nil;
//            weakSelf.amountView.valueString = nil;
//            weakSelf.pwdView.valueString = nil;
//            weakSelf.smsCodeView.valueString = nil;
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showSuccess:SSKJLocalized(@"请求超时", nil)];

    }];
    
    
    
//    [HttpTool postWithURL:TiBiURL params:params success:^(id json) {
//        NSString *status = json[@"status"];
//        if (status.integerValue == SUCCESSED) {
//            dispatch_async(dispatch_get_main_queue(), ^{
//        } else {
//            [MBProgressHUD showSuccess:json[@"msg"]];
//        }
//    } failure:^(NSError *error) {
//        [MBProgressHUD showSuccess:SSKJLocalized(@"请求超时", nil)];
//    }];
}

- (My_TB_ChooseCoin_AlertView *)tbAlertView
{
    if (_tbAlertView == nil) {
        
        _tbAlertView = [[My_TB_ChooseCoin_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        WS(weakSelf);
        
        _tbAlertView.coinBlock = ^(WLLAssetsInfoModel * _Nonnull model) {
            
            weakSelf.tbAlertView.hidden = YES;
            
            weakSelf.model = model;
            
            [weakSelf requestCoinInfo];

        };
        _tbAlertView.hidden = YES;
        
        [self.view addSubview:_tbAlertView];
    }
    return _tbAlertView;
}

- (void)hiddenAlertView
{
    self.tbAlertView.hidden = YES;
}

@end
