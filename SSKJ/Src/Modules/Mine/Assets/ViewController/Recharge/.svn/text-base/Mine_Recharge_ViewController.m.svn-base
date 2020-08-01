//
//  My_Charge_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_Recharge_ViewController.h"
#import "FB_Action_TitleView.h"
#import "My_Charge_View.h"
#import "WLLAssetsInfoModel.h"
#import "My_TB_ChooseCoin_AlertView.h"
#import "LP_Default_AlertView.h"
#import "Mine_RechargeTiRecord_ViewController.h"

@interface Mine_Recharge_ViewController ()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) FB_Action_TitleView *mainTitleView;

@property (nonatomic, strong) My_Charge_View *chargeView;  //!< 充币地址，上部分内容

@property (nonatomic, strong) UILabel *warnTitleLabel;
@property (nonatomic, strong) UILabel *warnLabel;

@property (nonatomic, strong) WLLAssetsInfoModel *assetModel;

@property (nonatomic,strong) My_TB_ChooseCoin_AlertView * tbAlertView;

@property (nonatomic,copy) NSString *eosAccount;
@property (nonatomic,copy) NSString *usdtNum;

//交易提示语
@property (nonatomic, strong) UILabel *eosTitleLabel;
//交易号
@property (nonatomic, strong) UILabel *leftEosLabel;
//交易号输入框
@property (nonatomic, strong) UITextField *eosTextField;
//提交按钮
@property (nonatomic, strong) UIButton *eosSubmitBtn;



@end

@implementation Mine_Recharge_ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBgColor;
    WLLAssetsInfoModel *model = [WLLAssetsInfoModel new];
    model.stockCode = @"USDT";
    model.stockType = @"2";
    self.assetModel = model;
    
    self.title = SSKJLanguage(@"充币");

    [self setUI];
    
    [self addRightNavgationItemWithImage:UIImageNamed(@"mine_tibi_record")];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self requestCoinList];
//    [self requestEos];

    
}

- (void)rigthBtnAction:(id)sender{
    Mine_RechargeTiRecord_ViewController *vc = [Mine_RechargeTiRecord_ViewController new];
    vc.model = self.assetModel;
    vc.type = 1;
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - setUI

-(void)setUI
{
//    self.navigationItem.titleView = self.mainTitleView;
    
//    self.title = self.assetModel.stockCode;
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.chargeView];
    [self.scrollView addSubview:self.warnTitleLabel];
    [self.scrollView addSubview:self.warnLabel];
    _warnTitleLabel.hidden = YES;
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
            
            weakSelf.assetModel = weakSelf.coinArray[index];


        };
        
    }
    return _mainTitleView;
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
        
        //Base style for 矩形 14
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
        style.layer.backgroundColor = [[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor];
        style.alpha = 1;
        
        [_scrollView addSubview:style];
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

-(My_Charge_View *)chargeView
{
    if (nil == _chargeView) {
        _chargeView = [[My_Charge_View alloc]initWithFrame:CGRectMake(ScaleW(22), ScaleW(25), ScreenWidth - ScaleW(44), ScaleW(400))];
    }
    return _chargeView;
}

-(UILabel *)warnTitleLabel
{
    if (nil == _warnTitleLabel) {
        _warnTitleLabel  = [FactoryUI createLabelWithFrame:CGRectMake(self.chargeView.x, self.chargeView.bottom + ScaleW(0), self.chargeView.width, ScaleW(14)) text:SSKJLocalized(@"充币说明:", nil) textColor:kSubTitleColor font:systemFont(ScaleW(14))];
    }
    return _warnTitleLabel;
}

-(UILabel *)warnLabel
{
    if (nil == _warnLabel) {
        _warnLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.chargeView.x, self.warnTitleLabel.bottom + ScaleW(0), self.chargeView.width, ScaleW(12)) text:SSKJLocalized(@"", nil) textColor:kSubTitleColor font:systemFont(ScaleW(12))];
    }
    return _warnLabel;
}

