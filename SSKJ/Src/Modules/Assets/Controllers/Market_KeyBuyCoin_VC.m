//
//  Market_KeyBuyCoin_VC.m
//  ZYW_MIT
//
//  Created by Tom on 2020/1/9.
//  Copyright © 2020 Wang. All rights reserved.
//

#import "Market_KeyBuyCoin_VC.h"

#import "BuyCoinRecord_ViewController.h"

#import "SSKJ_H5Web_ViewController.h"

#import "Mine_TitleAndInput_View.h"

#import "UITextField+Helper.h"

@interface Market_KeyBuyCoin_VC ()<UITextFieldDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic,strong) UILabel * cnyLabel;

@property (nonatomic,strong) UILabel * buyLabel;

@property (nonatomic,strong) UILabel * usdtLabel;

@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UILabel * unitLabel;

@property (nonatomic, strong) Mine_TitleAndInput_View *numberView;
@property (nonatomic, strong) Mine_TitleAndInput_View *phoneView;
@property (nonatomic, strong) Mine_TitleAndInput_View *nameView;


@property (nonatomic,strong) UIButton * submitBtn;

@property (nonatomic,strong) UILabel * tipTitle;

@property (nonatomic,strong) UILabel * tipDetail;

@end

@implementation Market_KeyBuyCoin_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = kBgColor;
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    [self setNavgationBackgroundColor:kSubBgColor alpha:1];
    
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"充币--记录"]];
    
    self.title = SSKJLocalized(@"快捷买币", nil);
    
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.buyLabel];
    
    [self.scrollView addSubview:self.cnyLabel];
    
    [self.scrollView addSubview:self.usdtLabel];
    
    [self.scrollView addSubview:self.lineView];
    
    [self.scrollView addSubview:self.numberView];
    
    [self.numberView addSubview:self.unitLabel];
    
    [self.scrollView addSubview:self.nameView];

    [self.scrollView addSubview:self.phoneView];

    
    [self.scrollView addSubview:self.submitBtn];
    
    [self.scrollView addSubview:self.tipTitle];
    
    [self.scrollView addSubview:self.tipDetail];
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.tipDetail.bottom + ScaleW(20));
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavgationBackgroundColor:kSubBgColor alpha:1];
}


#pragma mark - 记录
-(void)rigthBtnAction:(id)sender
{
    BuyCoinRecord_ViewController *vc = [[BuyCoinRecord_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar)];
    }
    return _scrollView;
}

- (UILabel *)buyLabel{
    if (_buyLabel == nil) {
        
        NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
        CGFloat width = ScaleW(30);
        if ([language containsString:@"en"]) {
            width = ScaleW(80);
        }
        
        _buyLabel = [FactoryUI createLabelWithFrame:CGRectMake(0, ScaleW(30), width, ScaleW(15)) text:SSKJLocalized(@"买", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
        _buyLabel.adjustsFontSizeToFitWidth = YES;
        _buyLabel.textAlignment = NSTextAlignmentCenter;
        _buyLabel.centerX = ScreenWidth / 2;
    }
    return _buyLabel;
}

- (UILabel *)cnyLabel{
    if (_cnyLabel == nil) {
        _cnyLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.buyLabel.x - ScaleW(62), 0, ScaleW(52), ScaleW(22)) text:SSKJLocalized(@"人民币", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
        _cnyLabel.textAlignment = NSTextAlignmentCenter;
        _cnyLabel.centerY = self.buyLabel.centerY;
        _cnyLabel.cornerRadius = ScaleW(3);
        _cnyLabel.backgroundColor = RED_HEX_COLOR;
    }
    return _cnyLabel;
}

- (UILabel *)usdtLabel{
    if (_usdtLabel == nil) {
        _usdtLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.buyLabel.right + ScaleW(10), 0, ScaleW(52), ScaleW(22)) text:SSKJLocalized(@"USDT", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
        _usdtLabel.centerY = self.buyLabel.centerY;
        _usdtLabel.textAlignment = NSTextAlignmentCenter;
        _usdtLabel.cornerRadius = ScaleW(3);
        _usdtLabel.backgroundColor = GREEN_HEX_COLOR;
    }
    return _usdtLabel;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [FactoryUI createViewWithFrame:CGRectMake(ScaleW(15), self.cnyLabel.bottom + ScaleW(15), ScreenWidth - ScaleW(30), 1) Color:kLightLineColor];
    }
    return _lineView;
}


- (Mine_TitleAndInput_View *)numberView {
    if (_numberView == nil) {
        _numberView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.lineView.bottom + ScaleW(20), ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"买入数量", nil) placeHolder:SSKJLocalized(@"请输入买入数量", nil) keyBoardType:UIKeyboardTypeDecimalPad isSecure:NO];
        _numberView.textField.delegate = self;
        [_numberView.textField addTarget:self action:@selector(inputChanged:) forControlEvents:UIControlEventEditingChanged];
    }
    return _numberView;
}


