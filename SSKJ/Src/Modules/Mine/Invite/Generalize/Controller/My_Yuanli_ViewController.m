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
#import "SSKJ_TableView.h"

#define kPage_Size @"10"

@interface My_Yuanli_ViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SSKJ_TableView *tableView;
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



#pragma mark - ui
-(void)setUI
{
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.equalTo(self.view).insets(UIEdgeInsetsMake(Height_NavBar, 0, 0, 0));
        
    }];
}

-(SSKJ_TableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[SSKJ_TableView alloc]initWitDeletage:self];
        _tableView.backgroundColor =  kBgColor;
        _tableView.tableHeaderView = self.headerView;
        [_tableView registerClass:[My_Yuanli_Cell class] forCellReuseIdentifier:NSStringFromClass([self class])];
        
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



#pragma mark - UITableViewDelegate UITableViewDatsSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(47);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    My_Yuanli_Cell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    My_Yuanli_Model *model = self.dataSource[indexPath.row];

        
    
//    cell.nameLabel.text = model.username.length > 0 ? model.username:@"--";
//    cell.contactLabel.text = [NSString stringWithFormat:@"%@USDT", model.userReturnFee];
//    cell.timeLabel.text = model.createTime;
    
    [cell setCellWithModel:model];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


#pragma mark - 网络请求

-(void)requestYuanliList
{
    //只获取USDT返佣记录

    NSDictionary *params = @{
                                @"page":@(self.page),
                            };
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_YongJinRecord_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
    {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *network_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if ([network_model.status integerValue] == SUCCESSED)
        {
           [weakSelf handleYuanliDataWith:network_model];
        }
        else
        {
            [MBProgressHUD showError:network_model.msg];
        }
        [weakSelf.tableView  endRefresh];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        [MBProgressHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf.tableView endRefresh];
    }];

}


-(void)handleYuanliDataWith:(WL_Network_Model *)net_model
{
    NSArray *array = [My_Yuanli_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];

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

    [self.tableView  endRefresh];
}


@end
