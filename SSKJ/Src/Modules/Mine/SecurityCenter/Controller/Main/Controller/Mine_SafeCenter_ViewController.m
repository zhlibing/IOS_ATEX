//
//  BLSafeCenterViewController.m
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import "Mine_SafeCenter_ViewController.h"
#import "BFEXReChartWayTableViewCell.h"
#import "My_BindPhone_ViewController.h"
#import "BI_BindEmail_ViewController.h"

#import "Mine_ChangePWD_ViewController.h"
#import "My_SetTPWD_ViewController.h"
#import "My_GoogleVerify_ViewController.h"
#import "My_BindGoogle_AlertView.h"
#import "SSKJ_SafeSelect_ViewController.h"
#import "BLSafeCenterCell.h"
#import "SSKJ_Default_AlertView.h"
#import "RegularExpression.h"
#import "My_Certificate_ViewController.h"
#import "BI_BusinessApply_ViewController.h"
#import "FB_PayWayModel.h"
#import "Mine_Authentication_ViewController.h"

@interface Mine_SafeCenter_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *cellTitleArr;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) My_BindGoogle_AlertView *googleAlertView;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSArray *payWaysArray;


@property (nonatomic, copy) NSString *zhiwenOpenStatus;

@end

@implementation Mine_SafeCenter_ViewController

- (NSMutableArray *)cellTitleArr {
    if (!_cellTitleArr) {
        _cellTitleArr = [NSMutableArray array];
        [_cellTitleArr insertObject:@[SSKJLocalized(@"手机", nil),
                                      SSKJLocalized(@"登录密码", nil),
                                      SSKJLocalized(@"资金密码", nil),
                                      SSKJLocalized(@"谷歌验证", nil),
                                      SSKJLocalized(@"身份认证", nil),
                                      SSKJLocalized(@"商家申请", nil),
                                      ] atIndex:0];
        
    
        
        [_cellTitleArr insertObject:@[] atIndex:1];
        
    }
    return _cellTitleArr;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"安全中心", nil);
    self.userModel = [SSKJ_User_Tool sharedUserTool].userInfoModel;
    [self setupUI];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadBankListNo) name:@"reloadBankListAction" object:nil];
}

- (void)reloadBankListNo {
    [self reloadBankList];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self reloadBankList];
    [self loadUserInfo];
}


-(My_BindGoogle_AlertView *)googleAlertView
{
    if (nil == _googleAlertView) {
        _googleAlertView = [[My_BindGoogle_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _googleAlertView.submitBlock = ^(NSString * _Nonnull googleCode, NSString * _Nonnull smsCode) {
            [weakSelf requestDeleteGoogleWithCode:smsCode googleCode:googleCode];
        };
    }
    return _googleAlertView;
}

/**
 加载用户数据
 */


-(void)reloadBankList
{
    WS(weakSelf);
    NSDictionary *params = @{
                             @"id":kUserID
                             };
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_Paylist_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.tableView.mj_header endRefreshing];
        if (net_model.status.integerValue == SUCCESSED) {
            
            NSArray *array = [FB_PayWayModel mj_objectArrayWithKeyValuesArray:net_model.data];
            weakSelf.payWaysArray = [NSMutableArray arrayWithArray:array];
            if (weakSelf.payWaysArray.count == 3) {
                weakSelf.tableView.tableFooterView = nil;
            }
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showError:net_model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.tableView.mj_header endRefreshing];
    }];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStyleGrouped)];
    tableView.frame = CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar);
    tableView.delegate = self;
    tableView.separatorColor = kLineColor;
    tableView.backgroundColor  = kSubBgColor;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.contentInset = UIEdgeInsetsMake(ScaleW(10), 0, 0, 0);
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.tableFooterView = self.footerView;
    WS(weakSelf);
    _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf reloadBankList];
        [weakSelf loadUserInfo];
    }];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setHeadView];
    
}
-(void)setHeadView{
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(170))];
    
    self.tableView.tableHeaderView=view;
    
    view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_safe"]];
    
    [view addSubview:img];
    
    img.center=view.center;

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 1) {
        return self.payWaysArray.count;
    }
    NSArray *array = self.cellTitleArr[section];
    return array.count;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.cellTitleArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 ) {
        BLSafeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"safeCell"];
        if (cell == nil) {
            cell = [[NSBundle mainBundle]loadNibNamed:@"BLSafeCenterCell" owner:nil options:nil].firstObject;
        }
        NSArray *array = self.cellTitleArr[indexPath.section];
        cell.cellTitle.text = array[indexPath.row];
        NSString *status = [self statusWithModel:_userModel indexPath:indexPath];
        cell.status.text = status;
        
        if ([status containsString:SSKJLocalized(@"已开启", nil)] || [status containsString:SSKJLocalized(@"初级已认证", nil)] || [status isEqualToString:SSKJLocalized(@"修改", nil)]|| [status containsString:SSKJLocalized(@"高级已认证", nil)] || [status containsString:SSKJLocalized(@"解除商家认证", nil)] ||[status containsString: SSKJLocalized(@"已认证", nil)] ||
            [status isEqualToString:SSKJLocalized(@"已设置", nil)] || [status isEqualToString:SSKJLocalized(@"已绑定", nil)]) {
            cell.status.textColor = kBlueColor;
        }else{
            cell.status.textColor = kSubTitleColor;
        }
       
       
        return cell;
    }
    
    
    if(indexPath.section == 1){//支付方式
        BFEXReChartWayTableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),indexPath.row]];
            if (!cell)
            {
                cell = [[BFEXReChartWayTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"%@%ld",NSStringFromClass([self class]),indexPath.row]];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                WS(weakSelf);
                cell.edtingBlock = ^(FB_PayWayModel *model) {//修改点击方法
                    [weakSelf showViewAlert:model];
                };
                
                cell.switchBlock = ^(FB_PayWayModel *model) {
                    [weakSelf requestSwitchPayMethodWithModel:model];
                };
            }
        FB_PayWayModel *model = self.payWaysArray[indexPath.row];
        [cell setValueData:model];
        return cell;
    }
    return nil;
}

