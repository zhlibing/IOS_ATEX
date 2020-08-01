//
//  BLMangeAddressViewController.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/3/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLMangeAddressViewController.h"
#import "QBScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>//相册
@interface BLMangeAddressViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *TopContraint;
@property (weak, nonatomic) IBOutlet UILabel *dizhiLable;
@property (weak, nonatomic) IBOutlet UILabel *beizhulabel;
@property (weak, nonatomic) IBOutlet UIView *addressBackView;
@property (weak, nonatomic) IBOutlet UIView *remarkBackView;

@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *noteTextField;
@property (weak, nonatomic) IBOutlet UIButton *confirmButton;


@end

@implementation BLMangeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"添加提币地址", nil);
    
    UIView *line = [self getLineView];
    [self.view addSubview:line];
    
    self.view.backgroundColor = kBgColor;
    self.addressBackView.backgroundColor = kBgColor;
    self.remarkBackView.backgroundColor = kBgColor;
    self.dizhiLable.textColor = kTitleColor;
    self.beizhulabel.textColor = kTitleColor;
    self.addressTextField.textColor = kTitleColor;
    self.noteTextField.textColor = kTitleColor;
    
    self.TopContraint.constant = Height_NavBar + ScaleW(20);
    self.addressTextField.adjustsFontSizeToFitWidth = YES;
    self.addressTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.noteTextField.clearButtonMode=UITextFieldViewModeWhileEditing;
    self.addressTextField.placeholder=SSKJLocalized(@"请输入钱包地址", nil);
    
    self.noteTextField.placeholder = SSKJLocalized(@"请输入备注信息", nil);

    
    self.dizhiLable.text = SSKJLocalized(@"地址", nil);
    self.beizhulabel.text = SSKJLocalized(@"备注", nil);
    [self.confirmButton setTitle:SSKJLocalized(@"添加", nil) forState:0];
    self.confirmButton.backgroundColor = kBlueColor;
}

- (IBAction)scanCodeClicked:(UIButton *)sender
{
 
    [self videoAuthAction];

    
     AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    //NSString *tips = @"您没有权限访问相机,请去设置中开启！";
    if(status == AVAuthorizationStatusAuthorized)
    {
        QBScanCodeViewController *scan = [[QBScanCodeViewController alloc]init];
        __weak BLMangeAddressViewController *weakSelf = self;
        scan.codeScaningString = ^(NSString *string) {
            
            weakSelf.addressTextField.adjustsFontSizeToFitWidth = YES;
            weakSelf.addressTextField.text = string;
        };
        NSInteger count = self.tabBarController.viewControllers.count;
        self.tabBarController.selectedIndex = count - 1;
        [self.navigationController pushViewController:scan animated:YES];
        
    }
    else
    {
        
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


- (void)textValueChanged {
//    if (_addressTextField.text.length != 0 && _noteTextField.text.length != 0 ) {
//        _confirmButton.enabled = YES;
//        _confirmButton.backgroundColor = kSubTitleColor;
//    } else {
//        _confirmButton.enabled = NO;
//        _confirmButton.backgroundColor = kSubBgColor;
//    }
}

- (IBAction)confirmAction:(UIButton *)sender {
    
    if (self.addressTextField.text.length == 0) {
        [MBProgressHUD showError:SSKJLocalized(@"请输入地址", nil)];
        return;
    }else if (self.noteTextField.text.length == 0){
        [MBProgressHUD showError:SSKJLocalized(@"请输入备注", nil)];
        return;
    }

    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"toAddr"] = _addressTextField.text;
    params[@"remark"] = _noteTextField.text;
    params[@"stockUserId"] = kUserID;
    params[@"type"] = @"2";

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_AddAddress_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            [MBProgressHUD showError:network_Model.msg];
            [self.navigationController popViewControllerAnimated:YES];

        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
    
}


#pragma mark - 收起键盘
/**
 点击 return 收起键盘
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    return [textField resignFirstResponder];
}
/**
 点击 空白处 收起键盘
 */
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
-(void)setCurrentType:(NSString *)currentType{
    _currentType = currentType;

}


@end
