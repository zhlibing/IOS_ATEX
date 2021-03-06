//
//  BI_MineRoot_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/6/17.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "Mine_Root_ViewController.h"
#import "Mine_Setting_ViewController.h"   // 设置
#import "Mine_SafeCenter_ViewController.h" //!< 安全中心
#import "Home_NoticeList_ViewController.h" //!< 公告
#import "SSKJ_Protocol_ViewController.h"    //!< 关于我们
#import "Mine_Recharge_ViewController.h"
#import "Mine_AddressManager_ViewController.h"
#import "My_Generalize_RootViewController.h"
#import "Mine_PrimaryCertificate_ViewController.h"
#import "Mine_CertificationState_ViewController.h"
#import "Mine_Version_AlertView.h"
#import "SSKJ_Default_AlertView.h"      // 通用弹框
#import "Mine_Item_Cell.h" //!<我的列表cell
#import "LoginAlertView.h"
#import "Mine_Item_CollectionViewCell.h"

#import "Mine_Item_Model.h"
#import "Mine_Version_Model.h"

#import "Lion_AboutUsVC.h"
#import "Market_KeyBuyCoin_VC.h"

@interface Mine_Root_ViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic,strong) NSMutableArray <Mine_Item_Model*> *itemArray; //!< item数据源数组

@property (nonatomic,strong) UIView *tableHeadView;//tableHeadView

@property (nonatomic,strong) UIImageView *topImgView;//顶部背景图

@property (nonatomic,strong) UILabel *userNameLabel;//用户名

@property (nonatomic,strong) UILabel *userUsdtLabel;//用户资产USDT
@property (nonatomic,strong) UILabel *moneyLabel;//用户资产CNY
@property(nonatomic, strong)UILabel *uidLabel;

@property(nonatomic, strong)UIButton *show;

@property(nonatomic, strong)UICollectionView *collectionView;
//配置参数
@property(nonatomic)CGFloat itemWidth;
@property(nonatomic)CGFloat itemHeight;

@property(nonatomic, strong)UIView *loginView;
@property(nonatomic, strong)UIView *topView;
@property(nonatomic ,strong) UIImageView *headerImageV;
@property (nonatomic ,strong)UIImageView *leveImgV;
@property (nonatomic ,strong) UILabel *userIdLb;
@property (nonatomic ,strong) UIButton *settingBtn;
@property (nonatomic ,strong) UIView *topItemsView;
@property (nonatomic ,strong) UIButton *userIdcopyBtn;
@property (nonatomic ,strong) UILabel *noLoginLb;
@property (nonatomic ,assign) BOOL showType;
@end

@implementation Mine_Root_ViewController

 #pragma mark - LifeCycle Method
- (void)viewDidLoad
{
    [super viewDidLoad];
    //是否展示 时间合约
    self.showType = (self.tabBarController.childViewControllers.count == 4) ? NO : YES;
    
    [self setupItems];

    [self setupUI];
    
    
    
}

- (void)setupUI{
    self.view.backgroundColor = kBgColor;
    
    [self configHeadView];

    self.itemWidth = ScreenWidth;
    self.itemHeight = ScaleW(55);
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width1 = self.itemWidth;
    layout.itemSize = CGSizeMake(width1, self.itemHeight);
    layout.minimumInteritemSpacing = 1;
    layout.minimumLineSpacing = 1;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.tableHeadView.bottom, ScreenWidth, ScreenHeight - self.tableHeadView.height) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[Mine_Item_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = kBgColor;
    _collectionView.contentInset = UIEdgeInsetsMake(ScaleW(15), 15, 0, 15);
    [self.view addSubview:_collectionView];

    
    NSInteger column = 3;
    NSInteger total = self.itemArray.count;
    NSInteger row = (total+column-1)/column;
    CGFloat width = self.itemWidth;
    CGFloat height = self.itemHeight;
    
    //行数
    for (int i = 0; i < row - 1; i++) {
        UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, (i + 1) * (height + 1) - 1, ScreenWidth - ScaleW(30), 1)];
        line.backgroundColor = kLineColor;
        [self.collectionView addSubview:line];
    }
    
//    //最后一行
//    UIView *bottomline = [[UIView alloc] initWithFrame:CGRectMake(0, row * (height + 1) - 1, (width + 1) * ((total%column)?(total%column):column) - 1, 1)];
//    bottomline.backgroundColor = kLineColor;
//    [self.collectionView addSubview:bottomline];
    
    //列数,待优化
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(width, 0, 1, (height+1) * row)];
    line.backgroundColor = kLineColor;
    [self.collectionView addSubview:line];
    
    //最后一列
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(width * 2 + 1, 0, 1, (height+1) * (total%column==1 ? row-1 : row))];
    line1.backgroundColor = kLineColor;
    [self.collectionView addSubview:line1];
    
    [self.collectionView reloadData];
}