#pragma mark -  设置不同状态
- (NSString *)statusWithModel:(SSKJ_UserInfo_Model *)model indexPath:(NSIndexPath *)indexPath {
    NSString *status;
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            NSString *mobile = [self setupTitle:model.tel?:@""];
            status = (model.tel && ![model.tel isEqualToString:@""]) ? mobile  : SSKJLocalized(@"未绑定", nil);
        }

        else if (indexPath.row == 1){
            status = SSKJLocalized(@"已设置", nil);
        }else if (indexPath.row == 2){
            if (model.tradePswdStatus.integerValue == 1) {
                status = SSKJLocalized(@"已设置", nil);
            }else{
                status = SSKJLocalized(@"未设置", nil);
            }

        }
        else if (indexPath.row==3){
            if (model.googleAuthenticationStatus.integerValue == 0) {//未认证
                status = SSKJLocalized(@"未绑定", nil);
            }else{
                status = SSKJLocalized(@"已绑定", nil);
            }
        }
        else if (indexPath.row == 4){
            
            /*
             NSString *email = [self setupTitle:model.email?:@""];
             status = (model.email && ![model.email isEqualToString:@""]) ? email   : SSKJLocalized(@"未绑定", nil);
             */
            
            
            
            if ([model.basicAuthenticationStatus integerValue] == 0) {  // 未认证
                status = SSKJLocalized(@"初级未认证", nil);
            }else if ([model.basicAuthenticationStatus integerValue] == 1) {
                if (model.highAuthenticationStatus.integerValue == 1) {
                    status = SSKJLocalized(@"高级未认证", nil);
                }else if (model.highAuthenticationStatus.integerValue == 2){
                    status = SSKJLocalized(@"高级审核中", nil);
                }
                else if (model.highAuthenticationStatus.integerValue == 3){
                    status = SSKJLocalized(@"高级已认证", nil);
                }
                else if (model.highAuthenticationStatus.integerValue == 4){
                    status = SSKJLocalized(@"高级已拒绝", nil);
                }
            }

                }
        else if (indexPath.row ==5){
            if (model.shopAuthenticationStatus.integerValue == 3) {//已认证
                status = SSKJLocalized(@"已认证", nil);
            }else if (model.shopAuthenticationStatus.integerValue == 1 || model.shopAuthenticationStatus.integerValue == 5){//未认证
                status = SSKJLocalized(@"未认证", nil);
            }else if (model.shopAuthenticationStatus.integerValue == 2) {
                status = SSKJLocalized(@"待审核", nil);
            }else if (model.shopAuthenticationStatus.integerValue == 4) {
                status = SSKJLocalized(@"已拒绝", nil);
            }else if (model.shopAuthenticationStatus.integerValue == 6) {
                status = SSKJLocalized(@"审核中", nil);
            }
        }
    }else if (indexPath.section == 1){

    }
    
    return status;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section == 0){
       return ScaleW(56);
    }else{
        return ScaleW(120);
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(section == 0 ){
        return ScaleW(5);
    }
    if(section == 1){
        return self.sectionView.height;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if(section == 1)
    {
        return self.sectionView;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
  return [[UIView alloc] initWithFrame:CGRectZero];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    WS(weakSelf);
    if (indexPath.section == 0) {
        BLSafeCenterCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (indexPath.row == 0) {

//            if (![self judgePayPassword]) {
//                return;
//            }
//            My_BindPhone_ViewController *vc = [[My_BindPhone_ViewController alloc]init];
//            vc.bindType = BindTypePhone;
//            vc.successBlock = ^(NSString * _Nonnull account) {
//                cell.status.text = account;
//                weakSelf.userModel.tel = account;
//            };
//            if (self.userModel.tel.length != 0) {
//                vc.from = 1;
//            }
//            
//            [self.navigationController pushViewController:vc animated:YES];
            [SSTool success:SSKJLanguage(@"手机号已绑定")];

        }
        else if (indexPath.row == 1) {
            Mine_ChangePWD_ViewController *resetPwdVC = [[Mine_ChangePWD_ViewController alloc] init];
            [self.navigationController pushViewController:resetPwdVC animated:YES];
        }else if (indexPath.row == 2) {
            My_SetTPWD_ViewController *vc = [[My_SetTPWD_ViewController alloc]init];
            vc.isEdit = NO;
            if ([self.userModel.tradePswdStatus intValue] == 1) {
                //已设置过资金密码
                vc.isEdit = YES;
            }
            vc.statusBlock = ^{
                cell.status.text = SSKJLocalized(@"修改",nil) ;
            };
            vc.phoneNumber = kAccount;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (indexPath.row == 3){

            if (weakSelf.userModel.googleAuthenticationStatus.integerValue == 0) {//未认证
              
                My_GoogleVerify_ViewController *vc = [[My_GoogleVerify_ViewController alloc]init];
                WS(weakSelf);
                vc.addGoogleBlock = ^{
                    
                };
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }else{
              
                [self.googleAlertView showWithType:GOOGLETYPEDELETE];//解绑
            }
        }
        else if (indexPath.row == 4) {
            
            /*
             
             if (![self judgePayPassword]) {
             return;
             }
             BI_BindEmail_ViewController *bindEmailVC = [[BI_BindEmail_ViewController alloc] init];
             bindEmailVC.successBlock = ^(NSString * _Nonnull account) {
             cell.status.text = account;
             weakSelf.userModel.email = account;
             };
             if (self.userModel.email.length != 0) {
             bindEmailVC.from = 1;
             //         [MBProgressHUD showError:SSKJLocalized(@"邮箱已绑定", nil)];
             }
             
             [self.navigationController pushViewController:bindEmailVC animated:YES];
             */
            
            Mine_Authentication_ViewController *vc = [Mine_Authentication_ViewController new];
            
            [self.navigationController pushViewController:vc animated:YES];
     
                } else if (indexPath.row == 5) {
            
            if (![self judgeSecondCertificate]) {
                return;
            }
//
          
            NSInteger is_shop = [SSKJ_User_Tool sharedUserTool].userInfoModel.shopAuthenticationStatus.integerValue;
//            BI_BusinessApply_ViewController *vc = [[BI_BusinessApply_ViewController alloc]init];
//
//            [weakSelf.navigationController pushViewController:vc animated:YES];
//
            if (is_shop == 1 || is_shop == 4 ||  is_shop == 5) {

                BI_BusinessApply_ViewController *vc = [[BI_BusinessApply_ViewController alloc]init];

                [weakSelf.navigationController pushViewController:vc animated:YES];

            }else if (is_shop == 3){

                [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"解除商家认证", nil) message:SSKJLocalized(@"在广告全部下架且没有未处理的交易纠纷的情况下，会在3个工作日内解除认证。\n\n解除认证后将不再享有认证商家的权限和服务。", nil) cancleTitle:@"取消" confirmTitle:SSKJLocalized(@"申请", nil) confirmBlock:^{

                    [weakSelf requestCancleShop];

                }];
            }
            
         }
    
    }

}


    
-(UIView *)sectionView{
    if (!_sectionView) {
        _sectionView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, ScaleW(98))];
        _sectionView.backgroundColor = [UIColor whiteColor];
        

        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(17, 25, 0, 14);
        label.font = [UIFont systemFontOfSize:14];
        label.text = SSKJLocalized(@"支付方式", nil);
        [label sizeToFit];
        label.textColor = kTitleColor;
        label.textAlignment = NSTextAlignmentCenter;  label.backgroundColor = [UIColor clearColor];
        [_sectionView addSubview:label];
        UILabel *labelcontent = [[UILabel alloc] init];
        labelcontent.font = [UIFont systemFontOfSize:12.f];
        labelcontent.frame = CGRectMake(17, label.bottom + 13, Screen_Width - 34, 0);
        labelcontent.text = SSKJLocalized(@"请务必使用您本人的实名账户，被激活的支付方式将在交易时向买方展示，最多激活3种", nil);
        NSString *string = SSKJLocalized(@"请务必使用您本人的实名账户，被激活的支付方式将在交易时向买方展示，最多激活3种", nil);
        CGFloat height = [string boundingRectWithSize:CGSizeMake(ScreenWidth - 34, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:systemFont(12)} context:nil].size.height;
        labelcontent.height = height;
        _sectionView.height = height + 65;
        labelcontent.numberOfLines = 0;
        [labelcontent sizeToFit];
        labelcontent.textColor = kSubTitleColor;
       
        [_sectionView addSubview:labelcontent];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScaleW(15), _sectionView.height - 1, Screen_Width, 1.f)];
        line.backgroundColor = kLineColor;
         [_sectionView addSubview:line];

    }
    return _sectionView;
}

