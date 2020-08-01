//
//  BIPaymentBoardView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIPaymentBoardView.h"
#import "BIPaymentBoardItemView.h"
#import "BIAlipaWeiXinyPaymentScrollView.h"
#import "BIImagePickerController.h"
#import "BIPaymentMask.h"
#import "SSKJ_Default_ActionsheetView.h"






@interface BIPaymentBoardView () <BIPaymentMaskDelegate,BIImagePickerControllerDelegate>

@property (nonatomic, strong) NSMutableDictionary *parameters; //!< 参数字典

@property (nonatomic,strong) BIPaymentMask *maskView;

@property (nonatomic,strong) UILabel *tipLabel;  //!< 添加支付方式的提示标题
@property (nonatomic,strong) UIButton *dismissBtn; //!< 消失x按钮
@property (nonatomic,strong) UIButton *cancelBtn;  //!< 取消按钮
@property (nonatomic,strong) UIButton *confirmBtn; //!< 确定按钮


@property (nonatomic,strong) BIPaymentBoardItemView *paymentView; //!< 支付方式
@property (nonatomic,strong) BIAlipaWeiXinyPaymentScrollView *weixinPaymentView; //!< 微信支付
@property (nonatomic,strong) BIAlipaWeiXinyPaymentScrollView *aliPaymentView; //!< 支付宝支付
@property (nonatomic,strong) BIAlipaWeiXinyPaymentScrollView *bankPaymentView; //!< 银行卡支付















@end



@implementation BIPaymentBoardView





- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setType:1];
        [self.parameters setObject:@"1" forKey:@"payWay"];
        [self.parameters setObject:kUserID forKey:@"id"];
        [self setBackgroundColor:kBgColor];
        [self setLayerCornerRadius:5.0];
        
        
        [self addSubview:self.tipLabel];
        [self addSubview:self.dismissBtn];
        [self addSubview:self.paymentView];
        [self addSubview:self.weixinPaymentView];
        [self addSubview:self.aliPaymentView];
        [self addSubview:self.bankPaymentView];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.confirmBtn];
        [self addSubview:self.maskView];
        
        
        
        
        CGFloat height = frame.size.height-ScaleW(215);
        #pragma mark 重置Frame
        [self.tipLabel setFrame:CGRectMake(10, 0, frame.size.width/2.0, ScaleW(50))];
        [self.dismissBtn setFrame:CGRectMake(frame.size.width-ScaleW(40), ScaleW(10), ScaleW(30), ScaleW(30))];
        
        [self.paymentView resetFrame:CGRectMake(self.tipLabel.left, self.tipLabel.bottom, frame.size.width-ScaleW(20), ScaleW(85)) withType:3];
        
        
        [self.weixinPaymentView resetFrame:CGRectMake(self.tipLabel.left, self.paymentView.bottom,self.paymentView.width, ScaleW(height)) withType:1];
        [self.weixinPaymentView setContentSize:CGSizeMake(self.paymentView.width, ScaleW(390/*内部控件总高度为380，下面间隔为10，所以设置390*/))];
        
        [self.aliPaymentView resetFrame:CGRectMake(self.tipLabel.left, self.paymentView.bottom,self.paymentView.width, ScaleW(height)) withType:1];
        [self.aliPaymentView setContentSize:CGSizeMake(self.paymentView.width, ScaleW(390/*内部控件总高度为380，下面间隔为10，所以设置390*/))];
        
        
        
        [self.bankPaymentView resetFrame:CGRectMake(self.tipLabel.left, self.paymentView.bottom,self.paymentView.width, ScaleW(height)) withType:2];
        [self.bankPaymentView setContentSize:CGSizeMake(self.paymentView.width, ScaleW(435/*内部控件总高度为425，下面间隔为10，所以设置425*/))];
        
        
        
        
        [self.cancelBtn setFrame:CGRectMake(self.tipLabel.left, (frame.size.height-ScaleW(60)), ((self.paymentView.size.width-ScaleW(20))/2.0), ScaleW(40))];
        [self.confirmBtn setFrame:CGRectMake(self.cancelBtn.right+ScaleW(10), self.cancelBtn.top, self.cancelBtn.width, self.cancelBtn.height)];
        [self.confirmBtn setLayerCornerRadius:(self.confirmBtn.height/2)];
        
        
        [self.maskView resetFrame:CGRectMake(frame.size.width-ScaleW(120), self.paymentView.top+65, ScaleW(100), ScaleW(120))];
        
    }
    return self;
}




