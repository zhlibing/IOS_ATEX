//
//  ATEX_OtherRecord_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "ATEX_OtherRecord_ViewController.h"
#import "AssetOtherRecord_Cell.h"

static NSString *cellID = @"AssetOtherRecord_Cell";
@interface ATEX_OtherRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation ATEX_OtherRecord_ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (kLogin) {
        [self headerRefresh];
    }else{
        [self.dataSource removeAllObjects];
        [self.tableView reloadData];
    }
    
}

-(NSMutableArray *)dataSource
{
    if (nil == _dataSource) {
        _dataSource = [NSMutableArray arrayWithCapacity:10];
    }
    return _dataSource;
}

-(UITableView *)tableView{
    if (!_tableView) {
        CGFloat height = ScreenHeight - Height_NavBar;
        CGFloat startY = Height_NavBar;
        if (self.isAssetMainPage) {
            height = ScreenHeight - Height_NavBar - Height_TabBar - ScaleW(295);
            startY = 0;
        }
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, startY, ScreenWidth, height) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor=kBgColor;
        [_tableView registerClass:[AssetOtherRecord_Cell class] forCellReuseIdentifier:cellID];
        _tableView.tableFooterView = [UIView new];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRefresh)];
        WS(weakSelf);
        _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        
    }
    return _tableView;
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.dataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(95);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return ScaleW(10);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    view.backgroundColor = kBgColor;
    return view;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AssetOtherRecord_Cell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    ATEX_AssetOtherRecord_IndexModel *model = self.dataSource[indexPath.section];
    [cell setCellWithModel:model];
    return cell;
}

#pragma mark - 上拉、下拉
-(void)headerRefresh
{
    if (kLogin) {
        self.page = 1;
        [self requestRecordList];
    }else{
        [self endRefresh];
    }
    
}

-(void)footerRefresh
{
    [self requestRecordList];
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

#pragma mark - 网络请求

-(void)requestRecordList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    NSDictionary *params = @{
                                @"page":@(self.page)
                            };

    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:Lion_AssetDetail_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [weakSelf handleListWithModel:netModel];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
}


-(void)handleListWithModel:(WL_Network_Model *)netModel
{
       NSArray * array = [ATEX_AssetOtherRecord_IndexModel mj_objectArrayWithKeyValuesArray:netModel.data[@"data"]];
       if (self.page == 1) {
           [self.dataSource removeAllObjects];
       }
       
       if (array.count != 10) {
           self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
       }else{
           self.tableView.mj_footer.state = MJRefreshStateIdle;
       }
       
       [self.dataSource addObjectsFromArray:array];
       
       [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:0];
       
       self.page++;
       
       [self endRefresh];
       
       [self.tableView reloadData];
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
