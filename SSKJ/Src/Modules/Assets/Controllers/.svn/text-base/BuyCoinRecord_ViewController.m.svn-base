//
//  BuyCoinRecord_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2020/3/23.
//  Copyright © 2020 Wang. All rights reserved.
//

#import "BuyCoinRecord_ViewController.h"

#import "BuyCoin_TableViewCell.h"


static NSString *cellID = @"BuyCoin_TableViewCell";

@interface BuyCoinRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) NSInteger page;

@property (nonatomic, strong) NSMutableArray *recordArray;
@end

@implementation BuyCoinRecord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"记录", nil);
    
    [self.view addSubview:self.tableView];
    [self headerRefresh];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setNavgationBackgroundColor:kSubBgColor alpha:1];

}

-(NSMutableArray *)recordArray
{
    if (nil == _recordArray) {
        _recordArray = [NSMutableArray arrayWithCapacity:10];
    }
    return _recordArray;
}

#pragma mark - UI

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.separatorColor = kLightLineColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //页面显示移到设置页面
        //    tableView.tableFooterView = self.footerView;
        [self.view addSubview:_tableView];
        [_tableView registerClass:[BuyCoin_TableViewCell class] forCellReuseIdentifier:cellID];
        WS(weakSelf);
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf footerRefresh];
        }];
        
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
    }
    return _tableView;
}


#pragma mark - 上拉、下拉
// 下拉刷新
-(void)headerRefresh
{
    self.page = 1;
    [self requestRecord];
}


// 上拉加载
-(void)footerRefresh
{
    [self requestRecord];
}

-(void)endRefresh
{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        self.tableView.mj_header.state = MJRefreshStateIdle;
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
}

#pragma mark - UITableViewDelegate UITalbleDataSource


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(97);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.recordArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BuyCoin_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    [cell setCellWithModel:self.recordArray[indexPath.row]];

    return cell;
}


#pragma mark - 网络请求

-(void)requestRecord
{
    
    NSDictionary *params = @{
                             @"page":@(self.page),
                             @"type":@"2"
                             };
    WS(weakSelf);
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_FastPayRecord_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [weakSelf handleListWith:netModel];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
            
}


-(void)handleListWith:(WL_Network_Model *)net_model
{
    NSArray * array = [BuyCoinRecord_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    
    if (self.page == 1) {
        [self.recordArray removeAllObjects];
    }
    
    
    if (array.count != 10) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.recordArray addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.recordArray.count toView:self.tableView offY:0];
    
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