#pragma mark 设置选中第几个显示
/**
 设置选中第几个显示
 
 @param type 设置第几个
 */
- (void)setType:(NSInteger)type
{
    _type = type;
    [self.aliPaymentView setHidden:YES];
    [self.weixinPaymentView setHidden:YES];
    [self.bankPaymentView setHidden:YES];
    
    switch (type)
    {
#pragma mark case 1  微信
        case 1:
        {
            [self.paymentView setTip:@"微信" withType:3];
            [self.weixinPaymentView setHidden:NO];
        }
            break;
#pragma mark case 2 支付宝
        case 2:
        {
            [self.paymentView setTip:@"支付宝" withType:3];
            [self.aliPaymentView setHidden:NO];
        }
            break;
#pragma mark case 3  银行卡
        case 3:
        {
            [self.paymentView setTip:@"银行卡" withType:3];
            [self.bankPaymentView setHidden:NO];
        }
            break;
    }
}



#pragma mark 编辑进来设置的数据模型
-(void)setModel:(BISecurityCenterModel *)model
{
    [self.parameters setObject:model.objectid forKey:@"id"];
    [self.tipLabel setText:SSKJLocalized(@"修改支付方式", nil)];
    [self setType:model.paymentType];
    
    
    WS(weakSelf);
    
    
    //!< 根据要修改的支付id获取回显数据，获取到数据之后然后根据修改的支付类型去填充内容
    [MBHUD showHUDAddedTo:self];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_UpdatePayWay_URL RequestType:RequestTypeGet Parameters:@{@"id":model.objectid} Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
            #pragma mark 根据要修改的支付的类型填充内容
             switch (model.paymentType)
             {
                 case BISecurityCenterWeiXinType:
                 {
                     [weakSelf.weixinPaymentView setUserName:[SSKJ_User_Tool sharedUserTool].userInfoModel.username withPayAccount:model.account withQRUrl:model.qrCode];
                 }
                     break;
                 case BISecurityCenterAliPayType:
                 {
                     [weakSelf.aliPaymentView setUserName:[SSKJ_User_Tool sharedUserTool].userInfoModel.username withPayAccount:model.account withQRUrl:model.qrCode];
                 }
                     break;
                 case BISecurityCenterBankCardType:
                 {
                     [weakSelf.bankPaymentView setUserName:[SSKJ_User_Tool sharedUserTool].userInfoModel.username withBankName:model.accountOpeningBranch withPayAccount:model.account withOpenOptionBank:model.bankCardOpenBank];
                 }
                     break;
             }
             
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:self];
         [MBHUD showError:SSKJLocalized(@"网络错误", nil)];
     }];
}





#pragma mark - Public Method
#pragma mark 切换支付方式
-(void)optionControlAction:(UIControl*)sender
{
    switch (self.addEditType)
    {
        case PayMentAddType:
        {
            [self.maskView setHidden:NO];
        }
            break;
        case PayMentEditType:
            break;
    }
}











#pragma mark - Private Method
#pragma mark 取消按钮触发的方法
-(void)dismissAndcancelBtnAction:(UIButton*)sender
{
    if ([self.delegate respondsToSelector:@selector(paymentBoardAction:)])
    {
        [self.delegate paymentBoardAction:sender.tag];
    }
}


