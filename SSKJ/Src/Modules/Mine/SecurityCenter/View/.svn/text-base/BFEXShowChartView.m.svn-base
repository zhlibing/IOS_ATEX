//
//  BFEXShowChartView.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/3.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BFEXShowChartView.h"
#import "BFEXShowChartViewCell.h"
#import "alertSelectView.h"

#import "FRCameraViewController.h"
#import "ICC_SelectPhotoView.h"
#import "ManagerSocket.h"
#import "SSKJ_Default_ActionsheetView.h"

@interface BFEXShowChartView()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UITableView *showTableView;
@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) NSArray *dataArr;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextField *inputTextView ;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) alertSelectView *alertView;
@property (nonatomic, strong) ICC_SelectPhotoView *selectPhoto;
//1 支付宝 2 微信 3 银行卡 4paypal
@property (nonatomic, assign) NSInteger selectType;
//记录当前img
@property (nonatomic, strong) UIImageView *currentImg;
@property (nonatomic, strong) UIButton *btn;

@property (nonatomic, copy) NSString *imageURL;

@property (nonatomic, strong) NSMutableDictionary *params;

@property (nonatomic, strong) UIView *darkBackView;//半透明背景图

@end

@implementation BFEXShowChartView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self viewConfig];
    }
    return self;
}

-(void)viewConfig
{
    self.selectType = 1;
    self.backgroundColor = [UIColor clearColor];
    
    self.frame = CGRectMake(0, 0, Screen_Width, Screen_Height);
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
   // [keyWindow addSubview:self];
    [self darkBackView];
    [self backView];
    [self nameLabel];
    [self inputTextView];
    [self showTableView];
    
    self.backView.centerY = ScreenHeight / 2;
}
-(UIView *)darkBackView{
    
    if (nil == _darkBackView) {
        
        _darkBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
        
        _darkBackView.backgroundColor=RGBCOLOR(100, 100, 100);
        
        _darkBackView.alpha=0.4;
        [self addSubview:_darkBackView];

    }
    
    return _darkBackView;
    
}
-(NSArray *)dataArr{
    if (!_dataArr) {
        _dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):SSKJLocalized(@"请输入支付宝账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码", nil)}];
    }
    return _dataArr;
}


-(UIView *)backView
{
    
    if (nil == _backView) {
        _backView = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(25), 0, ScreenWidth-ScaleW(50), 0)];
        _backView.backgroundColor = [UIColor whiteColor];
        _backView.layer.cornerRadius = 8.0f;
        
        [self addSubview:_backView];
    }
    return _backView;
}

-(UITableView *)showTableView{
    if (!_showTableView) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.headerView.maxY, ScreenWidth - ScaleW(50), Screen_Height - 160 - 90 -140) style:UITableViewStylePlain];
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.backgroundColor=[UIColor clearColor];
           [self.backView addSubview:tableView];
        UIView *settingsview = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(25), tableView.bottom, tableView.width, 90)];
        settingsview.backgroundColor = [UIColor clearColor];
        [self.backView addSubview:settingsview];
        UIButton *button = [[UIButton alloc] init];
        button.backgroundColor = kBlueColor;
        button.layer.cornerRadius = 20;
        button.titleLabel.font = [UIFont systemFontOfSize:15.f];