-(void)setAssetModel:(WLLAssetsInfoModel *)assetModel
{
    _assetModel = assetModel;
  

//     NSString *string = [NSString stringWithFormat:@"%@%@%@",SSKJLocalized(@"请勿向上述地址充值任何非", nil),_model.stockCode,SSKJLocalized(@"资产，否则资产将不可找回。\n您充值至上述地址后，需要整个网络节点的确认，6次网络确认后\n到账。\n您可以在充值记录里查看充值状态！", nil)];
    NSString *string = SSKJLocalized(@"请勿向上述地址充值任何非USDT资产，否则资产将不可找回。\n您充值至上述地址后，需要整个网络节点的确认，6次网络确认后到账。\n您可以在充值记录里查看充值状态！", nil);
    self.warnLabel.text = string;
    
    CGFloat height = [string boundingRectWithSize:CGSizeMake(self.warnLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.warnLabel.font} context:nil].size.height;
    self.warnLabel.height = height;
    self.warnLabel.numberOfLines = 0;
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.warnLabel.bottom + ScaleW(10));
    
    if ([ assetModel.stockCode isEqualToString:@"EOS"]) {
        if (self.eosAccount.length == 0) {
            WS(weakSelf);
            [LP_Default_AlertView showWithTitle:@"" message:[NSString stringWithFormat:SSKJLocalized(@"您需要有EOS账户,即可充币\n\n创建EOS账户需花费%@USDT\n\n请保证账户内USDT数量充足", nil) ,self.usdtNum] textField:SSKJLocalized(@"账户名:12位  小写字母+数字(1~5区间)", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"创建",nil) confirmBlock:^(NSString * _Nonnull account, NSString * _Nonnull pswd) {
                //                        account 账号   pswd 资金密码
                [weakSelf requestCreateEosWithAccount:account AndPswd:pswd];
            }];
            return;
        } else {
            //有账号，创建EOS特殊充币视图
            
            
        }
    }
    [self requestAddress];
}


- (void)requestAddress {
    #pragma mark 处理
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    NSDictionary *params = @{
                             @"id":kUserID,
                             @"type":self.assetModel.stockType,
                             @"code":self.assetModel.stockCode
                             };
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_RechargeAddr_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if ([responseObject[@"code"] integerValue] == 200) {
            NSString *address = responseObject[@"data"][@"addr"];
            weakSelf.chargeView.address = address;
            [weakSelf.chargeView.qrCodeImageView sd_setImageWithURL:[SSTool imageURLWithURL:responseObject[@"data"][@"codeUrlImg"]]];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
    }];
   
}

- (My_TB_ChooseCoin_AlertView *)tbAlertView
{
    if (_tbAlertView == nil) {
        
        _tbAlertView = [[My_TB_ChooseCoin_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        
        WS(weakSelf);
        
        _tbAlertView.coinBlock = ^(WLLAssetsInfoModel * _Nonnull model) {
            
            weakSelf.tbAlertView.hidden = YES;
            
            weakSelf.assetModel = model;
        };
        _tbAlertView.hidden = YES;
        
        [self.view addSubview:_tbAlertView];
    }
    return _tbAlertView;
}


- (UILabel *)eosTitleLabel {
    if (!_eosTitleLabel) {
        _eosTitleLabel = [WLTools allocLabel:SSKJLocalized(@"请输入充值后的交易号,提交成功后才可到账", nil) font:systemFont(ScaleW(14)) textColor:[UIColor redColor] frame:CGRectZero textAlignment:NSTextAlignmentCenter];
    }
    return _eosTitleLabel;
}
#pragma mark - method
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

            weakSelf.assetModel = weakSelf.coinArray.firstObject;
            
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

- (void)requestEos {
    //校验平台用户是否拥有EOS账号
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    NSDictionary *params = @{@"code":@"EOS"};

    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ChargeCoinList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            weakSelf.eosAccount = netModel.data[@"account"];
            weakSelf.usdtNum = netModel.data[@"usdtNum"];
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}


//创建EOS账号
- (void)requestCreateEosWithAccount:(NSString *)account AndPswd:(NSString *)pswd {
    
    NSString *md5PWD = [WLTools md5:pswd];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    NSDictionary *params = @{@"newAccount":account,@"tradePwd":md5PWD};

    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_ChargeCoinList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            weakSelf.eosAccount = netModel.data;
            [weakSelf requestAddress];
            
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}

@end
