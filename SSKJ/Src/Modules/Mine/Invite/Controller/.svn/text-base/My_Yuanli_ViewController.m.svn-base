//
//  My_Yuanli_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_Yuanli_ViewController.h"
#import "My_Yuanli_Cell.h"
#import "My_Yuanli_Model.h"
#import "My_Yuanli_HeaderView.h"

#define kPage_Size @"10"

@interface My_Yuanli_ViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) My_Yuanli_HeaderView *headerView;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation My_Yuanli_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = SSKJLocalized(@"佣金明细", nil);
    
    self.page = 1;
    
    [self setUI];
    
    [self.tableView.mj_header beginRefreshing];
    
}


-(NSArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

-(My_Yuanli_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[My_Yuanli_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
    }
    return _headerView;
}

#pragma mark - 上拉、下拉

-(void)headerRefresh
{
    self.page = 1;
    [self requestYuanliList];
}


-(void)footerRefresh
{
    [self requestYuanliList];
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

#pragma mark - ui
-(void)setUI
{
    self.view.backgroundColor=kBgColor;
    
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(10)) style:UITableViewStylePlain];
        _tableView.backgroundColor = kSubBgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[My_Yuanli_Cell class] forCellReuseIdentifier:NSStringFromClass([self class])];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        
    }
    return _tableView;
}



#pragma mark - UITableViewDelegate UITableViewDatsSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_Yuanli_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    My_Yuanli_Model *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - 网络请求

-(void)requestYuanliList
{
//    //只获取USDT返佣记录
//    NSDictionary *params = @{@"stockUserId":kUserID,
//                             @"stockCode":@"USDT",
//                             @"pageNumber":@(self.page),
//                             @"type":@"15",
//                             @"pageSize":kPage_Size,};
//    
//    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    WS(weakSelf);
//    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_CommissionInfo_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
//        if ([network_model.status integerValue] == SUCCESSED) {
//           [weakSelf handleYuanliDataWith:network_model];
//        }else{
//            [MBProgressHUD showError:network_model.msg];
//        }
//        [weakSelf endRefresh];
//    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
//        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
//        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
//        [weakSelf endRefresh];
//    }];

}


-(void)handleYuanliDataWith:(WL_Network_Model *)net_model
{
    NSArray *array = [My_Yuanli_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"list"]];

    if (array.count != kPage_Size.integerValue)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else
    {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }

    if (self.page == 1)
    {
        [self.dataSource removeAllObjects];
    }

    [self.dataSource addObjectsFromArray:array];

    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(40)];
  
    [self.tableView reloadData];

    self.page++;

    [self endRefresh];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