-(UIView *)footerView{
    if (!_footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 55)];
        _footerView.backgroundColor = [UIColor whiteColor];
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0, 0, Screen_Width, 55);
        button.titleLabel.font = [UIFont systemFontOfSize:13.f];
        [button setTitle:SSKJLocalized(@"添加支付方式", nil) forState:UIControlStateNormal];
        [button setTitleColor:kBlueColor forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addSubview:button];
    }
    return _footerView;
}
#pragma mark -- 添加支付方式 --
-(void)buttonClicked:(UIButton *)sender
{
#warning 测试
//    if (![self judgeFristCertificate]) {
//        return;
//    }
    if (![self judgePayPassword]) {
        return;
    }
    
    [self showViewAlert:@"add"];
}
-(void)showViewAlert:(id)type{
    SSKJ_SafeSelect_ViewController *vc = [[SSKJ_SafeSelect_ViewController alloc]init];
    vc.modalPresentationStyle = UIModalPresentationOverFullScreen;
    [vc showViewAlert:type];
    [self.navigationController presentViewController:vc animated:YES completion:^{

    }];

    
}


#pragma mark - 开启关闭支付状态

-(void)requestSwitchPayMethodWithModel:(FB_PayWayModel *)payModel
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSString *flag;
    if (payModel.status.integerValue == 0) {
        flag = @"0";
    }else{
        flag = @"1";
    }
    
    NSDictionary *params = @{
                             @"userId":kUserID,
                             @"payId":payModel.ID,
                             @"flag":flag
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_SwitchPayWay_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:netModel.msg];

            [weakSelf reloadBankList];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}


