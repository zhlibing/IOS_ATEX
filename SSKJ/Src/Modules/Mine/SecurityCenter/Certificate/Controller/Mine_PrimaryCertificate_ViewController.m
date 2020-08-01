//
//  My_PrimaryCertificate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "Mine_PrimaryCertificate_ViewController.h"
#import "Mine_TitleAndInput_View.h"
#import "Mine_ImagePicker_ViewController.h"

typedef NS_ENUM(NSUInteger, PhotoType) {
    PhotoTypeFront,
    PhotoTypeBack,
};

@interface Mine_PrimaryCertificate_ViewController ()<Mine_ImagePickerControllerDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) Mine_TitleAndInput_View *nameView;  //!< 用户名视图
@property (nonatomic, strong) Mine_TitleAndInput_View *idView;  //!< 身份证视图

@property (nonatomic, strong) UIView *photoView;
@property (nonatomic, strong) UILabel *photoTitleLabel;
@property (nonatomic, strong) UIImageView *frontImageView;
@property (nonatomic, strong) UILabel *frontLabel;
@property (nonatomic, strong) UIImageView *backImageView;
@property (nonatomic, strong) UILabel *backLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;

@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, assign) PhotoType photoType;

@property (nonatomic, strong) UIImage *frontImage;
@property (nonatomic, strong) UIImage *backImage;


@end

@implementation Mine_PrimaryCertificate_ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"身份认证", nil);
        
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavgationBackgroundColor:kSubBgColor alpha:1];
}




#pragma mark - Getter / Setter
-(void)setUI
{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.topView];
    [self.topView addSubview:self.nameView];
    [self.topView addSubview:self.idView];
    self.topView.height = self.idView.bottom + ScaleW(22);
    
    [self.scrollView addSubview:self.photoView];
    [self.photoView addSubview:self.photoTitleLabel];
    [self.photoView addSubview:self.frontImageView];
    [self.photoView addSubview:self.frontLabel];
    [self.photoView addSubview:self.backImageView];
    [self.photoView addSubview:self.backLabel];
    
    [self.photoView addSubview:self.titleLabel];
    [self.photoView addSubview:self.messageLabel];

    
    [self.photoView addSubview:self.submitButton];
    
    self.photoView.height = self.submitButton.bottom + ScaleW(20);
    
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, self.photoView.bottom);
    
}

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    }
    return _scrollView;
}

-(UIView *)topView
{
    if (nil == _topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, 0)];
        _topView.backgroundColor = kSubBgColor;
    }
    return _topView;
}

-(Mine_TitleAndInput_View *)nameView
{
    if (nil == _nameView) {
        _nameView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.topView.top, ScreenWidth, ScaleW(80)) title:SSKJLocalized(@"姓名", nil) placeHolder:SSKJLocalized(@"请输入您的姓名", nil) keyBoardType:UIKeyboardTypeDefault isSecure:NO];
        _nameView.backgroundColor = kSubBgColor;
        _nameView.textField.width = ScreenWidth - ScaleW(50);
//        [_nameView setTfWidth:300];
        _nameView.space = 0;
    }
    return _nameView;
}


-(Mine_TitleAndInput_View *)idView
{
    if (!_idView)
    {
        _idView = [[Mine_TitleAndInput_View alloc]initWithFrame:CGRectMake(0, self.nameView.bottom, ScreenWidth, self.nameView.height) title:SSKJLocalized(@"证件号码", nil) placeHolder:SSKJLocalized(@"请输入您的证件号码", nil) keyBoardType:UIKeyboardTypeDefault isSecure:NO];
        _idView.backgroundColor = kSubBgColor;
        _idView.textField.width = ScreenWidth - ScaleW(50);
//        [_nameView setTfWidth:300];
        _idView.space = 0;
    }
    return _idView;
}



-(UIView *)photoView
{
    if (nil == _photoView) {
        _photoView = [[UIView alloc]initWithFrame:CGRectMake(0, self.topView.bottom + ScaleW(10), ScreenWidth, ScaleW(0))];
        _photoView.backgroundColor = kSubBgColor;
    }
    return _photoView;
}

