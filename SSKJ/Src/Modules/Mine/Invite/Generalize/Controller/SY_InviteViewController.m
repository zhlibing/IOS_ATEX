//
//  SY_InviteViewController.m
//  SSKJ
//
//  Created by zpz on 2019/11/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SY_InviteViewController.h"
#import "ImaginaryLineView.h"
@interface SY_InviteViewController ()
@property (nonatomic, strong) UIImageView *backImageView;
@property(nonatomic, strong)UIImageView *qrImageV;
@property(nonatomic, strong)UILabel *qrLabel;
@property(nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong) UIButton *dumplainButton;
@end

@implementation SY_InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"推广海报", nil);
    [self setupViews];
    [self getinfo];
    
    UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
    self.qrImageV.userInteractionEnabled = YES;
    [self.qrImageV addGestureRecognizer:longPress];
}



- (void)getinfo
{
    [MBHUD showHUDAddedTo:self.view];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Qrcode_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];

        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            weakSelf.qrLabel.text = network_Model.data[@"account"];
            [weakSelf.qrImageV sd_setImageWithURL:[NSURL URLWithString:network_Model.data[@"qrcode"]]];
            
//            self.qrImageV.image = [self creatCIQRCodeImageWithString:network_Model.data[@"url"]];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBHUD hideHUDForView:self.view];
        [MBHUD showError:SSKJLocalized(@"网错出错", nil)];
    }];
    
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_Invite_Rule RequestType:RequestTypeGet Parameters:@{} Success:^(NSInteger statusCode, id responseObject)
    {
        
        WL_Network_Model *netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
           
            
        }
        else
        {
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        
    }];
}


- (NSAttributedString *)disposeContent:(NSString *)sender{
    NSString *str = [NSString stringWithFormat:@"<head><style>img{width:%f !important;height:auto}</style></head>%@",ScreenWidth -ScaleW(50),sender];

    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithData:[str dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    [attrStr addAttributes:@{NSForegroundColorAttributeName:kTitleColor, NSFontAttributeName:kFont(13)} range:NSMakeRange(0, attrStr.length - 1)];
    return attrStr;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setNavgationBackgroundColor:kSubBgColor alpha:0];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setNavgationBackgroundColor:kSubBgColor alpha:1];

}
#pragma mark - 用户操作
- (void)backClick{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)inviteClick{
    [self copyEvent];
}

#pragma mark - UI

- (void)setupViews{
    
    
//    UIButton *back = [UIButton buttonWithType:UIButtonTypeCustom];
    
    
    self.backImageView = [UIImageView new];
           //中文
    self.backImageView.image = MyImage(SSKJLocalized(@"tghb", nil));

    self.backImageView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight) ;
    [self.view addSubview:self.backImageView];
    
    [self qrImageV];
    [self titleLabel];
    [self qrLabel];
    [self dumplainButton];
    
    
}

-(UIImageView *)qrImageV
{
    if (nil == _qrImageV) {
        _qrImageV = [[UIImageView alloc]initWithFrame:CGRectZero];
        _qrImageV.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_qrImageV];
        CGFloat startY = -ScaleW(130);
        if (!IS_IPHONE_X_ALL) {
            startY = -ScaleW(97);
        }
        
        [_qrImageV mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(ScaleW(80));
            make.bottom.mas_equalTo(startY);
            make.width.height.mas_equalTo(ScaleW(100));
        }];
    }
    return _qrImageV;
}

- (UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"邀请码", nil) font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [self.view addSubview:_titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.qrImageV.mas_right).offset(ScaleW(20));
            make.top.equalTo(self.qrImageV.mas_top).offset(ScaleW(3));
        }];
    }
    return _titleLabel;
}


- (UILabel *)qrLabel
{
    if (nil == _qrLabel) {
        _qrLabel = [WLTools allocLabel:SSKJLocalized(@"", nil) font:systemBoldFont(ScaleW(15)) textColor:kBlueColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [self.view addSubview:_qrLabel];
        [_qrLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_left);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(10));
        }];
    }
    return _qrLabel;
}
- (UIButton *)dumplainButton
{
    if (nil == _dumplainButton) {
        _dumplainButton = [[UIButton alloc]initWithFrame:CGRectZero];
        [_dumplainButton setTitle:SSKJLocalized(@"复制", nil) forState:UIControlStateNormal];
        [_dumplainButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        _dumplainButton.titleLabel.font = systemFont(ScaleW(15));
        _dumplainButton.backgroundColor = kBlueColor;
        _dumplainButton.layer.cornerRadius = ScaleW(18);
        [_dumplainButton addTarget:self action:@selector(copyEvent) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_dumplainButton];
        
        [_dumplainButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel);
            make.width.mas_equalTo(ScaleW(100));
            make.height.mas_equalTo(ScaleW(36));
            make.bottom.equalTo(self.qrImageV.mas_bottom);
        }];
    }
    return _dumplainButton;
}


-(void)saveImage:(UILongPressGestureRecognizer *)longPress
{
    if (!self.qrImageV.image) {
        return;
    }
    if (longPress.state == UIGestureRecognizerStateBegan) {
        WS(weakSelf);
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"保存二维码", nil)  message:SSKJLocalized(@"保存二维码到相册", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"保存", nil) confirmBlock:^{
            UIImage *img = weakSelf.qrImageV.image;
            UIImageWriteToSavedPhotosAlbum(img, weakSelf, @selector(image:didFinishSavingWithError:contextInfo:),nil);
        }];
    }
}

// 需要实现下面的方法,或者传入三个参数即可
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        [MBProgressHUD showError:SSKJLocalized(@"保存失败", nil)];
    } else {
        [MBProgressHUD showError:SSKJLocalized(@"保存成功", nil)];
    }
}


-(void)copyEvent
{
    if (!self.qrLabel.text.length) {
        return;
    }
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.qrLabel.text;
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
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
    return [self creatNonInterpolatedUIImageFormCIImage:outputImage withSize:self.qrImageV.width];
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