//        button.layer.cornerRadius = 22.5;
//        button.layer.masksToBounds = YES;
        [button setTitle:SSKJLocalized(@"完成设置", nil) forState:UIControlStateNormal];
        button.tag = 100000;
        [button setTitleColor:RGBCOLOR16(0xffffff) forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:)
         
         forControlEvents:UIControlEventTouchUpInside];
         [settingsview addSubview:button];
        button.frame = CGRectMake(settingsview.width/2+(settingsview.width/2-ScaleW(125))/3, 20, ScaleW(125), 40);
        UIButton *buttoncancell = [[UIButton alloc] init];
        buttoncancell.backgroundColor = [UIColor clearColor];
        buttoncancell.titleLabel.font = [UIFont systemFontOfSize:15.f];
        [buttoncancell setTitle:SSKJLocalized(@"取消", nil) forState:UIControlStateNormal];
        buttoncancell.tag = 100001;

        buttoncancell.layer.cornerRadius=20;
        buttoncancell.clipsToBounds=YES;
        buttoncancell.layer.borderWidth=1;
        buttoncancell.layer.borderColor=kBlueColor.CGColor;
        
        [buttoncancell setTitleColor:kBlueColor forState:UIControlStateNormal];
        [buttoncancell addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        buttoncancell.frame = CGRectMake( (settingsview.width/2-ScaleW(125))*2/3, 20, ScaleW(125), 40);
        [settingsview addSubview:buttoncancell];
        settingsview.centerX = self.backView.width / 2;

        _showTableView = tableView;
        _showTableView.centerX = self.backView.width / 2;

        self.backView.height = settingsview.bottom;
    }
    return _showTableView;
    
}
-(UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(16, 55, 200, 14)];
        [self label:_nameLabel font:14 textColor:kTitleColor text:SSKJLocalized(@"支付方式", nil)];
        [self.headerView addSubview:_nameLabel];
    }
    return _nameLabel;
}

