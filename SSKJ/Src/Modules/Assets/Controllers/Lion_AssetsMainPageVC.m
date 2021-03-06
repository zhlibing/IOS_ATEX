//
//  Lion_AssetsPageVC.m
//  SSKJ
//
//  Created by mac on 2020/3/12.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Lion_AssetsMainPageVC.h"
#import "Lion_AssetsHeaderView.h"
#import "Mine_Recharge_ViewController.h"
#import "ATEX_AssetRecord_ViewController.h"
#import "Lion_Assets_new_Model.h"
#import "Mine_SafeCenter_ViewController.h"
#import "Mine_Extract_ViewController.h"
#import "ATEX_AssetDetail_IndexModel.h"
#import "ATEX_ChargeRecord_ViewController.h"
#import "ATEX_ExtractRecord_ViewController.h"
#import "ATEX_OtherRecord_ViewController.h"

#import "Home_Segment_View.h"

@interface Lion_AssetsMainPageVC ()
@property (nonatomic ,strong) Lion_AssetsHeaderView *tabHeader;
@property (nonatomic ,strong) SSKJ_UserInfo_Model *userModel;
@property (nonatomic, strong) Lion_Assets_new_Model *assetModel;

@property (nonatomic, strong) Home_Segment_View *segmentControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) ATEX_ChargeRecord_ViewController *chargeVc;
@property (nonatomic, strong) ATEX_ExtractRecord_ViewController *extractVc;
@property (nonatomic, strong) ATEX_OtherRecord_ViewController *otherVc;

@end

@implementation Lion_AssetsMainPageVC


- (instancetype)init
{
    self = [super init];
    if (self) {
        //推送选择的是那种合约
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(heyueType:) name:@"HEYUE_TYPE" object:nil];
    }
    return self;
}

- (void) heyueType:(NSNotification *)notifi{
    NSLog(@"---------推送的合约类型  %@", notifi.object);
    //根据不同的合约类型拉去不同数据 这里显示所有币种即可
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"资产账户", nil);
    [self.view addSubview:self.tabHeader];
    
    [self configerActions];
    
    [self.view addSubview:self.segmentControl];
        
    [self.view addSubview:self.scrollView];
        
    self.scrollView.contentOffset = CGPointMake(ScreenWidth * self.segmentControl.selectedIndex, 0);

    
    
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
        
    if (!kLogin) {
        //清空数据
        [self.tabHeader clearData];
//        self.segmentControl.hidden = self.scrollView.hidden = YES;
    }else{
//        self.segmentControl.hidden = self.scrollView.hidden = NO;
        [self loadData];
    }
    
   
}
- (void) loadData{
    if (kLogin) {
        [self loadUserInfo];
        [self requestAssetInfo];
    }
}

#pragma mark 请求用户信息
- (void)loadUserInfo
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
        
    
    WS(weakSelf);
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_UserInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        if (network_Model.status.integerValue == SUCCESSED)
        {
                SSKJ_UserInfo_Model *userModel = [SSKJ_UserInfo_Model mj_objectWithKeyValues:network_Model.data];
                [[SSKJ_User_Tool sharedUserTool] setUserInfoModel:userModel];
            weakSelf.userModel = userModel;
        }
        else
        {
            [MBProgressHUD showError:network_Model.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}


#pragma mark 请求用资产信息

- (void)requestAssetInfo{
    
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Lion_Asset_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
            
            weakSelf.assetModel = [Lion_Assets_new_Model mj_objectWithKeyValues:netWorkModel.data];
            
            weakSelf.tabHeader.model = weakSelf.assetModel;
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLanguage(@"网络异常")];

    }];
}