#pragma mark 确定提交
-(void)confirmBtnAction:(UIButton*)sender
{
    switch (self.type)
    {
        #pragma mark case 1 微信参数
        case 1:
        {
            [self.parameters setObject:@"1" forKey:@"payWay"];
            NSString *name = self.weixinPaymentView.nameView.describeLabel.describeLabel.text;
            NSString *weixinAccount = self.weixinPaymentView.accountNumnerView.textField.text;
            NSString *qrUrl = self.weixinPaymentView.codeView.codeUrl;
            NSString *pwd = self.weixinPaymentView.passwordView.textField.text;
            
            //!< 用户名称
            if (name.length)
            {
                [self.parameters setObject:name forKey:@"username"];
            }
            else
            {
                [MBHUD showError:SSKJLocalized(@"请输入姓名", nil)];
                return;
            }
            
            
            if ([self authWeiXinAccount:weixinAccount withQrCodeUrl:qrUrl withPwd:pwd])
            {
                [self aaddPayWay:self.parameters];
            }
        }
            break;
#pragma mark case 2 支付宝参数
        case 2:
        {
            [self.parameters setObject:@"2" forKey:@"payWay"];
            NSString *name = self.aliPaymentView.nameView.describeLabel.describeLabel.text;
            NSString *aliPayAccount = self.aliPaymentView.accountNumnerView.textField.text;
            NSString *qrUrl = self.aliPaymentView.codeView.codeUrl;
            NSString *pwd = self.aliPaymentView.passwordView.textField.text;
            
            //!< 用户名称
            if (name.length)
            {
                [self.parameters setObject:name forKey:@"username"];
            }
            else
            {
                [MBHUD showError:SSKJLocalized(@"请输入姓名", nil)];
                return;
            }
            
            if ([self authAlipayAccount:aliPayAccount withQrCodeUrl:qrUrl withPwd:pwd])
            {
                [self aaddPayWay:self.parameters];
            }
           
        }
            break;
        #pragma mark case 3 银行卡参数
        case 3:
        {
            [self.parameters setObject:@"3" forKey:@"payWay"];
            NSString *name = self.bankPaymentView.nameView.describeLabel.describeLabel.text;
            NSString *bankName = self.bankPaymentView.accountNumnerView.textField.text;
            NSString *bankNumber = self.bankPaymentView.bankNumberView.textField.text;
            NSString *opemnBank = self.bankPaymentView.openBankView.textField.text;
            NSString *pwd = self.bankPaymentView.passwordView.textField.text;
            
            //!< 用户名称
            if (name.length)
            {
                [self.parameters setObject:name forKey:@"username"];
            }
            else
            {
                [MBHUD showError:SSKJLocalized(@"请输入姓名", nil)];
                return;
            }
            
            if ([self authBankName:bankName withBankNumber:bankNumber withOpemnBank:opemnBank withPwd:pwd])
            {
                 [self aaddPayWay:self.parameters];
            }
        }
            break;
    }
}



#pragma mark 点击修改支付方式
-(void)editPayMent:(BOOL)payment
{
    switch (self.model.paymentType)
    {
        case BISecurityCenterWeiXinType:
        {
            NSString *weixinAccount = self.weixinPaymentView.accountNumnerView.textField.text;
            NSString *qrUrl = self.weixinPaymentView.codeView.codeUrl;
            NSString *pwd = self.weixinPaymentView.passwordView.textField.text;
            
            [self.parameters setObject:@"1" forKey:@"payType"];
            [self authWeiXinAccount:weixinAccount withQrCodeUrl:qrUrl withPwd:pwd];
        }
            break;
        case BISecurityCenterAliPayType:
        {
            NSString *alipatAccount = self.aliPaymentView.accountNumnerView.textField.text;
            NSString *qrUrl = self.aliPaymentView.codeView.codeUrl;
            NSString *pwd = self.aliPaymentView.passwordView.textField.text;
            [self.parameters setObject:@"2" forKey:@"payType"];
            [self authAlipayAccount:alipatAccount withQrCodeUrl:qrUrl withPwd:pwd];
        }
            break;
        case BISecurityCenterBankCardType:
        {
            NSString *bankName = self.bankPaymentView.accountNumnerView.textField.text;
            NSString *bankNumber = self.bankPaymentView.bankNumberView.textField.text;
            NSString *opemnBank = self.bankPaymentView.openBankView.textField.text;
            NSString *pwd = self.bankPaymentView.passwordView.textField.text;
            
            [self.parameters setObject:@"2" forKey:@"payType"];
            [self authBankName:bankName withBankNumber:bankNumber withOpemnBank:opemnBank withPwd:pwd];
        }
            break;
    }
    
    
    
    
}


