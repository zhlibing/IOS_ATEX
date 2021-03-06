//
//  My_Charge_View.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_RechargeTop_View.h"

@interface Mine_RechargeTop_View ()
@property (nonatomic, strong) UIButton *saveImageButton;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *addressLabel;
@property (nonatomic, strong) UIButton *dumplicationButton;
@property (nonatomic, strong) UILabel *warnTipLabel;
@property (nonatomic, strong) UIView *midBackView;

@end

@implementation Mine_RechargeTop_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kSubBgColor;
        self.layer.cornerRadius = ScaleW(8);
        [self setUI];
    }
    return self;
}

#pragma mark - UI
-(void)setUI
{
    [self addSubview:self.qrCodeImageView];
    [self addSubview:self.saveImageButton];
    [self addSubview:self.lineView];
    [self addSubview:self.addressLabel];
    [self addSubview:self.dumplicationButton];
    [self addSubview:self.warnTipLabel];
    [self addSubview:self.midBackView];
    
    [self.warnTipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@(ScaleW(10)));
        make.right.equalTo(@(-ScaleW(10)));
        make.bottom.equalTo(self.mas_bottom).offset(-2);
        
    }];
    
}


-(void)saveImage:(UILongPressGestureRecognizer *)longPress
{
    if (!self.qrCodeImageView.image) {
        return;
    }
    if (longPress.state == UIGestureRecognizerStateBegan) {
        WS(weakSelf);
        [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"保存二维码", nil)  message:SSKJLocalized(@"保存二维码到相册", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"保存", nil) confirmBlock:^{
            UIImage *img = weakSelf.qrCodeImageView.image;
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

-(UIView*)midBackView{
    
 
    if (nil == _midBackView)
    {
        _midBackView = [[UIImageView alloc]init];
        
        [self addSubview:_midBackView];
        
        [_midBackView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self).offset(0);
            make.right.equalTo(self).offset(0);
            
            make.top.equalTo(self.addressLabel).offset(-ScaleW(18));
        make.bottom.equalTo(self.dumplicationButton).offset(ScaleW(10));

        }];
        
        
        _midBackView.layer.cornerRadius=5;
        
        _midBackView.clipsToBounds=YES;
        
//        _midBackView.backgroundColor=RGBCOLOR(234,236,242);
        
        [self sendSubviewToBack:_midBackView];
        
    }
    return _qrCodeImageView;
}


-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView) {
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(60), ScaleW(101), ScaleW(101))];
        _qrCodeImageView.backgroundColor = [UIColor whiteColor];
        _qrCodeImageView.centerX = self.width / 2;
        
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
           _qrCodeImageView.userInteractionEnabled = YES;
           [_qrCodeImageView addGestureRecognizer:longPress];

    }
    return _qrCodeImageView;
}


-(UIButton *)saveImageButton
{
    if (nil == _saveImageButton) {
        _saveImageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.qrCodeImageView.bottom + ScaleW(20), self.width, ScaleW(40))];
        [_saveImageButton setTitle:SSKJLocalized(@"长按保存二维码", nil) forState:UIControlStateNormal];
        [_saveImageButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        _saveImageButton.titleLabel.font = systemFont(ScaleW(13));
        _saveImageButton.userInteractionEnabled = NO;
//        [_saveImageButton addTarget:self action:@selector(saveQRCode) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveImageButton;
}


-(UIView *)lineView
{
    if (nil == _lineView) {
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(21), self.saveImageButton.bottom + ScaleW(20), self.width - ScaleW(42), 0.5)];
        _lineView.backgroundColor = kBgColor;
    }
    return _lineView;
}

- (UILabel *)addressLabel
{
    if (nil == _addressLabel) {
       
        
        _addressLabel = [FactoryUI createLabelWithFrame:CGRectMake(ScaleW(20), self.lineView.bottom + ScaleW(20), self.width - ScaleW(40), ScaleW(20)) text:SSKJLocalized(@"充币地址", nil) textColor:kSubTitleColor font:systemFont(ScaleW(14))];
        _addressLabel.numberOfLines = 0;
        _addressLabel.textAlignment=NSTextAlignmentCenter;
        
    }
    return _addressLabel;
}

-(UIButton *)dumplicationButton
{
    if (nil == _dumplicationButton) {
        _dumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.addressLabel.bottom + ScaleW(20), ScaleW(110), ScaleW(35))];
        _dumplicationButton.centerX = self.width / 2;
//        _dumplicationButton.backgroundColor = kBlueColor;
        _dumplicationButton.layer.cornerRadius = _dumplicationButton.height / 2;
        [_dumplicationButton setTitleColor:kTitleColor forState:UIControlStateNormal];
        [_dumplicationButton setTitle:SSKJLocalized(@"复制地址", nil) forState:UIControlStateNormal];
        _dumplicationButton.titleLabel.font =systemFont(15);
        _dumplicationButton.backgroundColor = kBlueColor;
        _dumplicationButton.layer.cornerRadius = ScaleW(5);
        [_dumplicationButton addTarget:self action:@selector(dumplicationEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _dumplicationButton;
}

#pragma mark - 用户操作

#pragma mark 保存二维码到相册
-(void)saveQRCode
{
    UIImage *img = self.qrCodeImageView.image;
    if (!img) {
        return;
    }
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:),nil);
}

#pragma mark 复制地址
-(void)dumplicationEvent
{
    if (self.address) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = self.address;
        [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
    }
    
}




-(void)setAddress:(NSString *)address
{
    _address = address;
    self.addressLabel.text =[NSString stringWithFormat:@"%@",address];
    [self.addressLabel sizeToFit];
    
    _dumplicationButton.y = _addressLabel.bottom + ScaleW(15);
    
//    [self creatCIQRCodeImage];
}



/**
 *  生成二维码
 */
- (void)creatCIQRCodeImage
{
    // 1.创建过滤器，这里的@"CIQRCodeGenerator"是固定的
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复默认设置
    [filter setDefaults];
    // 3. 给过滤器添加数据
    NSString *dataString = _address;
    NSData *data = [dataString dataUsingEncoding:NSUTF8StringEncoding];
    // 注意，这里的value必须是NSData类型
    [filter setValue:data forKeyPath:@"inputMessage"];
    // 4. 生成二维码
    CIImage *outputImage = [filter outputImage];
    // 5. 显示二维码
    // 该方法生成的图片较模糊
    //    self.codeImg.image = [UIImage imageWithCIImage:outputImage];
    // 使用该方法生成高清图
    self.qrCodeImageView.image = [self creatNonInterpolatedUIImageFormCIImage:outputImage withSize:self.qrCodeImageView.width];
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



-(UILabel *)warnTipLabel
{
    if (nil == _warnTipLabel)
    {
        _warnTipLabel = [FactoryUI createLabelWithFrame:CGRectZero text:@"" textColor:[UIColor redColor] font:systemBoldFont((ScaleW(13)))];
        _warnTipLabel.numberOfLines = 0;


    }
    return _warnTipLabel;
}
@end