- (void) configerActions{
    WS(weakSelf);
    self.tabHeader.actionBlock = ^(NSInteger indexP) {

                SSKJ_BaseViewController *vc;
                if(indexP == 0){
                    //充币
                    [weakSelf rechargeClick];
                }else if (indexP == 1) {
                    //提币
                    NSLog(@"提币");
                    [weakSelf extractEvent];
                }else {
                    
                }
                if (vc) {
                    vc.modalPresentationStyle = 0;
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
    };
    
}

#pragma mark - 充币

- (void)rechargeClick{
    [self chargeEvent];
}

-(void)chargeEvent
{
    if (!kLogin)
    {
        [self presentLoginController];
        return;
    }
    
    Mine_Recharge_ViewController *chargeVc = [[Mine_Recharge_ViewController alloc]init];
    [self.navigationController pushViewController:chargeVc animated:YES];
    
}



#pragma mark - 提币
-(void)extractEvent
{
    if (!kLogin)
    {
        [self presentLoginController];
        return;
    }

    if (![self judgeFristCertificate])
    {
        return;
    }

    if (![self judgePayPassword]) {
        return;
    }
    
    
    Mine_Extract_ViewController *extractVc = [[Mine_Extract_ViewController alloc]init];
    [self.navigationController pushViewController:extractVc animated:YES];
    
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, self.tabHeader.bottom + ScaleW(10), ScreenWidth, ScaleW(40)) titles:@[SSKJLocalized(@"充币记录", nil),SSKJLocalized(@"提币记录", nil),SSKJLocalized(@"其他", nil)] normalColor:kTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        [_segmentControl setBackgroundColor:kBgColor];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            [weakSelf setIndex:index];
            weakSelf.scrollView.contentOffset = CGPointMake(ScreenWidth * index, 0);
            return YES;
        };
        
    }
    return _segmentControl;
}


- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segmentControl.bottom, ScreenWidth, ScreenHeight - self.segmentControl.bottom - Height_TabBar)];
        [self.view addSubview:_scrollView];
        if (@available(iOS 11.0, *)){
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }

        _scrollView.contentSize = CGSizeMake(ScreenWidth * 3, 0);
        _scrollView.pagingEnabled = YES;
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.backgroundColor = kBgColor;
        _scrollView.backgroundColor = [UIColor redColor];

        self.chargeVc = [[ATEX_ChargeRecord_ViewController alloc]init];
        self.chargeVc.isAssetMainPage = YES;
        [self addChildViewController:self.chargeVc];
        self.chargeVc.view.frame = CGRectMake(0, 0, ScreenWidth, self.scrollView.height);
        [_scrollView addSubview:self.chargeVc.view];
        
        self.extractVc = [[ATEX_ExtractRecord_ViewController alloc]init];
        self.extractVc.isAssetMainPage = YES;
        [self addChildViewController:self.extractVc];
        self.extractVc.view.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, self.scrollView.height);
        [_scrollView addSubview:self.extractVc.view];
        
        self.otherVc = [[ATEX_OtherRecord_ViewController alloc]init];
        self.otherVc.isAssetMainPage = YES;
        [self addChildViewController:self.otherVc];
        self.otherVc.view.frame = CGRectMake(ScreenWidth * 2, 0, ScreenWidth, self.scrollView.height);
        [_scrollView addSubview:self.otherVc.view];
        
        
    }
    return _scrollView;
}


-(void)setIndex:(NSInteger)index
{
    if (index == 0) {
        [self.chargeVc viewWillAppear:YES];
    }else if (index == 1){
        [self.extractVc viewWillAppear:YES];
    }else{
        [self.otherVc viewWillAppear:YES];
    }
}


#pragma mark - scroll delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGPoint offset = scrollView.contentOffset;
    
    if (offset.x < 0) {
        return;
    }

    self.segmentControl.selectedIndex = offset.x/ScreenWidth;
    
    [self setIndex:self.segmentControl.selectedIndex];

}
- (Lion_AssetsHeaderView *)tabHeader{
    if (!_tabHeader) {
        _tabHeader = [[Lion_AssetsHeaderView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(245))];
    }
    return _tabHeader;
}
@end
