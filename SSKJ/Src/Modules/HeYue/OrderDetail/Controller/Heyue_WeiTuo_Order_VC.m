//
//  Heyue_WeiTuo_Order_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/3.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_WeiTuo_Order_VC.h"

#import "Heyue_WeiTuo_Order_Cell.h"

#import "HeYue_CheDan_AlertView.h"//撤单弹框

#import "Heyue_OrderDdetail_Model.h"

#import "SSKJ_NoDataView.h"
#define kPageSize @"50"

static NSString *WeiTuoOrderID = @"WeiTuoOrderID";

@interface Heyue_WeiTuo_Order_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic, strong) HeYue_CheDan_AlertView *chedanAlertView;
@property (nonatomic, assign) NSInteger page;



@end

@implementation Heyue_WeiTuo_Order_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = kBgColor;
    [self tableView];
    
    self.page = 1;

    [self requestWeiTuoOrder_URL];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}



-(void)setItemArry:(NSArray*)array
{
    [self.dataSource setArray:array];
    [self.tableView reloadData];
}







- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kSubBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[Heyue_WeiTuo_Order_Cell class] forCellReuseIdentifier:WeiTuoOrderID];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make)
        {
            make.top.left.bottom.right.equalTo(@(ScaleW(0)));
        }];
        WS(weakSelf);
        
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
    }
    return _tableView;
}

- (void)headerRefresh
{
    self.page = 1;
    [self requestWeiTuoOrder_URL];
}

- (void)footerRefresh
{
    [self requestWeiTuoOrder_URL];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(205);
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Heyue_WeiTuo_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:WeiTuoOrderID forIndexPath:indexPath];
    WS(weakSelf);
    
    cell.bottomGrayView.hidden = NO;
    if (indexPath.row == self.dataSource.count - 1)
    {
        cell.bottomGrayView.hidden = YES;
    }
    
    //撤单
    cell.HeyueCheDanBlock = ^{
        [weakSelf.chedanAlertView initDataWithWeituoModel:weakSelf.dataSource[indexPath.row]];
        [weakSelf.chedanAlertView showAlertView];
    };
    cell.weituoModel = self.dataSource[indexPath.row];
    return cell;
}

#pragma mark -- 网络请求 --
- (void)requestWeiTuoOrder_URL
{

    WS(weakSelf);
    NSDictionary *params = @{
                             @"data_type":@"2",
                             @"page":@(self.page),
                             };
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_List_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200)
        {

            [weakSelf handleExchangeListWithModel:netModel];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
        
        
        [self endRefresh];

    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [self endRefresh];
    }];
}

-(void)handleExchangeListWithModel:(WL_Network_Model *)net_model
{
    NSMutableArray *array = [Heyue_OrderDdetail_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    
    if (self.page == 1)
    {
        [self.dataSource removeAllObjects];
    }
    
    if (array.count != kPageSize.integerValue)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else
    {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    
    [self.tableView reloadData];
    
    self.page++;
    
    [self endRefresh];
    
}

-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing)
    {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing)
    {
        [self.tableView.mj_footer endRefreshing];
    }
}
#pragma mark -- 委托撤单 --
- (void)request_CheDan_URL:(Heyue_OrderDdetail_Model *)model{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"order_id":model.ID
                             };
    
    //Heyue_Chedan_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_RevokeOrder_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200) {
            [self headerRefresh];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
    }];
}

#pragma mark -- 提示弹框  懒加载 --
#pragma mark - 撤单弹框 --
- (HeYue_CheDan_AlertView *)chedanAlertView
{
    if (_chedanAlertView == nil)
    {
        _chedanAlertView = [[HeYue_CheDan_AlertView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        WS(weakSelf);
        _chedanAlertView.CheDanBlock = ^(Heyue_OrderDdetail_Model * _Nonnull weituoModel) {
            [weakSelf request_CheDan_URL:weituoModel];
        };
    }
    return _chedanAlertView;
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


@end
