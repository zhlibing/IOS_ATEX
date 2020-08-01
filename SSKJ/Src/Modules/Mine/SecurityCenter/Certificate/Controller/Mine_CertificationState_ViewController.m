//
//  SKCertificationStateViewController.m
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_CertificationState_ViewController.h"
#import "Mine_PrimaryCertificate_ViewController.h"



@interface Mine_CertificationState_ViewController ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) UILabel *reasonLabel;

@property (nonatomic, strong) UIButton *button;
@end

@implementation Mine_CertificationState_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    self.title = SSKJLocalized(@"身份认证", nil);
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.statusLabel];
    [self.view addSubview:self.reasonLabel];
    [self.view addSubview:self.button];
    
    [self resetView];
}

-(UIImageView *)imageView
{
    if (nil == _imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(180), ScaleW(88), ScaleW(77))];
        _imageView.centerX = ScreenWidth / 2;
    }
    return _imageView;
}

-(UILabel *)statusLabel
{
    if (nil == _statusLabel) {
        _statusLabel = [WLTools allocLabel:@"审核失败" font:systemFont(ScaleW(13)) textColor:kSubTitleColor frame:CGRectMake(ScaleW(15), self.imageView.bottom + ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _statusLabel;
}


- (UILabel *)reasonLabel
{
    if (nil == _reasonLabel) {
        _reasonLabel = [WLTools allocLabel:@"失败原因：xxx" font:systemFont(ScaleW(13)) textColor:RED_HEX_COLOR frame:CGRectMake(self.statusLabel.x, self.statusLabel.bottom + ScaleW(10), self.statusLabel.width, ScaleW(15)) textAlignment:NSTextAlignmentCenter];
    }
    return _reasonLabel;
}


- (UIButton *)button{
    if (_button == nil) {
        _button = [WLTools allocButton:SSKJLanguage(@"重新认证") textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(45) - ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(45))];
        _button.titleLabel.font = kFont(15);
        [_button addTarget:self action:@selector(toCertificate) forControlEvents:UIControlEventTouchUpInside];
        _button.layer.masksToBounds = YES;
        _button.layer.cornerRadius = ScaleW(5);
        _button.backgroundColor = kBlueColor;
        [self.view addSubview:_button];
        
     
    }
    return _button;
}

-(void)resetView
{
    
    BOOL isSuccess = ([SSKJ_User_Tool sharedUserTool].userInfoModel.authentication.integerValue == 3);
    
    if (isSuccess) {
        self.imageView.image = MyImage(@"mine_auth_s");
        self.statusLabel.text = SSKJLocalized(@"已实名认证成功", nil);
        self.reasonLabel.hidden = YES;
        self.button.hidden = YES;
    }else{
        self.imageView.image = MyImage(@"mine_auth_f");
        NSString *text = SSKJLocalized(@"认证失败，请重新认证", nil);
        
        self.statusLabel.attributedText = [WLTools setAttributeTextWithString:text colorString:SSKJLocalized(@"重新认证", nil) color:kBlueColor];
        
        self.statusLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(toCertificate)];
        [self.statusLabel addGestureRecognizer:tap];
        
        self.reasonLabel.text = [NSString stringWithFormat:@"%@:%@",SSKJLocalized(@"失败原因", nil),[SSKJ_User_Tool sharedUserTool].userInfoModel.refuse_reason];
    }
    
    
}


-(void)toCertificate
{
    Mine_PrimaryCertificate_ViewController *vc = [[Mine_PrimaryCertificate_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
