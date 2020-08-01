//
//  My_AdvancedCertificate_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_AdvancedCertificate_ViewController.h"
#import "My_AdvancedCertificate_UploadView.h"
#import "SSKJ_Default_ActionsheetView.h"
#import "BIImagePickerController.h"
#import "Mine_Authentication_ViewController.h"


@interface My_AdvancedCertificate_ViewController () <BIImagePickerControllerDelegate>


@property (nonatomic,assign) NSInteger index; //!< 选择的index
@property (nonatomic,strong) UIScrollView *mainScrollView; //!< 主要滚动视图
@property (nonatomic, strong) My_AdvancedCertificate_UploadView *frontView;
@property (nonatomic, strong) My_AdvancedCertificate_UploadView *backView;
@property (nonatomic, strong) My_AdvancedCertificate_UploadView *handHeldView;
@property (nonatomic, strong) UIButton *submitButton;

@property (nonatomic, copy) NSString *frontUrl;  //!< 前面URL
@property (nonatomic, copy) NSString *backUrl;   //!< 后面URL
@property (nonatomic, copy) NSString *handHeldUrl; //!< 手持URL


@end
@implementation My_AdvancedCertificate_ViewController
- (void)viewDidLoad
{
    
    [super viewDidLoad];
    self.title = SSKJLocalized(@"高级认证", nil);
    [self.view setBackgroundColor:kBgColor];
    [self setUI];
}



-(void)setUI
{
    [self.view addSubview:self.mainScrollView];
    [self.mainScrollView addSubview:self.frontView];
    [self.mainScrollView addSubview:self.backView];
    [self.mainScrollView addSubview:self.handHeldView];
    [self.mainScrollView addSubview:self.submitButton];
    
    #pragma mark 重置Frame
    [self.frontView resetFrame:CGRectMake(0, ScaleW(30), ScreenWidth, self.frontView.height)];
    [self.backView resetFrame:CGRectMake(0, self.frontView.bottom, self.frontView.width, self.backView.height)];
    [self.handHeldView resetFrame:CGRectMake(0, self.backView.bottom, self.frontView.width, self.handHeldView.height)];
    
    
    [self.submitButton setFrame:CGRectMake(ScaleW(12), self.handHeldView.bottom + ScaleW(30), (ScreenWidth - ScaleW(24)), ScaleW(45))];
    
    [self.mainScrollView setContentSize:CGSizeMake(ScreenWidth, self.submitButton.bottom+ScaleW(30))];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    line.backgroundColor = kSubBgColor;
    [self.mainScrollView addSubview:line];
    
}




#pragma mark - Deletage Method
#pragma mark BIImagePickerControllerDelegate
-(void)didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)editingInfo
{
    
    [self uploadImage:image];
    
}




#pragma mark 上传图片
-(void)uploadImage:(UIImage*)image
{
    [MBHUD showHUDAddedTo:self.view];
    //!< 限制图片在1M以内
    image = [UIImage compressImageQuality:image toByte:(1*1024)];
    WS(weakSelf);
    [[WLHttpManager shareManager]  upLoadImageByUrl:BI_Upload_URL ImageName:@"file" Params:nil Image:image CallBack:^(id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf.view];

         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         //!< 如果上传成功就把当前图片地址存到数组中并进行下一步操作
         if (netModel.status.integerValue == SUCCESSED)
         {
             [weakSelf showImage:image withUrl:netModel.data];
         }
         else
         {
             [MBHUD showError:netModel.msg];
         }
     } Failure:^(NSError *error)
     {
         [MBHUD hideHUDForView:weakSelf.view];
     }];
}


#pragma mark 上传成功之后把URL赋值
-(void)showImage:(UIImage*)image withUrl:(NSString*)url
{
    switch (self.index)
    {
        case 1:
        {
            [self.frontView setImage:image];
            [self setFrontUrl:url];
        }
            break;
        case 2:
        {
            [self.backView setImage:image];
            [self setBackUrl:url];
        }
            break;
        case 3:
        {
            [self.handHeldView setImage:image];
            [self setHandHeldUrl:url];
        }
            break;
    }
    
    
}


#pragma mark - Private Method
-(void)controlAction:(UIControl*)sender
{
    [self setIndex:sender.tag];
    
    [SSKJ_Default_ActionsheetView showWithItems:@[SSKJLocalized(@"相机",nil),SSKJLocalized(@"相册",nil)] title:@"" selectedIndexBlock:^(NSInteger selectIndex)
     {
         switch (selectIndex)
         {
             case 0:
             {
                 BIImagePickerController *image = [[BIImagePickerController alloc] initWithType:1 witDelegate:self];
                 [self presentViewController:image animated:YES completion:^{}];
             }
                 break;
             case 1:
             {
                  BIImagePickerController *image = [[BIImagePickerController alloc] initWithType:2 witDelegate:self];
                 [self presentViewController:image animated:YES completion:^{}];
             }
                 break;
         }
         
     } cancleBlock:^{}];
}