-(UILabel *)photoTitleLabel
{
    if (nil == _photoTitleLabel) {
        _photoTitleLabel = [WLTools allocLabel:SSKJLocalized(@"上传照片", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), ScaleW(20), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _photoTitleLabel;
}


- (UIImageView *)frontImageView
{
    if (nil == _frontImageView) {
        _frontImageView = [[UIImageView alloc]initWithFrame:CGRectMake(ScaleW(15), self.photoTitleLabel.bottom + ScaleW(20), ScaleW(103), ScaleW(103))];
        _frontImageView.image = [UIImage imageNamed:@"mine_auth_front"];
        _frontImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPhoto:)];
        [_frontImageView addGestureRecognizer:tap];
    }
    return _frontImageView;
}

-(UILabel *)frontLabel
{
    if (nil == _frontLabel) {
        _frontLabel = [WLTools allocLabel:SSKJLocalized(@"证件正面照片", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(ScaleW(15), self.frontImageView.bottom + ScaleW(15), ScaleW(103), ScaleW(14)) textAlignment:NSTextAlignmentCenter];
    }
    return _frontLabel;
}



- (UIImageView *)backImageView
{
    if (nil == _backImageView) {
        _backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frontImageView.right + ScaleW(32), self.frontImageView.y, ScaleW(103), ScaleW(103))];
        _backImageView.image = [UIImage imageNamed:@"mine_auth_back"];
        _backImageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectPhoto:)];
        [_backImageView addGestureRecognizer:tap];
    }
    return _backImageView;
}

-(UILabel *)backLabel
{
    if (nil == _backLabel) {
        _backLabel = [WLTools allocLabel:SSKJLocalized(@"证件背面照片", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.backImageView.x, self.frontLabel.y, ScaleW(103), ScaleW(12)) textAlignment:NSTextAlignmentCenter];
    }
    return _backLabel;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel) {
        _titleLabel = [WLTools allocLabel:SSKJLocalized(@"上传要求：", nil) font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectMake(self.frontImageView.x, self.frontLabel.bottom + ScaleW(35), ScaleW(200), ScaleW(14)) textAlignment:NSTextAlignmentLeft];
    }
    return _titleLabel;
}


-(UILabel *)messageLabel
{
    if (nil == _messageLabel) {
        NSString *message = SSKJLocalized(@"必须能看清证件信息 提交申请代表承诺你的证件信息真实可靠，不存在盗用他人信息的情况 保证文字清晰可识别，图片大小不超过1MB", nil);

        _messageLabel = [WLTools allocLabel:message font:systemFont(ScaleW(12)) textColor:kSubTitleColor frame:CGRectMake(self.frontImageView.x, self.titleLabel.bottom + ScaleW(10), ScreenWidth - ScaleW(30), ScaleW(12)) textAlignment:NSTextAlignmentLeft];
        
        CGFloat height = [message boundingRectWithSize:CGSizeMake(_messageLabel.width, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:_messageLabel.font} context:nil].size.height;
        
        _messageLabel.height = height;
        
    }
    return _messageLabel;
}

-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [[UIButton alloc]initWithFrame:CGRectMake(ScaleW(15), self.messageLabel.bottom + ScaleW(50), ScreenWidth - ScaleW(30), ScaleW(45))];
        _submitButton.layer.cornerRadius = 4.0f;
        _submitButton.backgroundColor = kBlueColor;
        [_submitButton setTitle:SSKJLocalized(@"提交", nil)  forState:UIControlStateNormal];
        [_submitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _submitButton.titleLabel.font = systemFont(ScaleW(16));
        [_submitButton addTarget:self action:@selector(submitEvent) forControlEvents:UIControlEventTouchUpInside];
    }
    return _submitButton;
}