#pragma mark 点击相机上传内容
-(void)uploadBtnAction:(UIControl*)sender
{
    
    [SSKJ_Default_ActionsheetView showWithItems:@[SSKJLocalized(@"相机", nil),SSKJLocalized(@"相册", nil)] title:@"" selectedIndexBlock:^(NSInteger selectIndex)
     {
         switch (selectIndex)
         {
             case 0:
             {
                 BIImagePickerController *image = [[BIImagePickerController alloc] initWithType:1 witDelegate:self];
                 [[WLTools getCurrentViewController] presentViewController:image animated:YES completion:^{}];
             }
                 break;
             case 1:
             {
                 BIImagePickerController *image = [[BIImagePickerController alloc] initWithType:2 witDelegate:self];
                 [[WLTools getCurrentViewController] presentViewController:image animated:YES completion:^{}];
             }
                 break;
         }
         
     } cancleBlock:^{}];

}



#pragma mark - NetWork Method 网络请求
#pragma mark 添加支付方式
-(void)aaddPayWay:(NSDictionary*)parameters
{
 
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_AddPayWay_URL RequestType:RequestTypePost Parameters:parameters Success:^(NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:self];
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             [[WLTools getCurrentViewController] dismissViewControllerAnimated:YES completion:^{
                 
                 [MBHUD hideHUDForView:weakSelf];
                 
             }];
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
         
         
         
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
         
         
         [MBHUD hideHUDForView:self];
     }];
    
    
    
    
}



#pragma mark - Deletage Method
#pragma mark BIPaymentMaskDelegate  (选择支付宝、微信和银行卡支付)
-(void)paymentAction:(BIPaymentMaskOptionControl *)sender
{
    [self setType:sender.tag];
}



#pragma mark BIImagePickerControllerDelegate
- (void)didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)editingInfo
{
    WS(weakSelf);
    //!< 限制图片在1M以内
    image = [UIImage compressImageQuality:image toByte:(1*1024)];
    [[WLHttpManager shareManager]  upLoadImageByUrl:BI_Upload_URL ImageName:@"file" Params:nil Image:image CallBack:^(id responseObject)
     {
         [MBHUD hideHUDForView:self];
         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         //!< 如果上传成功就把当前图片地址存到数组中并进行下一步操作
         if (netModel.status.integerValue == 200)
         {
             [weakSelf showImage:image withCodeUrl:netModel.data];
         }
         else
         {
             [MBHUD showError:netModel.msg];
         }
     } Failure:^(NSError *error) {
         
         [MBHUD hideHUDForView:self];
         [MBHUD showError:SSKJLocalized(@"网络错误", nil)];
     }];
    
    
}



#pragma mark 显示图片并保存的二维码的图片地址
-(void)showImage:(UIImage*)image withCodeUrl:(NSString *)codeUrl;
{
    switch (self.type)
    {
        case 1:
        {
            [self.weixinPaymentView setImage:image];
            [self.weixinPaymentView.codeView setCodeUrl:codeUrl];
        }
            break;
        case 2:
        {
            [self.aliPaymentView setImage:image];
            [self.aliPaymentView.codeView setCodeUrl:codeUrl];
        }
            break;
        case 3:
        {
            [self.bankPaymentView setImage:image];
            [self.bankPaymentView.codeView setCodeUrl:codeUrl];
        }
            break;
    }
}

















#pragma mark - Getter / Setter
- (UILabel *)tipLabel
{
    if (!_tipLabel)
    {
        _tipLabel = [FactoryUI createLabelWithFrame:CGRectZero text:SSKJLocalized(@"添加支付方式", nil) textColor:kBlueColor font:systemFont(ScaleW(15.0))];
    }
    return _tipLabel;
}


-(UIButton *)dismissBtn
{
    if (!_dismissBtn)
    {
        _dismissBtn = [FactoryUI createButtonWithFrame:CGRectZero title:nil titleColor:nil imageName:@"Mine_dismiis" backgroundImageName:nil target:self selector:@selector(dismissAndcancelBtnAction:) font:systemFont(1)];
        [_dismissBtn setTag:1];
    }
    return _dismissBtn;
}