#pragma mark - 登录状态处理页面
- (void)setupIsLogin{
    self.tableHeadView.height = kLogin ? ScaleW(360) + Height_StatusBar : ScaleW(360) + Height_StatusBar;
    self.collectionView.y = self.tableHeadView.bottom;
    if (!self.showType) {
        self.collectionView.y = self.tableHeadView.bottom - ScaleW(64);
    }
    
    
    if (kLogin) {
        
        self.topView.hidden = NO;
        self.loginView.hidden = NO;
        
    }else{
        self.topView.hidden = YES;
        self.loginView.hidden = NO;
        self.leveImgV.image = MyImage(@"我的-等级-L0");
        self.userIdLb.text = @"ID : --";
        self.userNameLabel.text = SSKJLocalized(@"未登录", nil);
        self.headerImageV.image = MyImage(@"我的-头像");
    }
}

-(void)viewWillAppear:(BOOL)animated
{
//    [kUserDefaults setObject:@"1" forKey:@"kLogin"];
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:![SSTool isRoot]];//
    [self setupIsLogin];

    if (kLogin) // 已登录，显示用户信息
    {
        [self loadUserInfo];
        self.userIdcopyBtn.hidden = NO;
    }else{
        self.userIdcopyBtn.hidden = YES;
    }
    
    if (!kLogin) {
        //未登录
        self.userIdcopyBtn.hidden = self.leveImgV.hidden = self.userIdLb.hidden = YES;
        self.noLoginLb.hidden = NO;
    }else{
        self.userIdcopyBtn.hidden = self.leveImgV.hidden  = self.userIdLb.hidden = NO;
        self.noLoginLb.hidden = YES;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    
}


-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}


#pragma mark - 头部

-(void)configHeadView{
    
    
    self.tableHeadView = [[UIView alloc] init];
    [self.view addSubview:self.tableHeadView];
    self.tableHeadView.backgroundColor = kBgColor;
    [self.tableHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(@(ScaleW(300) + Height_StatusBar + (self.showType ? ScaleW(64) : 0)));
    }];
    _topImgView=[UIImageView new];
    _topImgView.image = [UIImage imageNamed:@"我的-bg"];
    _topImgView.userInteractionEnabled = YES;
    [self.tableHeadView addSubview:_topImgView];
    [_topImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(220) + Height_StatusBar));
    }];
    
    
    
    
    self.headerImageV = [UIImageView new];
    [self.tableHeadView addSubview:self.headerImageV];
    self.headerImageV.layer.cornerRadius = ScaleW(25);
    self.headerImageV.layer.masksToBounds = YES;
    self.headerImageV.image = MyImage(@"我的-头像");
    [self.headerImageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableHeadView.mas_left).offset(ScaleW(15));
        make.width.height.mas_equalTo(ScaleW(50));
        make.top.equalTo(@(Height_NavBar + 10));
    }];
    
    self.loginView = [UIView new];
    [self.tableHeadView addSubview:self.loginView];
    [self.loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(30)));
        make.bottom.equalTo(@(ScaleW(-35)));
        make.height.equalTo(@(ScaleW(45)));
    }];
    UILabel *login = [UILabel createWithText:SSKJLanguage(@"未登录") textColor:kWhiteColor font:kBoldFont(21)];
    [self.loginView addSubview:login];
    [login mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScaleW(10));
        make.top.mas_equalTo(self.headerImageV);
    }];
    self.userNameLabel = login;
    login.userInteractionEnabled = YES;
    self.headerImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction)];
    [login addGestureRecognizer:tap];
    
    UIButton *loginBtn = [UIButton new];
    [self.tableHeadView addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(loginAction) forControlEvents:UIControlEventTouchUpInside];
    [loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(login).insets(UIEdgeInsetsZero);
    }];
    [self.headerImageV addGestureRecognizer:tap];
    
    
    
    self.leveImgV = [UIImageView new];
    self.leveImgV.hidden = YES;
    self.leveImgV.image = MyImage(@"我的-等级-L0");
    [self.tableHeadView addSubview:self.leveImgV];
    [self.leveImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headerImageV.mas_right).offset(ScaleW(5));
        make.bottom.mas_equalTo(self.headerImageV);
