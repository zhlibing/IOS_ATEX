//
//  HeyueTime_OrderDetail_ViewController.m
//  SSKJ
//
//  Created by cy5566 on 2020/3/21.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "HeyueTime_OrderDetail_ViewController.h"
#import "NSTimer+weakTimer.h"

#import "HeyueTime_WeiTuo_Order_Cell.h"
#import "BFEXOtherTableViewCell.h"
#import "Mine_RechargeTiBiRecord_Model.h"
#import "Home_Segment_View.h"//Home_Segment_View
#import "BI_Asset_OtherRecord_Model.h"
#define kPageSize @"10"
#define CoinMarketSocket @"CoinSocket"
@interface HeyueTime_OrderDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource, ManagerSocketDelegate>
@property (nonatomic, strong) UIView *mainTitleView;
@property (nonatomic, strong) UIButton *chartBtn;
@property (nonatomic, strong) UIButton *getMoneyBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) Home_Segment_View *segmentControl;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSMutableArray *chicangArray;
@property (nonatomic, strong) NSMutableArray *chengjiaoArray;

//1 提币 2 充值 3 其他
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger currentPage;

@property (nonatomic,strong) ManagerSocket * coinSocket;//币种Socket
@property (nonatomic ,strong) NSMutableArray *coinDataSource;

@property (nonatomic ,strong) NSTimer *timer;


@end

@implementation HeyueTime_OrderDetail_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"订单明细", nil);
    [self.view addSubview:self.segmentControl];
    [self tableView];
    self.type = 1;
    self.currentPage = 1;
    
    
    UIView *lineView = [UIView new];
    lineView.backgroundColor = kLineColor;
    [self.view addSubview:lineView];
    lineView.frame = CGRectMake(0, Height_NavBar, Screen_Width, ScaleW(10));
    
    
    
    
    
    __weak typeof(self) weakself = self;
    self.timer = [NSTimer sxf_weakTimerSchedulTimerWithTimerinter:5 block:^{
        __strong typeof(weakself) strongSelf = weakself;
        [strongSelf countDown];
    } repeats:YES];

}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self requestMainCoinList:@{@"code":@"/USDT"}];
}

- (void) countDown{
    if (self.type == 1) {
        [self requestListWithIsChongzhi:YES];
    }else{
//        [self requestListWithIsChongzhi:NO];
    }
}

- (void) endTimer{
    [self.timer invalidate];
    self.timer = nil;
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self closeSocket];
    [self endTimer];
}


//打开推送
- (void)openSocket{
    
    NSMutableArray *coinCodeArr = [NSMutableArray array];
    
    for (SSKJ_Market_Index_Model *model in self.coinDataSource) {
        if (model.code) {
            [coinCodeArr addObject:model.code];
        }
    }
    
    WS(weakSelf);

    //成交
    //SocketUrl
    self.coinSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:CoinMarketSocket];
    self.coinSocket.delegate = self;
    [self.coinSocket openConnectSocketWithConnectSuccess:^{
        NSString *type = [WLTools wlDictionaryToJson:@{@"type":@"self_select_lever",@"list":coinCodeArr}];
        [weakSelf.coinSocket socketSendMsg:type];
    }];
    
    
}

//关闭推送
- (void)closeSocket{
    self.coinSocket.delegate = nil;
    [self.coinSocket closeConnectSocket];
}

#pragma mark - 推送返回的数据
//接收推送数据
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier{
    if ([identifier isEqualToString:CoinMarketSocket]) {
        NSDictionary *pushGoodsInfoDatas = nil;
        if ([data isKindOfClass:[NSString class]]){
            pushGoodsInfoDatas = [WLTools dictionaryWithJsonString:data];
        }
        else if ([data isKindOfClass:[NSDictionary class]]){
            pushGoodsInfoDatas = data;
        }
        SSKJ_Market_Index_Model *socketModel=[SSKJ_Market_Index_Model mj_objectWithKeyValues:data];
//        NSLog(@"推送数据 ----  %@", data);
        
        
        if (self.type == 1) {
            //取出对应的cell 刷新
            for (TimeHyListModel *model in self.chicangArray) {
                NSString *code = [NSString stringWithFormat:@"%@/USDT", model.stockCode];
                if ([code isEqualToString:socketModel.code]) {
                    model.socketPrice = socketModel.price;
                }
            }
            [self.tableView reloadData];
        }
    }
}

