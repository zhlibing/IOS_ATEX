//
//  My_Invicate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/25.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_Invicate_ViewController.h"
#import "SSKJ_Default_AlertView.h"
@interface Mine_Invicate_ViewController ()
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *qrCodeImageView;
@property (nonatomic, strong) UIImageView *bottomBGView;

@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UIButton *dumplicationButton;

@property (nonatomic, strong) UILabel *linkLabel;
@property (nonatomic, strong) UIButton *linkDumplicationButton;

@property (nonatomic, strong) UILabel *longPressLabel;

@end

@implementation Mine_Invicate_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"邀请好友", nil);
    [self injected];
    [self setUI];

    
}
-(void)injected{

}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self requestInvicate];
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

-(void)setUI
{
    [self.view addSubview:self.backImageView];
//    [self.backImageView addSubview:self.topImageView];
  
    

    
    
    self.bottomBGView = [WLTools allocImageView:CGRectMake(ScaleW(35), ScaleW(380), ScaleW(305), ScaleW(180)) image:[UIImage imageNamed:@"lightning_blue"]];
    [self.backImageView addSubview:self.bottomBGView];
    
    [self.bottomBGView addSubview:self.qrCodeImageView];
    [self.bottomBGView addSubview:self.longPressLabel];
    [self.bottomBGView addSubview:self.codeLabel];
    [self.bottomBGView addSubview:self.dumplicationButton];
//    [self.backImageView addSubview:self.linkLabel];
//    [self.backImageView addSubview:self.linkDumplicationButton];
}
-(UILabel *)longPressLabel{
    
    if (nil == _longPressLabel) {
        
        _longPressLabel=[FactoryUI createLabelWithFrame:CGRectMake(self.qrCodeImageView.right + ScaleW(20), ScaleW(43), ScaleW(110), ScaleW(14)) text:SSKJLocalized(@"长按保存二维码", nil) textColor:kWhiteColor font:systemFont(14)];
        
//        [_longPressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.qrCodeImageView.mas_bottom).offset(ScaleW(0));
//
//            make.left.equalTo(self.qrCodeImageView.mas_right).offset(ScaleW(20));
//
//            make.right.mas_equalTo(-ScaleW(20));
//
//            make.height.mas_equalTo(14);
//
//        }];
        
        _longPressLabel.textAlignment=NSTextAlignmentCenter;
        
        UILongPressGestureRecognizer *longPress=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
        
        _longPressLabel.adjustsFontSizeToFitWidth=YES;
        [_longPressLabel addGestureRecognizer:longPress];
        
    }
    
    return _longPressLabel;
    
}

-(UIImageView *)backImageView
{
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight - Height_NavBar)];
        _backImageView.image = [UIImage imageNamed:SSKJLocalized(@"lightning_poster", nil)];
        _backImageView.userInteractionEnabled = YES;
    }
    return _backImageView;
}

-(UIImageView *)topImageView
{
    if (nil == _topImageView) {
        
        UIImage *image = [UIImage imageNamed:SSKJLocalized(@"invicate_title", nil)];
        
        _topImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, ScaleW(50), ScaleW(image.size.width), ScaleW(image.size.height))];
        _topImageView.centerX = ScreenWidth / 2;
        _topImageView.image = image;
        
    }
    return _topImageView;
}


-(UIImageView *)qrCodeImageView
{
    if (nil == _qrCodeImageView) {
        
        UIView *backView=[UIView new];
        
        _qrCodeImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(39), ScaleW(43), ScaleW(97), ScaleW(97))];
        
        [self.bottomBGView addSubview:_qrCodeImageView];
        
        [self.bottomBGView addSubview:backView];
        [backView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.left.equalTo(self->_qrCodeImageView).offset(-2);
            
            make.right.equalTo(self->_qrCodeImageView).offset(2);
            make.top.equalTo(self->_qrCodeImageView).offset(-2);
            
            make.bottom.equalTo(self->_qrCodeImageView).offset(2);
        }];
        
        backView.layer.borderWidth=1;
        
        backView.layer.cornerRadius=3;
        
        backView.clipsToBounds=YES;
        
        backView.layer.borderColor=kBlueColor.CGColor;
        
        backView.backgroundColor=[UIColor whiteColor];
        
