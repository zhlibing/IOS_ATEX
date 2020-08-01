//
//  TransferAccount_Record_Controller.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/8/7.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "TransferAccount_Record_Controller.h"

#import "HubExchangeListCell.h"


#import "TransferAccountRecordModel.h"

#import "HubExchangeCoinListModel.h"

#define kPage_Size 15
@interface TransferAccount_Record_Controller ()<UITableViewDelegate,UITableViewDataSource>
{
    
    
}


@property (nonatomic, assign) NSInteger page; //!< 当前分页
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@end

@implementation TransferAccount_Record_Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setPage:1];
    [self setUI];
    [self requestRecord];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}



#pragma mark - Getter / Setter
-(void)setUI
{
    
    if (self.type)
    {
        self.title = @"转账记录";
    }
    else
    {
        self.title = @"兑换记录";
    }
    
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]init];
        _tableView.backgroundColor = kBgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerNib:[UINib nibWithNibName:@"HubExchangeListCell" bundle:nil] forCellReuseIdentifier:@"HubExchangeListCell"];
        __weak typeof(self)weakSelf = self;
        _tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make)
         {
             make.top.right.bottom.left.equalTo(self.view);
             
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

#pragma mark 表格刷新
-(void)headerRefresh
{
    [self setPage:1];
    [self requestRecord];
}

-(void)footerRefresh
{
    [self requestRecord];
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

#pragma mark - UITableViewDelegate  UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 100;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HubExchangeListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HubExchangeListCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.type == 1)
    {
        HubExchangeCoinListModel *model = self.dataSource[indexPath.section];
        [cell refreshListCellWithParam:model];
    }
    else
    {
        TransferAccountRecordModel *model = self.dataSource[indexPath.section];
        [cell refreshListCellWithParam:model];
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}

// 设置分区头背景透明
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}

// 设置分区尾背景透明
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    if ([view isMemberOfClass:[UITableViewHeaderFooterView class]]) {
        ((UITableViewHeaderFooterView *)view).backgroundView.backgroundColor = [UIColor clearColor];
    }
}



#pragma mark - 网络请求 请求转账记录
-(void)requestRecord
{
    NSDictionary *parameters = @{@"id":kUserID,
                        @"pageNumber":[NSString stringWithFormat:@"%zd",self.page],
                        @"pageSize":@"10"};
    
    [MBHUD showHUDAddedTo:self.view];
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_ChangeRecord_URL RequestType:RequestTypeGet Parameters:parameters Success:^(NSInteger statusCode, id responseObject)
     {
        
         [MBHUD hideHUDForView:weakSelf.view];
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             switch (self.page)
             {
                 case 1:
                 {
                     [self.dataSource removeAllObjects];
                 }
                     break;
             }
             
             NSArray *itemArray = [netWorkModel.data objectForKey:@"list"];
             [weakSelf analyItemArray:itemArray];
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
             [weakSelf analyItemArray:nil];
         }
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
    {
        [MBHUD hideHUDForView:weakSelf.view];
        [MBHUD showError:SSKJLocalized(@"网络异常", nil)];
        [weakSelf analyItemArray:nil];
         
     }];
}




#pragma mark 解析数据
-(void)analyItemArray:(NSArray*)array
{
    
    for (NSDictionary *object in array)
    {
     
        HubExchangeCoinListModel *model = [HubExchangeCoinListModel mj_objectWithKeyValues:object];
        [self.dataSource addObject:model];
    }
    
    
    if (array.count != kPage_Size)
    {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }
    else
    {
        self.page++;
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
    [self.tableView reloadData];
}





@end
