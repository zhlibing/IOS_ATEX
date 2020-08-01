//
//  My_PromoteDetail_ViewController.m
//  ZYW_MIT
//
//  Created by Yaolizhi on 2019/11/13.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_PromoteDetail_ViewController.h"


#import "My_PromoteDetail_Cell.h"
#import "My_PromoteDetail_Model.h"
#import "My_Friend_HeaderView.h"
#import "SSKJ_TableView.h"

#define kPage_Size @"10"



@interface My_PromoteDetail_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) My_Friend_HeaderView *headerView;

@property (nonatomic, strong) SSKJ_TableView *tableView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) My_PromoteDetail_Model *detailModel;
@end

@implementation My_PromoteDetail_ViewController

#pragma mark - LifeCycle Method
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.title = SSKJLocalized(@"我的团队", nil);
    self.page = 1;
    [self setUI];
    [self.tableView.mj_header beginRefreshing];
}


#pragma mark - UI
-(void)setUI
{
    [self.view addSubview:self.tableView];
}

-(My_Friend_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[My_Friend_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(40))];
    }
    return _headerView;
}

-(SSKJ_TableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(ScaleW(10) + Height_NavBar, 0, 0, 0));
            
        }];
        
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[My_PromoteDetail_Cell class] forCellReuseIdentifier:@"promoteDetailCell"];
        
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


-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

#pragma mark - 上拉、下拉

// 下拉刷新
-(void)headerRefresh
{
    self.page = 1;
    [self requestData];
}


// 上拉加载
-(void)footerRefresh
{
    [self requestData];
}


#pragma mark - UITableViewDelegate UITalbleDataSource

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(60);
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_PromoteDetail_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"promoteDetailCell"];
    My_Promote_Index_Model *model = self.dataSource[indexPath.row];
    [cell setCellWithModel:model];
    return cell;
}

#pragma mark - 网络请求
// 请求推广明细列表
-(void)requestData
{
    NSDictionary *params = @{
                             @"page":@(self.page),
                             };

    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_MyCuMstom_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        
        
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED)
        {
            [weakSelf handleDataWithNetModel:network_model];
        }else{
            [MBProgressHUD showError:network_model.msg];
        }
        [weakSelf.tableView endRefresh];
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.tableView endRefresh];
    }];

}


-(void)handleDataWithNetModel:(WL_Network_Model *)net_model
{

    if (self.page == 1)
    {
        [self.dataSource removeAllObjects];
    }
    NSArray *listArray = [net_model.data objectForKey:@"data"];
    
    for (NSDictionary *object in listArray)
    {
        My_Promote_Index_Model *model = [My_Promote_Index_Model mj_objectWithKeyValues:object];
        [self.dataSource addObject:model];
    }
    
    
    if (self.dataSource.count != kPage_Size.integerValue)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }


    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:ScaleW(30)];
    [self.tableView reloadData];
    self.page++;

    [self.tableView endRefresh];

}


@end