#pragma mark - 取消谷歌绑定

-(void)requestDeleteGoogleWithCode:(NSString *)smsCode googleCode:(NSString *)googleCode
{
    NSDictionary *params = @{
                             @"telCode":smsCode,
                             @"code":googleCode?:@"",
                             @"stockUserId":kUserID,
                             @"areaCode":[SSTool myAreaCode]
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_CancleGoogleAuthVerify_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {
            [SSKJ_User_Tool sharedUserTool].userInfoModel.googleAuthenticationStatus = @"0";
            [weakSelf.tableView reloadData];

        }else{
            [MBProgressHUD showError:network_model.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
    }];
}

#pragma mark - 解除商家认证
-(void)requestCancleShop
{
    NSDictionary *params = @{
                             @"id":kUserID
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_InspectAuth_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED) {

            [MBProgressHUD showSuccess:SSKJLocalized(@"操作成功", nil)];
            [SSKJ_User_Tool sharedUserTool].userInfoModel.shopAuthenticationStatus = @"6";
            [weakSelf.tableView reloadData];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];

    }];
}

- (NSString *)setupTitle:(NSString *)title {
    NSString *mobileStr;
    if (![RegularExpression validateEmail:title] ) {
        mobileStr = [title stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        mobileStr = [WLTools hideEmailWithEmail:title];
    }
    return mobileStr;
}



#pragma mark 请求用户信息
- (void)loadUserInfo
{
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"id"] = kUserID;
    
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
           
            dispatch_async(dispatch_get_main_queue(), ^{
                SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_Model.data];
                [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
                weakSelf.userModel = userModel;

                [weakSelf.tableView reloadData];
                
            });
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

