//
//  WLLAssetsInfoViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "WLLAssetsInfoViewController.h"
#import "Mine_RechargeTiRecord_ViewController.h"
#import "WLLAssetsInfoModel.h"
#import "WLLAssetsInfoCell.h"
#import "My_Asset_HeaderView.h"
#import "Mine_Recharge_ViewController.h"
#import "Mine_Tibi_ViewController.h"
#import "My_AdvancedCertificate_ViewController.h"
#import "My_PrimaryCertificate_ViewController.h"
#import "HubExchangeViewController.h"
#import "My_Generalize_BottomView.h"
#import "My_Protocol_ViewController.h"
//#import "My_SetTPWD_ViewController.h"
#import "HeBi_Convert_ViewController.h"
#import "BI_UserInfo_Found_Model.h"




@interface WLLAssetsInfoViewController () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UILabel *totalMoneyLabel;
@property (nonatomic, strong) UILabel *unit;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, copy) NSString *wallone;
@property (nonatomic,strong) UIImageView *zhanweiImg;
@property (nonatomic, strong) My_Asset_HeaderView *headerView;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) My_Generalize_BottomView *contractView;

@end

@implementation WLLAssetsInfoViewController




#pragma mark - LifeCycle Method
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kBgColor];
    [self setupUI];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    [self setNavigationBarHidden:YES];
    
    [self requestAssetsInfo];
    [self loadTotalFound];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    
[super viewWillDisappear:animated];
    [self setNavigationBarHidden:NO];
    
}





#pragma mark - Getter / Setter
- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -Height_StatusBar, ScreenWidth, ScreenHeight+Height_StatusBar) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.separatorColor = kBgColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    //页面显示移到设置页面
//    tableView.tableFooterView = self.footerView;
    [self.view addSubview:tableView];
    [tableView registerClass:[WLLAssetsInfoCell class] forCellReuseIdentifier:@"WLLAssetsInfoCell"];
    WS(weakSelf);
    tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadTotalFound];
        [weakSelf requestAssetsInfo];
    }];
    _tableView = tableView;

    if (@available(iOS 11.0, *))
    {
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
//    _tableView.tableHeaderView = self.headerView;
    
}


-(My_Generalize_BottomView *)contractView
{
    if (nil == _contractView) {
        _contractView = [[My_Generalize_BottomView alloc]initWithFrame:CGRectMake(0, ScaleW(20), ScreenWidth, 0)];
        WS(weakSelf);
        _contractView.privateBlock = ^{
            My_Protocol_ViewController *vc = [[My_Protocol_ViewController alloc]init];
            vc.protocolType = PROTOCOLTYPEPRIVATE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _contractView.serviceBlock = ^{
            My_Protocol_ViewController *vc = [[My_Protocol_ViewController alloc]init];
            vc.protocolType = PROTOCOLTYPESERVICE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _contractView;
}

-(UIView *)footerView
{
    
    if (nil == _footerView) {
        _footerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.contractView.height + ScaleW(20))];
        [_footerView addSubview:self.contractView];
    }
    return _footerView;
}

-(My_Asset_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[My_Asset_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(200 +60)+Height_NavBar)];
        WS(weakSelf);
        _headerView.chargeBlock = ^{
            
            [weakSelf chargeEvent];
        };
        
        _headerView.extractBlock = ^{
            [weakSelf extractEvent];
        };
        
        _headerView.exchangeBlock = ^{

            [weakSelf exchangeEvent];
        };
        
        _headerView.leftBlock = ^{
            
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
        };
    }
    return _headerView;
}

- (NSMutableArray *)dataSource
{
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


#pragma mark 获取资产管理详细信息
- (void)requestAssetsInfo
{
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_CaptialFund_URL RequestType:RequestTypeGet Parameters:@{@"id":kUserID} Success:^(NSInteger statusCode, id responseObject)
    {
        
        [weakSelf.tableView.mj_header endRefreshing];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
            
            [weakSelf analysisAssetsInfo:netWorkModel.data];
            
        }
        else
        {
            [MBHUD showError:netWorkModel.msg];
        }
        
            
        }Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [weakSelf.tableView.mj_header endRefreshing];

     }];
}

-(void)analysisAssetsInfo:(NSArray*)array
{
    
    NSArray *assetArray = [WLLAssetsInfoModel mj_objectArrayWithKeyValuesArray:array];
    self.dataSource = [NSMutableArray arrayWithArray:assetArray];
    [self.tableView reloadData];

    
    [self.tableView reloadData];
    [self.tableView.mj_header endRefreshing];
    
}



#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLLAssetsInfoCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"WLLAssetsInfoCell"];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        WS(weakSelf);
        cell.detailBlock = ^(WLLAssetsInfoModel *model)
    {
            Mine_RechargeTiRecord_ViewController *getMoney = [[Mine_RechargeTiRecord_ViewController alloc]init];
            getMoney.model = model;
            [weakSelf.navigationController pushViewController:getMoney animated:YES];
        };
    WLLAssetsInfoModel *infoModel = self.dataSource[indexPath.row];
    [cell setItemObject:infoModel];
    return cell;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (115);

}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return self.headerView.height;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return self.headerView;
}

#pragma mark - 网络请求
- (void)loadTotalFound
{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"id"] = kUserID;

    
    WS(weakSelf);
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_TotalAsset_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if ([netWorkModel.status isEqualToString:@"200"])
        {
            BI_UserInfo_Found_Model *foundModel = [BI_UserInfo_Found_Model mj_objectWithKeyValues:netWorkModel.data];
            [weakSelf.headerView setFoundModel:foundModel];
        }
        else
        {
            
        }
        
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         
     }];

}



#pragma mark  点击提币
-(void)extractEvent
{
    
    if (![self judgeSecondCertificate]) {
        return;
    }

    if (![self judgePayPassword]) {
        return;
    }
    
    Mine_Tibi_ViewController *extractVc = [[Mine_Tibi_ViewController alloc]init];
    [self.navigationController pushViewController:extractVc animated:YES];
    
    [self setNavigationBarHidden:NO];
    
}


#pragma mark 兑换
-(void)exchangeEvent
{
    if (![self judgePayPassword]) {
        return;
    }
    HeBi_Convert_ViewController *exchang = [[HeBi_Convert_ViewController alloc]init];
    [self.navigationController pushViewController:exchang animated:YES];
    [self setNavigationBarHidden:NO];

}



#pragma mark 充币
-(void)chargeEvent
{
//    SSLog(@"充币");
    Mine_Recharge_ViewController *chargeVc = [[Mine_Recharge_ViewController alloc]init];
    
    if (self.dataSource.count == 0) {
        return ;
    }
    [self.navigationController pushViewController:chargeVc animated:YES];
    [self setNavigationBarHidden:NO];

}





@end