-(UITextField *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [[UITextField alloc]initWithFrame:CGRectMake(16,_nameLabel.bottom + 12, Screen_Width - 50 - 32, 45.f)];
        [self textField:_inputTextView textFont:14 placeHolderFont:14 text:@"" placeText:SSKJLocalized(@"支付宝", nil) textColor:kTitleColor placeHolderTextColor:RGBCOLOR(136,141,157)];
        [_inputTextView setCornerRadius:5.f];
        [_inputTextView setBorderWithWidth:1.f andColor:kLineColor];
        _inputTextView.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 0)];
        _inputTextView.leftViewMode = UITextFieldViewModeAlways;
        _inputTextView.enabled = NO;
        
        [self.headerView addSubview:_inputTextView];
       _btn = [UIButton buttonWithType:UIButtonTypeCustom];
        _btn.right = _inputTextView.right - ScaleW(47);
        _btn.centerY = _inputTextView.centerY - ScaleW(22);
        _btn.size = CGSizeMake(ScaleW(47), ScaleW(45));
        [self btn:_btn font:12 textColor:RGBCOLOR16(0xffffff) text:@"" image:[UIImage imageNamed:@"root_down_sanjiao"]];
        [_btn addTarget:self action:@selector(btnAction:) forControlEvents:(UIControlEventTouchUpInside)];
        [self.headerView addSubview:_btn];
        
    }
    return _inputTextView;
}
-(alertSelectView *)alertView{
    if (!_alertView) {
        _alertView = [[alertSelectView alloc]initWithFrame:CGRectMake(_btn.x, _btn.maxY, 90 , 240)];
        _alertView.backgroundColor = kBgColor;
        _alertView.layer.borderColor = kLineColor.CGColor;
        _alertView.layer.borderWidth = 1;
        _alertView.dataArray = @[SSKJLocalized(@"支付宝", nil),SSKJLocalized(@"微信", nil),SSKJLocalized(@"银行卡", nil)];
        _alertView.frame = CGRectMake(_btn.x, _btn.maxY + 60, 90 , 120);
        [self addSubview:_alertView];
    }
    return _alertView;
}
#pragma mark --- 选择支付类型 ---
-(void)btnAction:(UIButton *)sender
{
    WS(weakSelf);
    self.alertView.hidden = NO;
    self.alertView.selectIndexBlock = ^(NSInteger index) {
        weakSelf.selectType = index +1; weakSelf.inputTextView.text=weakSelf.alertView.dataArray[index];
        
        switch (weakSelf.selectType) {
            case 1:
            {
                 weakSelf.dataArr =  @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):SSKJLocalized(@"请输入支付宝账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码", nil)}];
            }
                break;
            case 2:
               
            {
                 weakSelf.dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"微信", nil):SSKJLocalized(@"请输入微信账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的微信收款二维码图片", nil)},@{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码", nil)}];
            }
                break;
            case 3:
            {
                weakSelf.dataArr = @[
                                     @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                     @{SSKJLocalized(@"开户银行", nil):SSKJLocalized(@"请输入开户银行名", nil)},
                                     @{SSKJLocalized(@"开户支行", nil):SSKJLocalized(@"请输入支行名", nil)},
                                     @{SSKJLocalized(@"开户银行卡", nil):SSKJLocalized(@"请输入银行卡号", nil)},
                                     @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码", nil)}];
            }
                break;
            case 4:{
                NSString *str = [NSString stringWithFormat:@"Paypal%@",SSKJLocalized(@"账户", nil)];
                weakSelf.dataArr = @[
                                     @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                     @{str:SSKJLocalized(@"请输入您的", nil)},
                                     @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码", nil)}];
            }
               break;
            default:
                break;
        }
        [weakSelf.showTableView reloadData];
    };

}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BFEXShowChartViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"BFEXShowChartViewCell%ld%ld",indexPath.row,self.selectType]];
    WS(weakSelf);
    if (cell == nil) {
        cell = [[BFEXShowChartViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"BFEXShowChartViewCell%ld%ld",indexPath.row,self.selectType]];
        cell.backImg = ^(UIImageView *img) {
            weakSelf.currentImg = img;
            WS(weakSelf);
            [SSKJ_Default_ActionsheetView showWithItems:@[SSKJLocalized(@"相机", nil),SSKJLocalized(@"相册", nil)] title:nil selectedIndexBlock:^(NSInteger selectIndex) {
                UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                imagePickerController.delegate = self;
                imagePickerController.allowsEditing = YES;
                if (selectIndex == 0) {
                    [weakSelf presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
                }else{
                    [weakSelf presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
                }
               
            } cancleBlock:^{
                
            }];
            
            
            
        };
    }
    cell.model = self.dataData;
    [cell setValueWith:self.dataArr[indexPath.row] type:self.addType];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)alertController {
    
    UIAlertController *alertVc = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *_Nonnull action) {
    }];
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    
    UIAlertAction *camera = [UIAlertAction actionWithTitle:@"打开相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *photo = [UIAlertAction actionWithTitle:@"打开相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertVc addAction:cancle];
    [alertVc addAction:camera];
    [alertVc addAction:photo];
    [self.viewController presentViewController:alertVc animated:YES completion:nil];
}
-(ICC_SelectPhotoView *)selectPhoto
{
    if (!_selectPhoto) {
        _selectPhoto = [[ICC_SelectPhotoView alloc]init];
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        WS(weakSelf);
        _selectPhoto.selectLibryAction = ^
        {
            
            [weakSelf presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
             [weakSelf removeCancelView];
        };
        _selectPhoto.takePhotoAction = ^
        {
            [weakSelf presentPickerConroller:imagePickerController sourceType:UIImagePickerControllerSourceTypeCamera];
            [weakSelf removeCancelView];
        };
    }
    return _selectPhoto;
}
-(void)removeCancelView
{
    [self.selectPhoto removeFromSuperview];
}
- (void)presentPickerConroller:(UIImagePickerController *)imagePickerController sourceType:(UIImagePickerControllerSourceType)sourceType {
    imagePickerController.sourceType = sourceType;
    WS(weakSelf);
    [self.viewController presentViewController:imagePickerController animated:YES completion:^{
       // [weakSelf hiddenView];
    }];
}

#pragma mark - Camera Delegate

- (void)CameraAchieveToImageDelegate:(FRCameraViewController *)ViewController Withimage:(UIImage *)image {
    //
//    [kNotifyCenter postNotificationName:@"showAlertView" object:nil];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
}

- (void)saveImage:(UIImage *)image {
    self.currentImg.image = image;
    //[self judge];
}

#pragma mark - photo delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    //获取返回的图片
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self performSelector:@selector(saveImage:) withObject:image afterDelay:0.5];
//    [kNotifyCenter postNotificationName:@"showAlertView" object:nil];
    [self.viewController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.viewController dismissViewControllerAnimated:YES completion:^{
//        [kNotifyCenter postNotificationName:@"showAlertView" object:nil];
    }];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1f;
}
#pragma mark --- 头部试图 ---
-(UIView *)headerView{
    if (!_headerView) {
        //CGRectMake(25, 80, Screen_Width - 50, Screen_Height - 160 - 90)
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(25, 0, Screen_Width - 50,140.f)];
//        _headerView.backgroundColor = kSubTitleColor;
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.text = SSKJLocalized(@"添加支付方式", nil);
        label.textColor = kBlueColor;
        label.frame = CGRectMake(16, 20, 200, 14);
        [label sizeToFit];
        label.tag = 100002;
        label.backgroundColor = [UIColor clearColor];
        [_headerView addSubview:label];
        
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.centerY = label.centerY;
        button.maxX = Screen_Width- 50.f -30.f;
        button.size = [UIImage imageNamed:@"root_x_close"].size;
        [button setImage:[UIImage imageNamed:@"root_x_close"]  forState:UIControlStateNormal];
        [self btn:button font:12 textColor:RGBCOLOR16(0xffffff) text:@"" image:[UIImage imageNamed:@"root_x_close"]];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:button];
        
        //透明 关闭按钮
        UIButton *alphaCloseButton=[UIButton buttonWithType:UIButtonTypeCustom];
  
        [alphaCloseButton addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        
        [alphaCloseButton setBackgroundColor:[UIColor clearColor]];
        
        [_headerView addSubview:alphaCloseButton];
        
        [alphaCloseButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(@0);
            
            make.right.equalTo(self->_headerView.mas_right);
            
            make.height.equalTo(@45);
            
            make.width.equalTo(@80);
        }];
        
        _headerView.centerX = self.backView.width / 2;
        [self.backView addSubview:_headerView];
    }
    return _headerView;
}
#pragma mark --- 添加支付方式 ---
-(void)buttonClicked:(UIButton *)sender
{
    
    if (sender.tag == 100000)
    {
        NSMutableDictionary *params =  [NSMutableDictionary dictionary];
        
        params[@"act"] = _addType?:@"add";
        
        switch (self.selectType) {
            case 1:
            {
                //支付宝
                params[@"payWay"] = @"2";
                
                if ([[ManagerSocket sharedManager].dataDic objectForKey:@"alipay"] != nil )
                {
                    params[@"alipayAccount"] =   [[ManagerSocket sharedManager].dataDic objectForKey:@"alipay"];

                }else{
                    [MBProgressHUD showError:SSKJLocalized(@"请输入支付宝账号", nil)];
                    return;
                }
                
                
                if (self.currentImg.image == nil && self.currentImg) {
                    [MBProgressHUD showError:SSKJLocalized(@"请上传二维码", nil)];
                    return;
                }
                
              
            }
                break;
            case 2:
                
            {
                if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"wx"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"wx"] length] == 0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请输入微信账号", nil)];
                    return;

                }
                //微信
                params[@"payWay"] = @"1";
                params[@"wxAccount"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"wx"];;
                
                
                if (self.currentImg.image == nil && self.currentImg) {
                    [MBProgressHUD showError:SSKJLocalized(@"请上传二维码", nil)];
                    return;
                }

            }
                break;
            case 3:
            {
                //银行卡
                if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"bank"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"bank"] length] == 0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请输入开户银行名", nil)];
                    return;
                }else if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"branch"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"branch"] length] == 0){
                    [MBProgressHUD showError:SSKJLocalized(@"请输入支行名", nil)];
                    return;
                }else if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"bank_car"]]&& [[[ManagerSocket sharedManager].dataDic objectForKey:@"bank_car"] length] == 0){
                    [MBProgressHUD showError:SSKJLocalized(@"请输入银行卡号", nil)];
                    return;
                }
                params[@"payWay"] = @"3";
                params[@"bankCardOpenBank"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"bank"];
                params[@"bankCardUnionNo"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"branch"];
                params[@"bankCardNo"] = [[ManagerSocket sharedManager].dataDic objectForKey:@"bank_car"];

            }
                break;
            case 4:
            {
                if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"Paypal"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"Paypal"] length] == 0) {
                    [MBProgressHUD showError:SSKJLocalized(@"请输入您的", nil)];
//                    [self removeSave];
                }
                params[@"payWay"] = @"paypal";
                params[@"pal_account"]=[[ManagerSocket sharedManager].dataDic objectForKey:@"Paypal"];
            }
                 break;
            default:
                break;
        }
        if (![WLTools judgeString:[[ManagerSocket sharedManager].dataDic objectForKey:@"tpwd"]] && [[[ManagerSocket sharedManager].dataDic objectForKey:@"tpwd"] length] == 0) {
            [MBProgressHUD showError:SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)];
            return;

