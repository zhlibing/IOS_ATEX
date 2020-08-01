//
//  My_GoogleVerify_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_GoogleVerify_ViewController.h"
#import "My_BindGoogle_AlertView.h"
#import "My_Google_Model.h"


@interface My_GoogleVerify_ViewController ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *warningLabel1;
@property (nonatomic, strong) UILabel *warningLabel2;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UILabel *bottomWarningLabel;
@property (nonatomic, strong) UIButton *nextButton;
@property (nonatomic, strong) My_Google_Model *gooleModel; //!< 谷歌数据模型
@property (nonatomic, strong) My_BindGoogle_AlertView *alertView;



@end

@implementation My_GoogleVerify_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"绑定谷歌验证器", nil);

    [self setUI];

    [self requestGoogle];
}





#pragma mark - Private Method
#pragma mark 下一步
-(void)nextEvent
{
    if (self.gooleModel.secret.length)
    {
        [self.alertView showWithType:GOOGLETYPEBIND];
    }
    else
    {
        [MBHUD showError:@"数据异常"];
    }
    
}


#pragma mark 复制
-(void)dumplcationEvent
{
    if (!self.gooleModel.secret.length) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    [pasteboard setString:self.gooleModel.secret];
    [MBHUD showSuccess:SSKJLocalized(@"复制成功",nil)];
}





#pragma mark - Getter / Setter
-(void)setUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:[self getLineView]];
    [self.scrollView addSubview:self.warningLabel1];
    [self.scrollView addSubview:self.warningLabel2];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.qrCodeImageView];
    [self.scrollView addSubview:self.codeLabel];
    [self.scrollView addSubview:self.bottomWarningLabel];
    [self.scrollView addSubview:self.nextButton];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.nextButton.bottom + ScaleW(20));
    self.view.backgroundColor=kSubBgColor;
}


-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        _scrollView.backgroundColor = kBgColor;
        
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _scrollView;
}

-(UILabel *)warningLabel1
{
    if (nil == _warningLabel1) {
        NSString *string = SSKJLocalized(@"打开谷歌验证器，扫描下方二维码或手动输入下述秘钥添加验证令牌。", nil);
        _warningLabel1 = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(20), Height_NavBar + ScaleW(40), ScreenWidth - ScaleW(40), ScaleW(11)) text:string textColor:kSubTitleColor font:systemFont(ScaleW(11))];
        
        
        _warningLabel1.numberOfLines = 0;
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_warningLabel1.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_warningLabel1.font} context:nil].size.height;
        _warningLabel1.height = height;
    }
    return _warningLabel1;
}

-(UILabel *)warningLabel2
{
    if (nil == _warningLabel2) {
        NSString *string = SSKJLocalized(@"秘钥用户手机更换或遗失时找回谷歌验证器，绑定前请务必将下述秘钥备份保存。", nil);

        _warningLabel2 = [WLTools allocLabel:string font:systemFont(ScaleW(11)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(20), self.warningLabel1.bottom + ScaleW(7), ScreenWidth - ScaleW(40), ScaleW(25)) textAlignment:NSTextAlignmentLeft];
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_warningLabel2.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_warningLabel2.font} context:nil].size.height;
        _warningLabel2.height = height;
        _warningLabel2.numberOfLines = 0;

    }
    return _warningLabel2;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        
//        SSKJLocalized(@"请妥善备份秘钥以防遗失",nil)
        _titleLabel = [FactoryUI createLabelWithFrame:CGRectMake(self.warningLabel2.left, self.warningLabel2.bottom + ScaleW(30), self.warningLabel2.width, 1) text:nil textColor:kTitleColor font:systemFont(ScaleW(15))];
        _titleLabel.backgroundColor=kLineColor;
        
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, self.titleLabel.bottom + ScaleW(40), ScaleW(150), ScaleW(150))];
        _qrCodeImageView.centerX = self.view.width / 2;
        _qrCodeImageView.backgroundColor = kSubBgColor;
    }
    return _qrCodeImageView;
}