#pragma mark - 网络请求 行情

-(void)requestMainCoinList:(NSDictionary *)params
{
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BBCoinList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *network_Model=[WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (network_Model.status.integerValue == SUCCESSED)
         {
             [weakSelf handleMarketListWith:network_Model];
         }else{
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
//         [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//         [weakSelf.tableView.mj_header endRefreshing];
//         [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
     }];
}


-(void)handleMarketListWith:(WL_Network_Model *)network_model
{
    NSArray *array = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:network_model.data];
    
    
    [self.coinDataSource removeAllObjects];
    [self.coinDataSource addObjectsFromArray:array];
    [self.tableView reloadData];
    //有币种再推送
            [self openSocket];
//    if (self.coinDataSource.count > 0) {
//        [self openSocket];
//    }else{
//        [self closeSocket];
//    }
    
}



#pragma mark - method

- (void)requestListWithIsChongzhi:(BOOL)isChongzhi
{
    NSString *type = @"1";
    NSString *url  = TimeHy_Chicang_URL;//持仓
    if (!isChongzhi) {
        type = @"2";
        url =  TimeHy_Chengjiao_URL;//成交
    } else {
        self.currentPage = 1;
    }
    WS(weakSelf);
    
    NSDictionary *params = @{
                             @"pageNumber":@(self.currentPage),
                             @"pageSize":kPageSize
                             };
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];

    [[WLHttpManager shareManager] requestWithURL_HTTPCode:url RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
        [hud hideAnimated:YES];

         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
                 
                 NSArray *array = [TimeHyListModel mj_objectArrayWithKeyValuesArray:netWorkModel.data[@"list"]];

                 NSArray *totalArray;
                 if (isChongzhi) {
                     if (weakSelf.currentPage == 1) {
                         [weakSelf.chicangArray removeAllObjects];
                     }
                     //持仓只有一个数据
                     [weakSelf.chicangArray removeAllObjects];
                     if (array.count != kPageSize.integerValue) {
                         weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                     }else{
                         weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                     }
                     
                     [weakSelf.chicangArray addObjectsFromArray:array];
                     totalArray = self.chicangArray;

                 }else{
                     [self closeSocket];
                     if (weakSelf.currentPage == 1) {
                         [weakSelf.chengjiaoArray removeAllObjects];
                     }
                     if (array.count != kPageSize.integerValue) {
                         weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                     }else{
                         weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                     }
                     [weakSelf.chengjiaoArray addObjectsFromArray:array];
                     totalArray = self.chengjiaoArray;

                 }
                 
                 if (array.count != kPageSize.integerValue) {
                     weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                 }else{
                     weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                 }
                 [SSKJ_NoDataView showNoData:totalArray.count toView:weakSelf.tableView offY:0];
                 [weakSelf.tableView reloadData];
                 [weakSelf.tableView.mj_header endRefreshing];
             if (totalArray.count != 0) {
                 weakSelf.currentPage ++;
             } else {
                 //没有任何数据时，继续请求第一页数据
//                 weakSelf.currentPage = 1;
             }
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
             [self.chicangArray removeAllObjects];
             [weakSelf.tableView reloadData];
             [SSKJ_NoDataView showNoData:weakSelf.chicangArray.count toView:weakSelf.tableView offY:0];
             //            [MBProgressHUD showError:json[@"status"]];
             [weakSelf.tableView.mj_header endRefreshing];
             [weakSelf.tableView.mj_footer endRefreshing];
         }
         
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [hud hideAnimated:YES];

         [MBHUD hideHUDForView:weakSelf.view];
         [MBProgressHUD showError:SSKJLocalized(@"请求超时", nil)];
         [weakSelf endRefresh];

     }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor=kSubBgColor;
        _tableView.tableFooterView = [UIView new];

        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//            _tableView.estimatedRowHeight = 0;
//            _tableView.estimatedSectionHeaderHeight = 0;
//            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        _tableView.frame = CGRectMake(0, self.segmentControl.bottom, Screen_Width, Screen_Height - self.segmentControl.bottom);
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreashData)];
        WS(weakSelf);
        _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf refrashAddMoreData];
        }];
        
    }
    return _tableView;
}

