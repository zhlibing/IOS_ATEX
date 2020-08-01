//
//  HeBi_AddAddress_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/11.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "HeBi_AddAddress_ViewController.h"

// controller
#import "QBScanCodeViewController.h"

// tools
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>//相册

@interface HeBi_AddAddress_ViewController ()

@property (nonatomic, strong) UIView *addressBackView;
@property (nonatomic, strong) UILabel *addressTitleLabel;
@property (nonatomic, strong) UITextField *addressTextField;
@property (nonatomic, strong) UIButton *sweepButton;    // 扫描按钮

@property (nonatomic, strong) UILabel *remarkTitleLabel;

@property (nonatomic, strong) UIView *remarkBackView;
@property (nonatomic, strong) UITextField *remarkTextField;

@property (nonatomic, strong) UIButton *addButton;

@end

@implementation HeBi_AddAddress_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"添加提币地址", nil);
    [self setUI];

}

#pragma mark - UI

-(void)setUI
{
    UIView *topGrayView = [UIView new];
    topGrayView.backgroundColor = kSubBgColor;
    topGrayView.frame = CGRectMake(0, 0, ScreenWidth, ScaleW(10));
    [self.view addSubview:topGrayView];
    
    [self.view addSubview:self.addressTitleLabel];
    [self.view addSubview:self.addressBackView];
    [self.addressBackView addSubview:self.sweepButton];
    [self.addressBackView addSubview:self.addressTextField];
    
    [self.view addSubview:self.remarkTitleLabel];
    [self.view addSubview:self.remarkBackView];
    [self.remarkBackView addSubview:self.remarkTextField];
    
    [self.view addSubview:self.addButton];
}

-(UILabel *)addressTitleLabel
{
    if (nil == _addressTitleLabel) {
        _addressTitleLabel = [WLTools allocLabel:SSKJLocalized(@"地址", nil) font:systemBoldFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(100), ScaleW(40)) textAlignment:NSTextAlignmentLeft];
    }
    return _addressTitleLabel;
}


-(UIView *)addressBackView
{
    if (nil == _addressBackView) {
        _addressBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.addressTitleLabel.bottom, ScreenWidth, ScaleW(60))];
        _addressBackView.backgroundColor = kBgColor;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _addressBackView.height - ScaleW(1), _addressBackView.width, ScaleW(1))];
        lineView.backgroundColor = kLineColor;
        [_addressBackView addSubview:lineView];
    }
    return _addressBackView;
}