//            [self removeSave];
        }else{
            params[@"dealPswd"] = [WLTools md5:[[ManagerSocket sharedManager].dataDic objectForKey:@"tpwd"]];
        }
        
        params[@"username"] = [SSKJ_User_Tool sharedUserTool].userInfoModel.username;
        params[@"id"] = kUserID;

        
        if (self.selectType == 1 || self.selectType == 2) {
            self.params = params;
            
            if (self.currentImg.image != nil) {
                [self uploadImage];
            }else{
                
                if (self.selectType == 1) {
                    [self.params setObject:self.imageURL forKey:@"aliImg"];

                }else{
                    [self.params setObject:self.imageURL forKey:@"wxImg"];

                }
                
                [self requestBindPayWithParams:self.params];
            }

        }else{
            
            [self requestBindPayWithParams:params];

        }
       
    }else{
        [self removeSave];
        self.cancellBlock();
    }
   
}

- (void)removeSave{
    NSArray *array=@[@"alipay",@"wx",@"tpwd",@"bank",@"branch",@"bank_car",@"Paypal"];
    [[ManagerSocket sharedManager].dataDic removeObjectsForKeys:array];
    return;
}

-(void)requestBindPayWithParams:(NSDictionary *)params
{
    
    NSString *url = BI_AddPayWay_URL;
    if ([self.addType isEqualToString:@"edit"]) {
        url = BI_UpdatePayWay_URL;
    }
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model *netmodel = [WL_Network_Model mj_objectWithKeyValues:responseObject];

        if (netmodel.status.integerValue == SUCCESSED) {
            if ([weakSelf.addType isEqualToString:@"edit"]) {
                [MBProgressHUD showSuccess:SSKJLocalized(@"修改成功", nil)];

            }else{
                [MBProgressHUD showSuccess:SSKJLocalized(@"添加成功", nil)];

            }
            [self removeSave];
            self.cancellBlock();
            if (self.sucessBlock) {
                self.sucessBlock();
            }
        }else{
            [MBProgressHUD showError:netmodel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}

- (void)uploadImage
{
    [MBHUD showHUDAddedTo:self];
    //!< 限制图片在1M以内
    UIImage *image = [UIImage compressImageQuality:self.currentImg.image toByte:(1*1024)];
    WS(weakSelf);
    
    [[WLHttpManager shareManager]  upLoadImageByUrl:BI_Upload_URL ImageName:@"file" Params:nil Image:image CallBack:^(id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf];
         
         WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netModel.status.integerValue == SUCCESSED)
         {
             weakSelf.imageURL = netModel.data;

             if (weakSelf.selectType == 1) {
                 [weakSelf.params setObject:weakSelf.imageURL forKey:@"aliImg"];
             }else if (weakSelf.selectType == 2){
                 [weakSelf.params setObject:weakSelf.imageURL forKey:@"wxImg"];
             }
             [weakSelf requestBindPayWithParams:weakSelf.params];
             
         }
         else
         {
             [MBHUD showError:netModel.msg];
         }
     } Failure:^(NSError *error)
     {
         [MBHUD hideHUDForView:weakSelf];
     }];
}