-(void)refreashData
{
        
    self.currentPage = 1;
    switch (self.type)
    {
        case 1:
        {
            self.currentPage = 1;
            [self.chicangArray removeAllObjects];
            [self.tableView reloadData];

            [self requestListWithIsChongzhi:YES];
        }
            break;
        case 2:
        {
            self.currentPage = 1;
            [self.chengjiaoArray removeAllObjects];
            [self.tableView reloadData];
            [self requestListWithIsChongzhi:NO];
        }
            break;
        default:
            break;
    }
    
}

-(void)refrashAddMoreData
{
    switch (self.type) {
        case 1:
        {
            [self requestListWithIsChongzhi:YES];
        }
            break;
        case 2:
        {
            [self requestListWithIsChongzhi:NO];
        }
            break;
        default:
            break;
    }
}

-(void)endRefresh
{
    
    
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}

#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView.mj_header beginRefreshing];
    self.navigationController.navigationBar.hidden=NO;
    [self setNavigationBarHidden:NO];

}

#pragma mark  - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.hidden=NO;
    [self closeSocket];
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
//        UIView *view=[FactoryUI createViewWithFrame:<#(CGRect)#> Color:<#(UIColor *)#>]
//
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, Height_NavBar + ScaleW(10), ScreenWidth, ScaleW(40)) titles:@[SSKJLocalized(@"持仓", nil),SSKJLocalized(@"成交", nil)] normalColor:kSubTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        [_segmentControl setBackgroundColor:kBgColor];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            [weakSelf endRefresh];
            
            weakSelf.type = index + 1;
            [weakSelf.tableView.mj_header beginRefreshing];

            
            return YES;
        };
        
    }
    return _segmentControl;
}



-(void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScaleW(1);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor =kLineColor;
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray * array = self.chicangArray;
    switch (self.type) {
        case 1:
        {
            array = self.chicangArray;
        }
            break;
        case 2:
        {
            array = self.chengjiaoArray;
        }
            break;
        default:
            break;
    }
    return array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (_type) {
        case 1:
        {
            HeyueTime_WeiTuo_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"HeyueTime_WeiTuo_Order_Cell%ld",_type]];
            if (!cell) {
                cell =  [[HeyueTime_WeiTuo_Order_Cell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"HeyueTime_WeiTuo_Order_Cell%ld",_type]];
            }
            cell.type = 1;
            cell.listModel = self.chicangArray[indexPath.section];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
           
            break;
        case 2:
        {
            
            HeyueTime_WeiTuo_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"HeyueTime_WeiTuo_Order_Cell%ld",_type]];
           
            if (!cell) {
                cell =  [[HeyueTime_WeiTuo_Order_Cell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"HeyueTime_WeiTuo_Order_Cell%ld",_type]];
            }
            cell.type = self.type;
            cell.listModel = self.chengjiaoArray[indexPath.section];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
            return cell;
        }
            
            break;
        default:
            break;
    }
    
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.type == 1) {
        return ScaleW(128);
    }else{
        return ScaleW(156);
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate


#pragma mark - 提笔撤销

-(void)cancleTiBiWithIndex:(NSInteger)index
{
    WS(weakSelf);

    [SSKJ_Default_AlertView showWithTitle:SSKJLanguage(@"撤销提币") message:SSKJLocalized(@"是否确定撤销？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
        [weakSelf requestCancleWithIndex:index];
    }];
    

//
}


-(void)requestCancleWithIndex:(NSInteger)index
{
    Mine_RechargeTiBiRecord_Model *model = self.chengjiaoArray[index];
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    //
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_TiBiRevoke_URL RequestType:RequestTypePost Parameters:@{@"id":model.ID} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:responseObject[@"msg"]];

            [self refreashData];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSMutableArray *)chicangArray
{
    if (!_chicangArray) {
        _chicangArray = [NSMutableArray array];
    }
    return _chicangArray;
}
-(NSMutableArray *)chengjiaoArray{
    if (!_chengjiaoArray) {
        _chengjiaoArray = [NSMutableArray array];
    }
    return _chengjiaoArray;
}


- (NSMutableArray *)coinDataSource{
    if (!_coinDataSource) {
        _coinDataSource = [NSMutableArray array];
    }
    return _coinDataSource;
}



@end