-(UIButton *)sweepButton
{
    if (nil == _sweepButton) {
        _sweepButton = [[UIButton alloc]initWithFrame:CGRectMake(ScreenWidth - ScaleW(50), 0, ScaleW(50), ScaleW(50))];
        [_sweepButton setImage:[UIImage imageNamed:@"mine_saoma"] forState:UIControlStateNormal];
        [_sweepButton addTarget:self action:@selector(sweepEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sweepButton;
}


-(UITextField *)addressTextField
{
    if (nil == _addressTextField) {
        _addressTextField = [[UITextField alloc]initWithFrame:CGRectMake(ScaleW(15), 0 , self.sweepButton.x - ScaleW(15) - ScaleW(15), self.addressBackView.height - 1)];
        _addressTextField.centerY = self.sweepButton.centerY;
        _addressTextField.textColor = kTitleColor;
        _addressTextField.font = systemFont(ScaleW(15));
        _addressTextField.placeholder = SSKJLocalized(@"请输入钱包地址", nil);
        _addressTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_addressTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _addressTextField;
}




-(UILabel *)remarkTitleLabel
{
    if (nil == _remarkTitleLabel) {
        _remarkTitleLabel = [WLTools allocLabel:SSKJLocalized(@"描述", nil) font:systemBoldFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.addressBackView.bottom, ScaleW(100), self.addressTitleLabel.height) textAlignment:NSTextAlignmentLeft];
    }
    return _remarkTitleLabel;
}


-(UIView *)remarkBackView
{
    if (nil == _remarkBackView) {
        _remarkBackView = [[UIView alloc]initWithFrame:CGRectMake(0, self.remarkTitleLabel.bottom, ScreenWidth, ScaleW(60))];
        _remarkBackView.backgroundColor = kBgColor;
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _remarkBackView.height - ScaleW(1), _remarkBackView.width, ScaleW(1))];
        lineView.backgroundColor = kLineColor;
        [_remarkBackView addSubview:lineView];
    }
    return _remarkBackView;
}


-(UITextField *)remarkTextField
{
    if (nil == _remarkTextField) {
        _remarkTextField = [[UITextField alloc]initWithFrame:CGRectMake(self.addressTextField.x, 0, ScreenWidth - ScaleW(30), self.remarkBackView.height)];
        _remarkTextField.textColor = kTitleColor;
        _remarkTextField.font = systemFont(ScaleW(15));
        _remarkTextField.placeholder = SSKJLocalized(@"填写备注信息", nil);
        _remarkTextField.keyboardType = UIKeyboardTypeASCIICapable;
//        [_remarkTextField setValue:kSubTitleColor forKeyPath:@"_placeholderLabel.textColor"];
    }
    return _remarkTextField;
}


-(UIButton *)addButton
{
    if (nil == _addButton) {
        
        _addButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(45) - ScaleW(10) - Height_NavBar, ScreenWidth - ScaleW(30), ScaleW(45))];
        _addButton.backgroundColor = kBlueColor;
        [_addButton setTitle:SSKJLocalized(@"添加", nil) forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _addButton.titleLabel.font = systemBoldFont(ScaleW(15));
        _addButton.layer.cornerRadius =ScaleW(45/2.0);
        [_addButton addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

#pragma mark - 用户操作

// 扫描

-(void)sweepEvent
{
    [self videoAuthAction];
    
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //NSString *tips = @"您没有权限访问相机,请去设置中开启！";
    if(status == AVAuthorizationStatusAuthorized)
    {
        QBScanCodeViewController *scan = [[QBScanCodeViewController alloc]init];
        WS(weakSelf);
        scan.codeScaningString = ^(NSString *string) {
            weakSelf.addressTextField.adjustsFontSizeToFitWidth = YES;
            weakSelf.addressTextField.text = string;
        };
        [self.navigationController pushViewController:scan animated:YES];
        
    }
    
}

//授权相机
- (void)videoAuthAction
{
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        SSLog(@"%@",granted ? @"相机准许":@"相机不准许");
        [self checkVideoStatus];
    }];
}

//检查相机权限
- (void)checkVideoStatus
{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusNotDetermined:
            //没有询问是否开启相机
            //self.videoStatus = @"AVAuthorizationStatusNotDetermined";
            break;
        case AVAuthorizationStatusRestricted:
            //未授权，家长限制
            //self.videoStatus = @"AVAuthorizationStatusRestricted";
            break;
        case AVAuthorizationStatusDenied:
            //未授权
            // self.videoStatus = @"AVAuthorizationStatusDenied";
            break;
        case AVAuthorizationStatusAuthorized:
            //玩家授权
            // self.videoStatus = @"AVAuthorizationStatusAuthorized";
            break;
        default:
            break;
    }
    
}

// 确认添加
-(void)addEvent
{
    if (self.addressTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入钱包地址", nik)];
        return;
    }
    
    if (self.remarkTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请填写备注信息", nik)];
        return;
    }
    [self requestAddAddress];
    
}

#pragma mark - 网络请求
#pragma mark  请求添加地址

-(void)requestAddAddress
{
    
    NSDictionary *params = @{
                                    @"toAddr":self.addressTextField.text,
                                    @"remark":self.remarkTextField.text,
                                    @"type":self.coinType,
                                    @"stockUserId":kUserID
                                    };
    

    
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_AddAddress_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (net_model.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:net_model.msg];
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
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
