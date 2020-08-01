//
//  Mine_Authentication_ViewController.m
//  SSKJ
//
//  Created by zpz on 2019/9/22.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_Authentication_ViewController.h"
#import "BLSafeCenterCell.h"

#import "My_AdvancedCertificate_ViewController.h"
#import "My_PrimaryCertificate_ViewController.h"

#import "SKCertificationStateViewController.h"

@interface Mine_Authentication_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@end

@implementation Mine_Authentication_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"身份认证", nil);
    [self setupUI];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self loadUserInfo];
}

- (void)setupUI {
    UITableView *tableView = [[UITableView alloc] initWithFrame:(CGRectZero) style:(UITableViewStylePlain)];
    tableView.frame = CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar);
    tableView.delegate = self;
    tableView.separatorColor = kLineColor;
    tableView.backgroundColor  = kSubBgColor;
    tableView.dataSource = self;
    tableView.bounces = YES;
    tableView.rowHeight = ScaleW(50);
    tableView.contentInset = UIEdgeInsetsMake(ScaleW(10), 0, 0, 0);
    [self.view addSubview:tableView];
    [tableView registerNib:[UINib nibWithNibName:@"BLSafeCenterCell" bundle:nil] forCellReuseIdentifier:@"BLSafeCenterCell"];
    _tableView = tableView;
    
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    [self setHeadView];
    
}
-(void)setHeadView{
    
    
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(310))];
    
    self.tableView.tableHeaderView=view;
    
    view.backgroundColor=[UIColor whiteColor];
    
    UIImageView *img=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"mine_auth"]];
    
    [view addSubview:img];
    
    img.center=view.center;
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, view.height - ScaleW(10), view.width, ScaleW(10))];
    line.backgroundColor = kSubBgColor;
    [view addSubview:line];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BLSafeCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BLSafeCenterCell"];
    
    SSKJ_UserInfo_Model *model = [SSKJ_User_Tool sharedUserTool].userInfoModel;
    UIColor *color = RED_HEX_COLOR;
    if (indexPath.row == 0) {
        
        cell.cellTitle.text = SSKJLanguage(@"初级认证");
        
        if ([model.basicAuthenticationStatus integerValue] == 1){
            cell.status.text = SSKJLanguage(@"已认证");
            color = GREEN_HEX_COLOR;
        }else{
            cell.status.text = SSKJLanguage(@"未认证");
        }
    }else{
        cell.cellTitle.text = SSKJLanguage(@"高级认证");
        
        NSString *status = @"";
        if (model.highAuthenticationStatus.integerValue == 1) {
            status = SSKJLocalized(@"未认证", nil);
        }else if (model.highAuthenticationStatus.integerValue == 2){
            status = SSKJLocalized(@"审核中", nil);
        }
        else if (model.highAuthenticationStatus.integerValue == 3){
            status = SSKJLocalized(@"已认证", nil);
            color = GREEN_HEX_COLOR;
        }
        else if (model.highAuthenticationStatus.integerValue == 4){
            status = SSKJLocalized(@"已拒绝", nil);
        }
        cell.status.text = status;
        
    }
    cell.status.textColor = color;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        [self primaryAuthAction];
    }else{
        [self advancedAuthAction];
    }
}


#pragma mark 认证触发事件
#pragma mark 实名认证
-(void)primaryAuthAction
{
    
    NSInteger baseStatus = [SSKJ_User_Tool sharedUserTool].userInfoModel.basicAuthenticationStatus.integerValue;
    if (baseStatus == 0) {
        My_PrimaryCertificate_ViewController *vc = [[My_PrimaryCertificate_ViewController alloc]init];
        vc.successBlock = ^(NSString * _Nonnull name, NSString * _Nonnull idCard)
        {
        };
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        //        [MBHUD showError:SSKJLocalized(@"初级认证已通过，无需重复认证", nil)];
        SKCertificationStateViewController *  certificationStateVC =[SKCertificationStateViewController new];
        certificationStateVC.type = 1;
        certificationStateVC.state = CertificationSuccess;
        [self.navigationController pushViewController:certificationStateVC animated:YES];
        
        
    }
}


#pragma mark 高级认证
-(void)advancedAuthAction
{
    
    NSInteger baseStatus = [SSKJ_User_Tool sharedUserTool].userInfoModel.basicAuthenticationStatus.integerValue;
    
    if (baseStatus == 0) {
        [MBHUD showError:SSKJLocalized(@"请先完成初级实名认证", nil)];
        return;
    }
    
    NSInteger advanceStatus = [SSKJ_User_Tool sharedUserTool].userInfoModel.highAuthenticationStatus.integerValue;
    if (advanceStatus == 1) {
        My_AdvancedCertificate_ViewController *vc = [[My_AdvancedCertificate_ViewController alloc]init];
        vc.successBlock = ^{};
        [self.navigationController pushViewController:vc animated:YES];
        
    }else{
        
        SKCertificationStateViewController *  certificationStateVC =[SKCertificationStateViewController new];
        certificationStateVC.type = 2;
        
        if (advanceStatus == 2){
            //        [MBHUD showError:SSKJLocalized(@"高级认证审核中，请耐心等待！", nil)];
            certificationStateVC.state = CertificationOngoing;
            
            
        }else if (advanceStatus == 3){
            //        [MBHUD showError:SSKJLocalized(@"高级认证已通过，无需重复认证", nil)];
            certificationStateVC.state = CertificationSuccess;
            
        }else if (advanceStatus == 4){
            certificationStateVC.state = CertificationFailure;
            
        }
        
        [self.navigationController pushViewController:certificationStateVC animated:YES];
        
    }
    
}


#pragma mark 请求用户信息
- (void)loadUserInfo
{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"id"] = kUserID;
    
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        //        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
            
            SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_Model.data];
            [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
            [weakSelf.tableView reloadData];
            
        }else{
            [MBProgressHUD showError:network_Model.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
    
}

@end