//        make.width.mas_equalTo(ScaleW(44));
        make.width.mas_equalTo(ScaleW(0));
        make.height.mas_equalTo(ScaleW(19));
    }];
    
    
    
    
    
    
    UILabel *ti = [UILabel createWithText:SSKJLanguage(@"-") textColor:[[UIColor whiteColor] colorWithAlphaComponent:0.7] font:kFont(11)];
    [self.tableHeadView addSubview:ti];
    self.userIdLb = ti;
    self.userIdLb.text = @"ID : --";
    [ti mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leveImgV.mas_right).offset(ScaleW(5));
        make.centerY.mas_equalTo(self.leveImgV);
    }];
    
    self.noLoginLb = [UILabel new];
    [self.tableHeadView addSubview:self.noLoginLb];
    self.noLoginLb.textColor = kWhiteColor;
    self.noLoginLb.font = systemFont(12);
    self.noLoginLb.text = SSKJLocalized(@"立即登录/注册", nil);
    self.noLoginLb.textAlignment = NSTextAlignmentLeft;
    [self.noLoginLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leveImgV.mas_left).offset(ScaleW(5));
        make.centerY.mas_equalTo(self.leveImgV);
    }];

    
    
    
    self.settingBtn = [UIButton createWithTitle:@"" titleColor:nil font:nil target:self action:@selector(settingBtnClick)];
    [self.settingBtn setImage:MyImage(@"我的-设置") forState:UIControlStateNormal];
    [self.tableHeadView addSubview:self.settingBtn];
    [self.settingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.tableHeadView.mas_right).offset(ScaleW(-15));
        make.centerY.mas_equalTo(login);
    }];
    UIButton *bgBtn = [UIButton createWithTitle:@"" titleColor:nil font:nil target:self action:@selector(loginAction)];
    [self.loginView addSubview:bgBtn];
    [bgBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@0);
    }];

    
    
    //复制按钮 复制到剪切板
    UIButton *copyBnt = [UIButton new];
    [self.tableHeadView addSubview:copyBnt];
    
    [copyBnt setImage:MyImage(@"我的-复制id") forState:UIControlStateNormal];
    [copyBnt addTarget:self action:@selector(copyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [copyBnt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.userIdLb.mas_right);
        make.centerY.mas_equalTo(self.userIdLb);
        make.width.height.mas_equalTo(ScaleW(25));
    }];
    self.userIdcopyBtn = copyBnt;
   


    
    
    self.topItemsView = [UIView new];
    [self.tableHeadView addSubview:self.topItemsView];
    self.topItemsView.backgroundColor = [UIColor whiteColor];
    self.topItemsView.layer.cornerRadius = ScaleW(10);
    self.topItemsView.layer.masksToBounds = NO;
    [self.topItemsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableHeadView).offset(ScaleW(15));
        make.right.mas_equalTo(self.tableHeadView).offset(ScaleW(-15));
        make.top.mas_equalTo(self.headerImageV.mas_bottom).offset(ScaleW(30));
        make.height.mas_equalTo(ScaleW(143));
    }];
    
    UIButton *saftyBtn = [UIButton createWithTitle:nil titleColor:nil font:nil target:self action:@selector(topItemsBtnClick:)];
    [saftyBtn setImage:MyImage(@"我的-安全中心") forState:UIControlStateNormal];
    
    saftyBtn.tag = 99;
    UIButton *yaoqingBtn = [UIButton createWithTitle:nil titleColor:nil font:nil target:self action:@selector(topItemsBtnClick:)];
    [yaoqingBtn setImage:MyImage(@"我的-我的奖励") forState:UIControlStateNormal];
    yaoqingBtn.tag = 100;
    UIButton *userInfoBtn = [UIButton createWithTitle:nil titleColor:nil font:nil target:self action:@selector(topItemsBtnClick:)];
    [userInfoBtn setImage:MyImage(@"我的-推广邀请") forState:UIControlStateNormal];
    userInfoBtn.tag = 101;
    
    UILabel *saftyLb = [UILabel createWithText:SSKJLocalized(@"安全中心", nil) textColor:kTitleColor font:kBoldFont(13)];
    UILabel *yaoqingLb = [UILabel createWithText:SSKJLocalized(@"邀请返佣", nil) textColor:kTitleColor font:kBoldFont(13)];
    UILabel *userinfoLb = [UILabel createWithText:SSKJLocalized(@"身份认证", nil) textColor:kTitleColor font:kBoldFont(13)];
    
    [self.topItemsView addSubview:saftyBtn];
    [self.topItemsView addSubview:yaoqingBtn];
    [self.topItemsView addSubview:userInfoBtn];
    [self.topItemsView addSubview:saftyLb];
    [self.topItemsView addSubview:yaoqingLb];
    [self.topItemsView addSubview:userinfoLb];
    
    [saftyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topItemsView.mas_left).offset(ScaleW(25));
        make.top.mas_equalTo(self.topItemsView.mas_top).offset(ScaleW(19));
    }];
    
    [yaoqingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topItemsView);
        make.top.mas_equalTo(self.topItemsView.mas_top).offset(ScaleW(19));
    }];
    
    [userInfoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topItemsView.mas_right).offset(ScaleW(-25));
        make.top.mas_equalTo(self.topItemsView.mas_top).offset(ScaleW(19));
    }];
    
    [saftyLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.topItemsView.mas_bottom).offset(ScaleW(-19));
        make.centerX.mas_equalTo(saftyBtn);
    }];
    [yaoqingLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.topItemsView.mas_bottom).offset(ScaleW(-19));
        make.centerX.mas_equalTo(yaoqingBtn);
    }];
    [userinfoLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.topItemsView.mas_bottom).offset(ScaleW(-19));
        make.centerX.mas_equalTo(userInfoBtn);
    }];
    
    
    
    UIButton *timeHyBtn = [UIButton new];
    [self.tableHeadView addSubview:timeHyBtn];
    
    
    UIImage *img = MyImage(SSKJLocalized(@"kjmb", nil));
   
    
    [timeHyBtn setBackgroundImage:img forState:UIControlStateNormal];
    [timeHyBtn addTarget:self action:@selector(timeHyBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [timeHyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tableHeadView.mas_left).offset(ScaleW(15));
        make.right.mas_equalTo(self.tableHeadView.mas_right).offset(ScaleW(-15));
        make.top.mas_equalTo(self.topItemsView.mas_bottom).offset(ScaleW(20));
        make.height.mas_equalTo(ScaleW(64));
    }];
    self.topItemsView.backgroundColor = kSubBgColor;
    self.topItemsView.layer.cornerRadius = ScaleW(10);
    self.topItemsView.layer.shadowColor = kTitleColor.CGColor;
    self.topItemsView.layer.shadowOffset = CGSizeMake(0, 0);
    self.topItemsView.layer.shadowRadius = ScaleW(10);
    self.topItemsView.layer.shadowOpacity = 0.2;
    
    timeHyBtn.hidden = !self.showType;
    

}