#pragma mark 提交
-(void)submitAction:(UIButton*)sender
{
    if (self.frontUrl.length == 0)
    {
        [MBHUD showError:SSKJLocalized(@"请拍摄并上传您的身份证正面照",nil)];
    }
    else if (self.backUrl.length == 0)
    {
        [MBHUD showError:SSKJLocalized(@"请拍摄并上传您的身份证背面照",nil)];
    }
    else if (self.handHeldUrl.length == 0)
    {
        [MBHUD showError:SSKJLocalized(@"请拍摄并上传您的手持身份证照片",nil)];
    }
    else
    {
        NSDictionary *parameters = @{@"idCardFrontImg":self.frontUrl,
                            @"idCardBackImg":self.backUrl,
                            @"selfieImg":self.handHeldUrl,
                                     @"id":kUserID};

        [MBHUD showHUDAddedTo:self.view];
        WS(weakSelf);
        [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_AdvancedAuth_URL RequestType:RequestTypePost Parameters:parameters Success:^(NSInteger statusCode, id responseObject)
         {
             [MBHUD hideHUDForView:self.view];
             WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
             if (netWorkModel.status.integerValue == SUCCESSED )
             {
                 [[SSKJ_User_Tool sharedUserTool].userInfoModel setHighAuthenticationStatus:@"2"];
                 [MBHUD showSuccess:SSKJLocalized(@"上传成功", nil)];
                 for (UIViewController *vc in weakSelf.navigationController.viewControllers) {
                     if ([vc isKindOfClass:[Mine_Authentication_ViewController class]]) {
                         [weakSelf.navigationController popToViewController:vc animated:YES];
                         return;
                     }
                 }
                 
             }
             else
             {
                 [MBProgressHUD showError:netWorkModel.msg];
             }
             
         } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
         {
             [MBHUD hideHUDForView:self.view];
         }];
    }
}




#pragma mark - Getter / Setter
-(UIScrollView *)mainScrollView
{
    if (!_mainScrollView)
    {
        _mainScrollView  = [[UIScrollView alloc]init];
        [_mainScrollView setShowsVerticalScrollIndicator:NO];
        [_mainScrollView setShowsHorizontalScrollIndicator:NO];
        [self.view addSubview:self.mainScrollView];
        [_mainScrollView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.equalTo(@(Height_NavBar));
             make.right.bottom.left.equalTo(self.view);
         }];
        if (@available(iOS 11.0, *)) {
            _mainScrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _mainScrollView;
}

- (My_AdvancedCertificate_UploadView *)frontView
{
    if (nil == _frontView)
    {
        _frontView = [[My_AdvancedCertificate_UploadView alloc]init];
        [_frontView setIdCardType:IDentityCardFront];
        [_frontView addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_frontView setTag:1];
    }
    return _frontView;
}


- (My_AdvancedCertificate_UploadView *)backView
{
    if (nil == _backView)
    {
        _backView = [[My_AdvancedCertificate_UploadView alloc]init];
        [_backView setIdCardType:IDentityCardBack];
        [_backView addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_backView setTag:2];
    }
    return _backView;
}


-(My_AdvancedCertificate_UploadView *)handHeldView
{
    if (nil == _handHeldView)
    {
        _handHeldView = [[My_AdvancedCertificate_UploadView alloc]init];
        [_handHeldView setIdCardType:IDentityCardHandHeld];
        [_handHeldView addTarget:self action:@selector(controlAction:) forControlEvents:UIControlEventTouchUpInside];
        [_handHeldView setTag:3];
    }
    return _handHeldView;
}


-(UIButton *)submitButton
{
    if (nil == _submitButton)
    {
        _submitButton = [FactoryUI createButtonWithFrame:CGRectZero title:SSKJLocalized(@"提交", nil) titleColor:kWhiteColor imageName:nil backgroundImageName:nil target:self selector:@selector(submitAction:) font:systemFont(ScaleW(16))];
        [_submitButton setBackgroundColor:kBlueColor];
        [_submitButton setLayerCornerRadius:4.0];
    }
    return _submitButton;
}












//{
//    NSArray *imageAry = @[image1];
//    // 基于AFN3.0+ 封装的HTPPSession句柄
//    [[ManagerGlobeUntil sharedManager] showHUDWithMsg:SSKJLocalized(@"加载中", nil) inView:self.view];
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.requestSerializer.timeoutInterval = 10.f;
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    [manager.requestSerializer setValue:KAccount forHTTPHeaderField:@"account"];
//    [manager.requestSerializer setValue:KToken forHTTPHeaderField:@"token"];
//    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
//    [manager POST:IOAEX_upload_pic parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        for (int i = 0; i < imageAry.count; i++) {
//            id file = imageAry[i];
//            NSString * imgname = [NSString stringWithFormat:@"jiangxian_img_%d.jpg",i];
//            if ([file isKindOfClass:[UIImage class]]) {
//                [formData appendPartWithFileData:UIImageJPEGRepresentation(file,0.3) name:@"file_pic" fileName:imgname mimeType:@"image/jpg/png/jpeg"];
//            }
//        }
//    } progress:^(NSProgress * xx){
//        SSLog(@"%lld",xx.completedUnitCount);
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        WL_NetWork_Model *network_Model=[WL_NetWork_Model mj_objectWithKeyValues:responseObject];
//        SSLog(@"%@",network_Model.data);
//        if (network_Model.status.integerValue == SUCCESSED) {
//            if(self.selectedIdCardType == IDCARDTYPEFONT){
//                self.frontURL = network_Model.data[@"url"];
//                self.frontView.imageURL = network_Model.data[@"server_url"];
//
//            }else{
//                self.backURL = network_Model.data[@"url"];
//                self.backView.imageURL = network_Model.data[@"server_url"];
//            }
//        }else{
//            [MBProgressHUD showError:network_Model.msg];
//        }
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        [[ManagerGlobeUntil sharedManager] hideHUDFromeView:self.view];
//    }];
//}




@end