-(void)submitEvent
{
    
    NSString *name = self.nameView.valueString;
    NSString *idNumber = self.idView.valueString;
    if (name.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的姓名", nil)];
        return;
    }
    
    if (idNumber.length == 0)
    {
        [MBProgressHUD showError:SSKJLocalized(@"请输入您的证件号码", nil)];
        return;
    }
    
    
    [self requestPrimaryCertificate:name withIDentity:idNumber];
}


#pragma mark - NetWork Method 网络请求
- (void)requestPrimaryCertificate:(NSString*)name withIDentity:(NSString*)identity
{
    
    [MBHUD showHUDAddedTo:self.view];
    
    NSDictionary *params = @{
                            @"name":name,
                             @"card_id":identity,
//                            @"front_img":UIImageJPEGRepresentation(self.frontImage, 0.5),
//                            @"back_img":UIImageJPEGRepresentation(self.backImage, 0.5),
                            };
    NSDictionary *picDic = @{
        @"front_img":UIImageJPEGRepresentation(self.frontImage, 0.5),
        @"back_img":UIImageJPEGRepresentation(self.backImage, 0.5),

    };
    
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_BaseAuth_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        [MBHUD hideHUDForView:self.view];
//
//        if (netWorkModel.status.integerValue == SUCCESSED )
//         {
//             [MBHUD showSuccess:netWorkModel.msg];
//             [SSKJ_User_Tool sharedUserTool].userInfoModel.authentication = @"2";
//             [self.navigationController popViewControllerAnimated:YES];
//         }
//         else
//         {
//             [MBProgressHUD showError:netWorkModel.msg];
//         }
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBHUD hideHUDForView:self.view];
//
//    }];
    
    
    WS(weakSelf);
    [[WLHttpManager shareManager] upLoadImageByUrl:BI_BaseAuth_URL Params:params imageDic:picDic CallBack:^(id responseObject) {
         [MBHUD hideHUDForView:self.view];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];

           if (netWorkModel.status.integerValue == SUCCESSED )
            {
                [MBHUD showSuccess:netWorkModel.msg];
                [SSKJ_User_Tool sharedUserTool].userInfoModel.authentication = @"2";
                if (weakSelf.isReCertificate) {
                    [weakSelf.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
            else
            {
                [MBProgressHUD showError:netWorkModel.msg];
            }

    } Failure:^(NSError *error) {
        [MBHUD hideHUDForView:self.view];

    }];
    
}


#pragma mark - 用户操作

-(void)selectPhoto:(UITapGestureRecognizer *)gesture
{
    [[UIApplication sharedApplication].keyWindow endEditing:YES];
    
    UIImageView *imageView = (UIImageView *)gesture.view;
    
    if (imageView == self.frontImageView) {
        self.photoType = PhotoTypeFront;
    }else{
        self.photoType = PhotoTypeBack;
    }
    
    
    [SSKJ_Default_ActionsheetView showWithItems:@[SSKJLocalized(@"相机",nil),SSKJLocalized(@"相册",nil)] title:@"" selectedIndexBlock:^(NSInteger selectIndex)
     {
         switch (selectIndex)
         {
             case 0:
             {
                 Mine_ImagePicker_ViewController *image = [[Mine_ImagePicker_ViewController alloc] initWithType:1 witDelegate:self];
                 image.modalPresentationStyle = 0;
                 [self presentViewController:image animated:YES completion:^{}];
             }
                 break;
             case 1:
             {
                  Mine_ImagePicker_ViewController *image = [[Mine_ImagePicker_ViewController alloc] initWithType:2 witDelegate:self];
                 image.modalPresentationStyle = 0;
                 [self presentViewController:image animated:YES completion:^{}];
             }
                 break;
         }
         
     } cancleBlock:^{}];
    
    
}



#pragma mark - Deletage Method
#pragma mark Mine_ImagePicker_ViewControllerDelegate
-(void)didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)editingInfo
{
    if (self.photoType == PhotoTypeFront) {
        self.frontImageView.image = image;
        self.frontImage = image;
    }else{
        self.backImageView.image = image;
        self.backImage = image;
    }
    
    
}




@end