-(BIPaymentBoardItemView *)paymentView
{
    if (!_paymentView)
    {
        _paymentView = [[BIPaymentBoardItemView alloc]initWithType:3];
        [_paymentView setTitle:SSKJLocalized(@"支付方式", nil) withTip:SSKJLocalized(@"支付宝", nil) withType:3];
        [_paymentView.optionControl addTarget:self action:@selector(optionControlAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _paymentView;
}


-(BIAlipaWeiXinyPaymentScrollView *)weixinPaymentView
{
    if (!_weixinPaymentView)
    {
        _weixinPaymentView = [[BIAlipaWeiXinyPaymentScrollView alloc]initWithType:1];
        [_weixinPaymentView setHidden:NO];
        [_weixinPaymentView.nameView setTitle:SSKJLocalized(@"姓名", nil) withTip:[SSKJ_User_Tool sharedUserTool].userInfoModel.username withType:4];
        [_weixinPaymentView.accountNumnerView setTitle:SSKJLocalized(@"微信账号", nil) withPlaceholder:SSKJLocalized(@"请输入微信账号", nil)];
        [_weixinPaymentView.codeView setTitle:SSKJLocalized(@"收款二维码", nil) withTip:SSKJLocalized(@"上传收款二维码", nil) withType:3];
        [_weixinPaymentView.passwordView setTitle:SSKJLocalized(@"资金密码", nil) withPlaceholder:SSKJLocalized(@"请输入资金密码", nil)];
        [_weixinPaymentView.codeView.upLoadControl addTarget:self action:@selector(uploadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _weixinPaymentView;
}


-(BIAlipaWeiXinyPaymentScrollView *)aliPaymentView
{
    if (!_aliPaymentView)
    {
        _aliPaymentView = [[BIAlipaWeiXinyPaymentScrollView alloc]initWithType:1];
        [_aliPaymentView setHidden:YES];
        [_aliPaymentView.nameView setTitle:SSKJLocalized(@"姓名", nil) withTip:[SSKJ_User_Tool sharedUserTool].userInfoModel.username withType:4];
        [_aliPaymentView.accountNumnerView setTitle:SSKJLocalized(@"支付宝账号", nil) withPlaceholder:SSKJLocalized(@"请输入支付宝账号", nil)];
        
        [_aliPaymentView.codeView setTitle:SSKJLocalized(@"收款二维码", nil) withTip:SSKJLocalized(@"上传收款二维码", nil) withType:3];
        [_aliPaymentView.passwordView setTitle:SSKJLocalized(@"资金密码", nil) withPlaceholder:SSKJLocalized(@"请输入资金密码", nil)];
        [_aliPaymentView.codeView.upLoadControl addTarget:self action:@selector(uploadBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _aliPaymentView;
}

-(BIAlipaWeiXinyPaymentScrollView *)bankPaymentView
{
    if (!_bankPaymentView)
    {
        _bankPaymentView = [[BIAlipaWeiXinyPaymentScrollView alloc]initWithType:2];
        [_bankPaymentView setHidden:YES];
        [_bankPaymentView.nameView setTitle:SSKJLocalized(@"姓名", nil) withTip:[SSKJ_User_Tool sharedUserTool].userInfoModel.username withType:4];
        [_bankPaymentView.accountNumnerView setTitle:SSKJLocalized(@"开户银行", nil) withPlaceholder:SSKJLocalized(@"请输入开户银行名称", nil)];
        [_bankPaymentView.bankNumberView setTitle:SSKJLocalized(@"银行卡账号", nil) withPlaceholder:SSKJLocalized(@"请输入银行卡账号", nil)];
        [_bankPaymentView.openBankView setTitle:SSKJLocalized(@"开户支行", nil) withPlaceholder:SSKJLocalized(@"请输入开户支行名称", nil)];
        [_bankPaymentView.passwordView setTitle:SSKJLocalized(@"资金密码", nil) withPlaceholder:SSKJLocalized(@"请输入资金密码", nil)];
    }
    return _bankPaymentView;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn)
    {
        _cancelBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"取消", nil) titleColor:kBlueColor imageName:nil backgroundImageName:nil target:self selector:@selector(dismissAndcancelBtnAction:) font:systemFont(ScaleW(13.0))];
        [_cancelBtn setTag:2];
    }
    return _cancelBtn;
}


-(UIButton *)confirmBtn
{
    if (!_confirmBtn)
    {
        _confirmBtn = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"确定", nil) titleColor:kTitleColor imageName:nil backgroundImageName:nil target:self selector:@selector(confirmBtnAction:) font:systemFont(15.0)];
        [_confirmBtn setBackgroundColor:kBlueColor];
        [_confirmBtn setTag:3];
    }
    return _confirmBtn;
}


- (BIPaymentMask *)maskView
{
    if (!_maskView)
    {
        _maskView = [[BIPaymentMask alloc]initWithDelegate:self];
        [_maskView setHidden:YES];
    }
    return _maskView;
}


-(NSMutableDictionary *)parameters
{
    if (!_parameters)
    {
        _parameters = [NSMutableDictionary dictionary];
    }
    return _parameters;
}




#pragma mark 验证weixin提示
-(BOOL)authWeiXinAccount:(NSString*)account withQrCodeUrl:(NSString*)qrCodeUrl withPwd:(NSString*)pwd
{
    [self.parameters setObject:kUserID forKey:@"stockUserId"];
    //!< 微信账号
    if (account.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:account forKey:@"wxAccount"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:account forKey:@"account"];
            }
                break;
        }
        
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入微信账号", nil)];
        return NO;
    }
    //!< 二维码url
    if (qrCodeUrl.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:qrCodeUrl forKey:@"wxImg"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:qrCodeUrl forKey:@"qrcode"];
            }
                break;
        }
       
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请上传二维码", nil)];
        return NO;
    }
    
    
    //!< 支付密码
    if (pwd.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:[WLTools md5:pwd] forKey:@"dealPswd"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:[WLTools md5:pwd] forKey:@"tradePswd"];
            }
                break;
        }
        
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return NO;
    }
    
    
    return YES;
}

    
    