- (UILabel *)unitLabel{
    if (_unitLabel == nil) {
        _unitLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScreenWidth - ScaleW(15) - ScaleW(45), 0, ScaleW(45), ScaleW(20)) text:SSKJLocalized(@"USDT", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
        _unitLabel.centerY = self.numberView.textField.centerY;
    }
    return _unitLabel;
}


- (Mine_TitleAndInput_View *)nameView {
    if (_nameView == nil) {
        _nameView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.numberView.bottom, ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"姓名", nil) placeHolder:SSKJLocalized(@"请输入您的真实姓名", nil) keyBoardType:UIKeyboardTypeDefault isSecure:NO];
    }
    return _nameView;
}



- (Mine_TitleAndInput_View *)phoneView {
    if (_phoneView == nil) {
        _phoneView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.nameView.bottom, ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"手机号", nil) placeHolder:SSKJLocalized(@"请输入手机号", nil) keyBoardType:UIKeyboardTypeNumberPad isSecure:NO];
    }
    return _phoneView;
}


- (UIButton *)submitBtn{
    if (_submitBtn == nil) {
        _submitBtn = [FactoryUI createButtonWithFrame:CGRectMake(ScaleW(15), self.phoneView.bottom + ScaleW(40), ScreenWidth - ScaleW(30), ScaleW(45)) title:SSKJLocalized(@"确定购买", nil) titleColor:kTitleColor imageName:@"" backgroundImageName:@"Btn_BgImg" target:self selector:@selector(submitBtnAction) font:systemFont(ScaleW(15))];
        _submitBtn.backgroundColor = kBlueColor;
        _submitBtn.layer.cornerRadius = ScaleW(5);
    }
    return _submitBtn;
}

- (UILabel *)tipTitle{
    if (_tipTitle == nil) {
        _tipTitle = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.submitBtn.bottom + ScaleW(30), self.submitBtn.width, ScaleW(15)) text:SSKJLocalized(@"快捷买币说明：", nil) textColor:kTitleColor font:systemFont(ScaleW(15))];
    }
    return _tipTitle;
}

- (UILabel *)tipDetail{
    if (_tipDetail == nil) {
        
        NSString *string = SSKJLocalized(@"1、行情火爆，购币人数过多，商家应接不暇，支付宝、微信转账如无法支付，请使用银行卡转账\n2、请提前做好购币准备，以免影响您的交易", nil);
        
        _tipDetail = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(15), self.tipTitle.bottom + ScaleW(10), self.tipTitle.width, ScaleW(50)) text:string textColor:kSubTitleColor font:systemFont(ScaleW(15))];
        _tipDetail.numberOfLines = 0;
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_tipDetail.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_tipDetail.font} context:nil].size.height;
        _tipDetail.height = height;
    }
    return _tipDetail;
}
                



#pragma mark - NetWork Method 网络请求
- (void)submitBtnAction{
    
    if (self.numberView.valueString.doubleValue == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入买入数量", nil)];
        return;
    }
    
    if (self.nameView.valueString.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的真实姓名", nil)];
        return;
    }
    
    if (self.phoneView.valueString.length == 0) {
       [MBProgressHUD showError:SSKJLocalized(@"请输入手机号", nil)];
       return;
   }
    
    if (![RegularExpression validateMobile:self.phoneView.valueString]) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入正确的手机号", nil)];
        return;

    }
  
    WS(weakSelf);
    
    NSDictionary *params = @{
                            @"money":self.numberView.valueString,
                            @"phone":self.phoneView.valueString,
                            @"name":self.nameView.valueString
                            };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_FastPay_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (net_model.status.integerValue == SUCCESSED)
        {
            [MBProgressHUD showError:net_model.msg];
            [weakSelf clearView];
            
            SSKJ_H5Web_ViewController *vc = [[SSKJ_H5Web_ViewController alloc]init];
            vc.url = net_model.data[@"link"];
            vc.title = SSKJLocalized(@"支付", nil);
            [weakSelf.navigationController pushViewController:vc animated:YES];
            
        }
        else
        {
            [MBProgressHUD showError:net_model.msg];
        }
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        
    }];

        
}


-(void)clearView
{
    self.numberView.valueString = @"";
    self.nameView.valueString = @"";
    self.phoneView.valueString = @"";
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.numberView.textField) {
        return [textField textFieldShouldChangeCharactersInRange:range replacementString:string dotNumber:2];
    }
    
    return YES;
}

-(void)inputChanged:(UITextField *)textField
{
    textField.text = [self deleteFirstZero:textField.text];
}


// 出去首位0
-(NSString *)deleteFirstZero:(NSString *)string
{
    if (![string hasPrefix:@"0"] || [string isEqualToString:@"0"] || [string hasPrefix:@"0."]) {
        
        return string;
    }else{
        return [self deleteFirstZero:[string substringFromIndex:1]];
    }
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