//复制到剪切板
- (void) copyBtnClick{
    if (self.userIdLb.text.length != 0) {
        UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
        pasteboard.string = [SSKJ_User_Tool sharedUserTool].userInfoModel.account;
        [MBProgressHUD showError:SSKJLocalized(@"复制成功", nil)];
    }
}

- (void) timeHyBtnClick{
    
    if (!kLogin) {
        [self presentLoginController];
        return;
    }
    
    Market_KeyBuyCoin_VC *vc = [[Market_KeyBuyCoin_VC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
//    self.tabBarController.selectedIndex = 2;
}
- (void) topItemsBtnClick:(UIButton *)sender{
    NSInteger index = sender.tag - 99;
    NSLog(@"%ld", (long)index);
    if (!kLogin) {
        [self presentLoginController];
        return;
    }
    if (index == 0) {
        
        Mine_SafeCenter_ViewController *safeCenterVC = [[Mine_SafeCenter_ViewController alloc] init];
        [self.navigationController pushViewController:safeCenterVC animated:YES];
    }else if (index == 1){
        My_Generalize_RootViewController *protocol = [[My_Generalize_RootViewController alloc]init];
        [self.navigationController pushViewController:protocol animated:YES];
    }else{
        
        NSInteger status = [SSKJ_User_Tool sharedUserTool].userInfoModel.authentication.integerValue;
        if (status == 0 || status == 1)
        {
             Mine_PrimaryCertificate_ViewController *vc = [[Mine_PrimaryCertificate_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else if (status == 3 || status == 4)
        {
            Mine_CertificationState_ViewController *vc = [[Mine_CertificationState_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            [MBProgressHUD showError:SSKJLocalized(@"您的身份认证正在审核，请耐心等待！", nil)];
        }
        
    }
    
}
//设置
- (void) settingBtnClick{
    [self settingEvent];
}
- (void)loginAction{
    if (!kLogin) {
        [self presentLoginController];
    }
}

#pragma mark - 设置
- (void)settingEvent {
    Mine_Setting_ViewController *vc = [[Mine_Setting_ViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - 地址管理

- (void)goAddress{
    if (!kLogin) {
        [self presentLoginController];
        return;
    }
    Mine_AddressManager_ViewController *vc = [[Mine_AddressManager_ViewController alloc]init];    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 联系客服
- (void)contactService{
    
    [self requestEmail];
}

#pragma mark - 登录注册
-(void)userNameTap{
    [self presentLoginController];
}


#pragma mark 请求用户信息
- (void)loadUserInfo
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        if (network_Model.status.integerValue == SUCCESSED)
        {
                SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_Model.data];
                [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
                [weakSelf setUSerModel:userModel];
                
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}



#pragma mark - 联系我们（获取客服邮箱）

-(void)requestEmail
{
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_TouchMe_URL RequestType:RequestTypeGet Parameters:@{@"key":@"contactemail"} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == SUCCESSED) {
            NSString *email = netModel.data[@"content"];
            if (!email.length) {
                           return;
                       }
            LoginAlertView *Show=[[[LoginAlertView alloc]init] showLogInState:email cancle:@"取消" sure:@"复制"];
            
            Show.sureCallback = ^{
                if (!email.length) {
                    return;
                }
                
                [MBProgressHUD showSuccess:SSKJLocalized(@"复制成功", nil)];
                UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
                pasteboard.string = email;
            };
            
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];
}




#pragma mark - 设置显示item
-(void)setupItems
{

        NSArray *itemTielsArray = @[
            @[SSKJLanguage(@"提币地址"),@"我的-提币地址"],
            @[SSKJLanguage(@"联系客服"),@"我的-联系客服"],
             @[SSKJLanguage(@"关于我们"),@"我的-关于我们"],

                                    ];
        for (NSArray *item in itemTielsArray)
        {
            Mine_Item_Model *model = [[Mine_Item_Model alloc]init];
            [model setTitle:[item firstObject]];
            [model setIcon:[item lastObject]];
            [self.itemArray addObject:model];
        }
}

-(NSMutableArray <Mine_Item_Model*>*)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

#pragma mark - collectiondelete

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    Mine_Item_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    Mine_Item_Model *model = self.itemArray[indexPath.row];
    cell.titleLabel.text = model.title;
    cell.iconImageView.image = [UIImage imageNamed:model.icon];
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    Mine_Item_Model *model = self.itemArray[indexPath.row];
    NSString *title = model.title;
    
   if ([title isEqualToString: SSKJLanguage(@"提币地址")]) {
        [self goAddress];
    } else if ([title isEqualToString: SSKJLanguage(@"关于我们")]) {
        Lion_AboutUsVC *protocol = [[Lion_AboutUsVC alloc]init];
        [self.navigationController pushViewController:protocol animated:YES];
    }else if ([title isEqualToString: SSKJLanguage(@"联系客服")]) {
        [self contactService];
    }
    
    
}

//9583cb24d2adeb1c89361cef5d1f9c0b90f05e82

#pragma mark - 更新用户信息
-(void)setUSerModel:(SSKJ_UserInfo_Model*)userModel{
//    self.userNameLabel.text = userModel.accountSafeStr;
    
    if (userModel.phone.length != 0) {
        self.userNameLabel.text = [WLTools hidePhoneMiddleNumberWithMobile:userModel.phone];
    }else{
        self.userNameLabel.text = [WLTools hideEmailWithEmail:userModel.email];
    }
//    NSString *imageName = [NSString stringWithFormat:@"我的-等级-L%@",userModel.level];
//    self.leveImgV.image = MyImage(imageName);//@"ID : --"
    self.userIdLb.text = [NSString stringWithFormat:@"ID : %@", userModel.account ? userModel.account : @"--"];
    [self setupAsset];
    
    
    

}

- (void)usdtShowAction{
    self.show.selected = !self.show.selected;
    [self setupAsset];
}


- (void)setupAsset{
    if (self.show.isSelected) {
        self.userUsdtLabel.text = @"****";
        self.moneyLabel.text = @"****";
    }else{
        self.userUsdtLabel.text = [SSTool disposePname:@"usdt" price:[SSKJ_User_Tool sharedUserTool].userInfoModel.assets.balance];
        
        self.moneyLabel.text = [NSString stringWithFormat:@"≈%@CNY", [SSTool disposePname:@"cny" price:[SSKJ_User_Tool sharedUserTool].userInfoModel.assets.rmb]];

    }
}

@end