//        _qrCodeImageView.layer.masksToBounds = YES;
//        _qrCodeImageView.layer.borderColor = kTitleColor.CGColor;
//        _qrCodeImageView.layer.borderWidth = 2;
        
        
        UILongPressGestureRecognizer *longPress2=[[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(saveImage:)];
        
        _qrCodeImageView.userInteractionEnabled=YES;
        
        [_qrCodeImageView addGestureRecognizer:longPress2];
        
            }
    return _qrCodeImageView;
}

-(UILabel *)codeLabel
{
    if (nil == _codeLabel) {
        _codeLabel = [WLTools allocLabel:SSKJLocalized(@"邀请码:", nil) font:systemThinFont(ScaleW(14)) textColor:kWhiteColor frame:CGRectMake(self.qrCodeImageView.right + ScaleW(20), self.qrCodeImageView.y + ScaleW(28), ScaleW(150), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _codeLabel;
}

-(UIButton *)dumplicationButton
{
    if (nil == _dumplicationButton) {
        _dumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(self.qrCodeImageView.right + ScaleW(20), ScaleW(107), ScaleW(105), ScaleW(35))];
//        [_dumplicationButton setImage:[UIImage imageNamed:@"icon_copy"] forState:UIControlStateNormal];
        [_dumplicationButton setTitle:SSKJLocalized(@"复制", nil) forState:UIControlStateNormal];
        [_dumplicationButton setCornerRadius:ScaleW(17.5)];
        [_dumplicationButton setTitleColor:kBlueColor forState:UIControlStateNormal];
        _dumplicationButton.backgroundColor = [UIColor whiteColor];
        _dumplicationButton.titleLabel.font=systemFont(14);
        [_dumplicationButton addTarget:self action:@selector(copyEvent:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _dumplicationButton;
}


-(UILabel *)linkLabel
{
    if (nil == _linkLabel) {
        _linkLabel = [WLTools allocLabel:@"下载链接：" font:systemThinFont(ScaleW(13)) textColor:kTitleColor frame:CGRectMake(self.qrCodeImageView.right + ScaleW(20), self.codeLabel.bottom + ScaleW(20), ScaleW(200), ScaleW(13)) textAlignment:NSTextAlignmentLeft];
    }
    return _linkLabel;
}

-(UIButton *)linkDumplicationButton
{
    if (nil == _linkDumplicationButton) {
        _linkDumplicationButton = [[UIButton alloc]initWithFrame:CGRectMake(0, self.codeLabel.bottom, ScaleW(50), ScaleW(40))];
        _linkDumplicationButton.centerX = self.dumplicationButton.centerX;
        _linkDumplicationButton.centerY = self.linkLabel.centerY;

        [_linkDumplicationButton setImage:[UIImage imageNamed:@"icon_copy"] forState:UIControlStateNormal];

        [_linkDumplicationButton addTarget:self action:@selector(copyEvent:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _linkDumplicationButton;
}


-(void)saveImage:(UILongPressGestureRecognizer *)longPress
{
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


-(void)copyEvent:(UIButton *)sender
{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    if (sender == self.dumplicationButton) {
        pasteboard.string = self.codeLabel.text;
    }else{
        pasteboard.string = self.linkLabel.text;
    }
    [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
}

-(void)requestInvicate
{
    NSDictionary *params = @{@"id":kUserID};
    WS(weakSelf);
    [MBHUD showHUDAddedTo:self.view];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Qrcode_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:weakSelf.view];
        
        
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED)
        {
            [weakSelf.qrCodeImageView sd_setImageWithURL:[NSURL URLWithString:network_model.data[@"url"]] placeholderImage:nil];
            weakSelf.codeLabel.text = [NSString stringWithFormat:SSKJLocalized(@"邀请码: %@", nil),network_model.data[@"invitationCode"]];
            self.linkLabel.text = network_model.data[@"downUrl"];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
    
}


@end