#pragma mark 验证Alipay提示
-(BOOL)authAlipayAccount:(NSString*)account withQrCodeUrl:(NSString*)qrCodeUrl withPwd:(NSString*)pwd
{
    [self.parameters setObject:kUserID forKey:@"stockUserId"];
    //!< 支付宝账号
    if (account.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:account forKey:@"alipayAccount"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:account forKey:@"account"];
            }
                break;
        }
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入支付宝账号", nil)];
        return NO;
    }
    //!< 二维码url
    if (qrCodeUrl.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:qrCodeUrl forKey:@"aliImg"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:account forKey:@"qrcode"];
            }
                break;
        }
        
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请上传二维码", nil)];
        return NO;
    }
    
    //!< 支付密码
    if (pwd.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:[WLTools md5:pwd] forKey:@"dealPswd"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:[WLTools md5:pwd] forKey:@"tradePswd"];
            }
                break;
        }
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return NO;
    }
    
    
    return YES;
}


#pragma mark 验证Bank提示
-(BOOL)authBankName:(NSString*)bankName withBankNumber:(NSString*)bankNumber withOpemnBank:(NSString*)opemnBank withPwd:(NSString*)pwd
{
    [self.parameters setObject:kUserID forKey:@"stockUserId"];
    //!< 开户行账号
    if (bankName.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:bankName forKey:@"bankCardOpenBank"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:bankName forKey:@"bankCardOpenBank"];
            }
                break;
        }
        
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入开户行账号", nil)];
        return NO;
    }
    
    //!< 银行卡账号
    if (bankNumber.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:bankNumber forKey:@"bankCardNo"];
            }
                break;
            case PayMentEditType:
            {
                 [self.parameters setObject:bankNumber forKey:@"bankCardNo"];
            }
                break;
        }
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入银行卡账号", nil)];
        return NO;
    }
    
    
    //!< 开户支行
    if (opemnBank.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:opemnBank forKey:@"bankCardUnionNo"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:opemnBank forKey:@"bankCardUnionNo"];
            }
                break;
        }
        
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入开户支行名称", nil)];
        return NO;
    }
    
    //!< 支付密码
    if (pwd.length)
    {
        switch (self.addEditType)
        {
            case PayMentAddType:
            {
                [self.parameters setObject:[WLTools md5:pwd] forKey:@"dealPswd"];
            }
                break;
            case PayMentEditType:
            {
                [self.parameters setObject:[WLTools md5:pwd] forKey:@"tradePswd"];
            }
                break;
        }
    }
    else
    {
        [MBHUD showError:SSKJLocalized(@"请输入资金密码", nil)];
        return NO;
    }
    return YES;
}
@end