#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = self.dataArr[indexPath.row];
    if ([dic.allKeys.firstObject isEqualToString:@"二维码"])
    {
        return 100;
    }
    return 85;
}


#pragma mark --- 获取数据 ---
-(void)setAddType:(NSString *)addType
{
    _addType = addType;
    UILabel *ways = [self.headerView viewWithTag:100002];
   
    if ([_addType isEqualToString:@"edit"]) {
        ways.text = SSKJLocalized(@"修改支付方式", nil);
        _btn.enabled = NO;
    }else{
        ways.text = SSKJLocalized(@"添加支付方式", nil);
    }
    [ways sizeToFit];
}
-(void)setDataData:(FB_PayWayModel *)dataData{
//    SSLog(@"+++++++++++%@+++++++++++",dataData);
    _dataData = dataData;
//    self.inputTextView.text=_dataData[@"tip"]?:self.inputTextView.text;
    
    
    
    NSArray *array = @[SSKJLocalized(@"支付宝", nil) ,SSKJLocalized(@"微信",nil),SSKJLocalized(@"银行卡",nil),@"Paypal"];
    
    NSInteger payType = _dataData.payType.integerValue;
    NSInteger index = 0;

    if (payType == 1) {
        index = 1;
    }else if (payType == 2){
        index = 0;
    }else{
        index = 2;
    }

    self.inputTextView.text = array[index];
    
//    self.alertView.selectIndexBlock(index);
    _selectType = index + 1;
    switch (self.selectType) {
        case 1:
        {
             self.dataArr =  @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):SSKJLocalized(@"请输入支付宝账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
            if ([_addType isEqualToString:@"edit"]) {
                self.dataArr =  @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"支付宝", nil):dataData.account},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的支付宝收款二维码图片", nil)},@{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.account forKey:@"alipay"];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.qrCode forKey:@"aliImg"];
                self.imageURL = dataData.qrCode;

            }
        }
            break;
        case 2:
            
        {
             self.dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},@{SSKJLocalized(@"微信", nil):SSKJLocalized(@"请输入微信账号", nil)},@{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的微信收款二维码图片", nil)},@{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
            
            if ([_addType isEqualToString:@"edit"]) {
                
                self.dataArr = @[@{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{SSKJLocalized(@"微信", nil):dataData.account},
                                 @{SSKJLocalized(@"二维码", nil):SSKJLocalized(@"请上传您的微信收款二维码图片", nil)},
                                 @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.account forKey:@"wx"];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.qrCode forKey:@"wxImg"];
                self.imageURL = dataData.qrCode;
                
            }
        }
            break;
        case 3:
        {
            self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{SSKJLocalized(@"开户银行", nil):SSKJLocalized(@"请输入开户银行名", nil)},
                                 @{SSKJLocalized(@"开户支行", nil):SSKJLocalized(@"请输入支行名", nil)},
                                 @{SSKJLocalized(@"开户银行卡", nil):SSKJLocalized(@"请输入银行卡号", nil)},
                                 @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
            if ([_addType isEqualToString:@"edit"]) {
                
                self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{SSKJLocalized(@"开户银行", nil):dataData.bankCardOpenBank},
                                 @{SSKJLocalized(@"开户支行", nil):dataData.AccountOpeningBranch},
                                 @{SSKJLocalized(@"开户银行卡", nil):dataData.account},
                                 @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.bankCardOpenBank forKey:@"bank"];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.AccountOpeningBranch forKey:@"branch"];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.account forKey:@"bank_car"];

            }
            
        }
            break;
        case 4:{
            NSString *str = [NSString stringWithFormat:@"Paypal%@",SSKJLocalized(@"账户", nil)];

            self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{str:SSKJLocalized(@"请输入您的", nil)},
                                 @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
            if ([_addType isEqualToString:@"edit"]) {
                self.dataArr = @[
                                 @{SSKJLocalized(@"姓名", nil):SSKJLocalized(@"请输入姓名", nil)},
                                 @{str:dataData.account},
                                 @{SSKJLocalized(@"资金密码", nil):SSKJLocalized(@"请输入资金密码(8-20位数字+字母)", nil)}];
                [[ManagerSocket sharedManager].dataDic setObject:dataData.account forKey:@"Paypal"];

            }
        }
            break;
        default:
            break;
    }
    [self.showTableView reloadData];
}
@end