-(UILabel *)codeLabel
{
    if (nil == _codeLabel) {
        _codeLabel = [WLTools allocLabel:@"  " font:systemFont(ScaleW(15)) textColor:UIColorFromRGB(0x666666) frame:CGRectMake(ScaleW(80), self.qrCodeImageView.bottom + ScaleW(39), ScreenWidth-ScaleW(160), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
        
        _codeLabel.userInteractionEnabled = YES;
        
        [self.scrollView addSubview:_codeLabel];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dumplcationEvent)];
        
        [_codeLabel addGestureRecognizer:tap];
        
        UIButton *copyBt=[FactoryUI createButtonWithFrame:CGRectMake(_codeLabel.right+2, _codeLabel.top, 40, 15) title:SSKJLocalized(@"复制", nil) titleColor:RGBCOLOR(97,133,229) imageName:nil backgroundImageName:nil target:self selector:@selector(copyClick:) font:systemFont(15)];
        
        [self.scrollView addSubview:copyBt];
        
        
    }
    return _codeLabel;
}
-(void)copyClick:(UIButton*)sender{
    
    [self dumplcationEvent];
    
}
- (UILabel *)bottomWarningLabel
{
    if (nil == _bottomWarningLabel) {
        NSString *string = SSKJLocalized(@"保存二维码到手机或复制秘钥到剪贴板可能会有安全风险,请妥善保存",nil);

        _bottomWarningLabel = [WLTools allocLabel:string font:systemFont(ScaleW(11)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(20), self.codeLabel.bottom + ScaleW(55), ScreenWidth - ScaleW(40), ScaleW(25)) textAlignment:NSTextAlignmentLeft];
        CGFloat height = [string boundingRectWithSize:CGSizeMake(_bottomWarningLabel.width, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_bottomWarningLabel.font} context:nil].size.height;
        _bottomWarningLabel.height = height;
        _bottomWarningLabel.numberOfLines = 0;

    }
    return _bottomWarningLabel;
}

-(UIButton *)nextButton
{
    if (nil == _nextButton) {
        _nextButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(12), self.bottomWarningLabel.bottom + ScaleW(88), ScreenWidth - ScaleW(24), ScaleW(44))];
        _nextButton.layer.cornerRadius = ScaleW(5);
        _nextButton.backgroundColor = kBlueColor;
        [_nextButton setTitle:SSKJLocalized(@"下一步",nil) forState:UIControlStateNormal];
        [_nextButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _nextButton.titleLabel.font = systemFont(ScaleW(16));
        [_nextButton addTarget:self action:@selector(nextEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _nextButton;
}

-(My_BindGoogle_AlertView *)alertView
{
    if (nil == _alertView)
    {
        _alertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        [_alertView setType:GOOGLETYPEBIND];
        
        WS(weakSelf);
        _alertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestGoogleCommandWithCode:smsCode withGoogleCode:googleCode];
        };
    }
    return _alertView;
}

-(My_Google_Model *)gooleModel
{
    if (!_gooleModel)
    {
        _gooleModel = [[My_Google_Model alloc]init];
    }
    return _gooleModel;
}

#pragma mark - 网络请求
-(void)requestGoogle
{
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GoogleAuth_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:self.view];
        WL_Network_Model *netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
            My_Google_Model *model = [My_Google_Model mj_objectWithKeyValues:netWorkModel.data];
            
            [weakSelf setViewWithGoogleModel:model];
        }
        else
        {
            [MBHUD showError:netWorkModel.msg];
        }
        
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:self.view];
        [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
        
    }];
}



#pragma mark 绑定谷歌验证器
-(void)requestGoogleCommandWithCode:(NSString *)code withGoogleCode:(NSString *)googleCode
{
    if (code.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入验证码", nil)];
    }

    
    if (code.length != 6) {
        [MBProgressHUD showError:SSKJLocalized(@"验证码错误", nil)];
        return;
    }
    
    else if (googleCode.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入谷歌验证码", nil)];
    }
    
    NSDictionary *params = @{@"stockUserId":kUserID,
                             @"telCode":code,
                             @"areaCode":[SSTool myAreaCode],
                             @"code":googleCode,
                             @"secret":self.gooleModel.secret,
                             @"qrcode":self.gooleModel.qrcode};
    
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GoogleAuthVerify_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             [[SSKJ_User_Tool sharedUserTool].userInfoModel setGoogleAuthenticationStatus:@"1"];
             [[SSKJ_User_Tool sharedUserTool].userInfoModel setGoogleOpenCloseStatus:@"1"];
             [weakSelf.navigationController popViewControllerAnimated:YES];
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
         }
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}

-(void)setViewWithGoogleModel:(My_Google_Model *)model
{
    [self setGooleModel:model];
    
    
    [self.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:[WLTools imageURLWithURL:model.qrcode]]];
//    [self creatCIQRCodeImageWithString:model.secret];
    
    self.codeLabel.text = [NSString stringWithFormat:@"%@  ",model.secret];
}

/**
 *  生成二维码
 */
- (UIImage *)creatCIQRCodeImageWithString:(NSString *)string
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    NSString *dataString = string;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    // 5. 显示二维码
    // 该方法生成的图片较模糊
    //    self.codeImg.image = [UIImage imageWithCIImage:outputImage];
    // 使用该方法生成高清图
    return [self creatNonInterpolatedUIImageFormCIImage:outputImage withSize:self.qrCodeImageView.width];
}

/**
 *  根据CIImage生成指定大小的UIImage
 *
 *  @param image CIImage
 *  @param size  图片宽度
 *
 *  @return 生成高清的UIImage
 */
- (UIImage *)creatNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat)size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1. 创建bitmap
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
    
}


@end
