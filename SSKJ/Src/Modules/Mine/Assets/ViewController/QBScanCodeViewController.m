//
//  QBScanCodeViewController.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/5/8.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "QBScanCodeViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface QBScanCodeViewController ()<AVCaptureMetadataOutputObjectsDelegate,CAAnimationDelegate>
//扫码功能
@property(nonatomic,strong)AVCaptureSession *session;
@property(nonatomic,strong)AVCaptureVideoPreviewLayer *layer;
@property(nonatomic,strong)CALayer *lineLayer;
@end

@implementation QBScanCodeViewController


-(CALayer *)lineLayer
{
    if (!_lineLayer)
    {
        _lineLayer = [[CALayer alloc]init];
        _lineLayer.frame = CGRectMake(40, 100, Screen_Width - 80, 2.f);
        _lineLayer.backgroundColor = [UIColor blueColor].CGColor;
        [self.view.layer addSublayer:_lineLayer];
    }
    return _lineLayer;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    

     [self scanCodeAction];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}
-(void)scanCodeAction
{
    self.title = SSKJLocalized(@"扫描二维码", nil);
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:(AVMediaTypeVideo)];
    self.session = [[AVCaptureSession alloc]init];
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    NSError *error = nil;
    if (input) {
        [self.session addInput:input];
    }else{
        
    }
    //creatOutPut
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc]init];
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    [self.session setSessionPreset:(AVCaptureSessionPresetHigh)];
    
    if ([self.session canAddOutput:output])
    {
        
        
        [self.session addOutput:output];
        
        output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeCode128Code];
        
        self.layer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        self.layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        self.layer.frame = CGRectMake(40, 100, Screen_Width - 80, Screen_Width - 80);
        [self.view.layer insertSublayer:self.layer atIndex:0];
        [self.session startRunning];
    }
    else
    {
        SSLog(@"dd");
    }
    
    
    
    NSString *codeDesp = SSKJLocalized(@"将二维码放入框中可自动扫描", nil);
   CGFloat width = [codeDesp boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 20) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size.width;
   CGFloat x = (Screen_Width - 80 - width)/2.f + 40;
   CGFloat y = Screen_Width  + 60;
    UILabel *desLabel = [[UILabel alloc]initWithFrame:CGRectMake(x, y, width, 20)];
    desLabel.text = codeDesp;
    desLabel.adjustsFontSizeToFitWidth = YES;
    [self.view label:desLabel font:15 textColor:kTitleColor text:codeDesp];
    [self.view addSubview:desLabel];
    self.lineLayer.backgroundColor = [UIColor blueColor].CGColor;
    [self.view.layer insertSublayer:self.lineLayer above:self.layer];
    [self addscanningAnimation:CGPointMake(Screen_Width/2.f, Screen_Width + 20)];
    

    
}
//scanningAnimation

-(void)addscanningAnimation:(CGPoint)position
{
    CABasicAnimation *basicAni = [CABasicAnimation animationWithKeyPath:@"position"];
    basicAni.delegate = self;
    basicAni.toValue = [NSValue valueWithCGPoint:position];
    basicAni.duration = 2.f;
    basicAni.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    basicAni.removedOnCompletion = NO;
    basicAni.fillMode = kCAFillModeForwards;
    basicAni.repeatCount = CGFLOAT_MAX;
    NSString *key = NSStringFromSelector(_cmd);
    [self.lineLayer addAnimation:basicAni forKey:key];
}
//outPutDelegate
-(void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    //stopScanning
    [self.lineLayer removeAllAnimations];
    [self.session stopRunning];
     AVMetadataMachineReadableCodeObject *obj = metadataObjects.firstObject;
    if (self.codeScaningString)
    {
        self.codeScaningString(obj.stringValue);
    }
    [self.navigationController popViewControllerAnimated:YES];
  
}
-(void)animationDidStart:(CAAnimation *)anim
{
    
}

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
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
