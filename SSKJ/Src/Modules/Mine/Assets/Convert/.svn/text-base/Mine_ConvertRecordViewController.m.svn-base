//
//  Mine_ConvertRecordViewController.m
//  SSKJ
//
//  Created by zpz on 2019/12/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Mine_ConvertRecordViewController.h"
#import "Mine_ConvertRecordTableViewCell.h"
@interface Mine_ConvertRecordViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong)UITableView *tableView;
@property(nonatomic, strong)NSMutableArray *array;
@property (nonatomic, assign) NSInteger page;

@end

@implementation Mine_ConvertRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLanguage(@"兑换明细");
    
    [self setupTableView];
    
    [self headerRefresh];
}

- (void)requestInfo{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSDictionary *params = @{
        @"pageNumber":@(_page),
        @"pageSize":@kPage_size,
    };
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_Mine_ConvertRecord RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        [self endRefresh];
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkModel.status.integerValue == SUCCESSED ) {
            [self handleListWith:netWorkModel];
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        [self endRefresh];
        [MBProgressHUD showError:SSKJLanguage(@"网络异常")];
        
    }];
}

-(void)handleListWith:(WL_Network_Model *)net_model
{
    NSArray *array = net_model.data[@"list"];
    
    if (self.page == 1) {
        [self.array removeAllObjects];
    }
    
    
    if (array.count != kPage_size) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.array addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.array.count toView:self.tableView offY:ScaleW(10)];
    
    self.page++;
    
    [self.tableView reloadData];
}

- (NSMutableArray *)array{
    if (!_array) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)setupTableView{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _tableView.backgroundColor = kSubBgColor;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [UIView new];
    [_tableView registerClass:[Mine_ConvertRecordTableViewCell class] forCellReuseIdentifier:@"help"];
    
    if (@available(iOS 11.0, *)){
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(@0);
        make.top.equalTo(@(Height_NavBar));
    }];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    WS(weakSelf);
    
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf headerRefresh];
    }];
    
    
    
    _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        [weakSelf footerRefresh];
    }];
    

    _tableView.tableHeaderView = [self getLineView];
    
}


- (void)headerRefresh
{
    self.page = 1;
    
    [self requestInfo];
    
}

-(void)footerRefresh
{
    [self requestInfo];
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

#pragma mark - tableView delegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Mine_ConvertRecordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"help" forIndexPath:indexPath];
    NSDictionary *dic = self.array[indexPath.row];
    
    cell.titleLabel.text = dic[@"describes"];
    cell.numLabel.text = [NSString stringWithFormat:@"%@%@", [SSTool disposePname:@"8" price:dic[@"fromNum"]], dic[@"fromCode"]];
    cell.toNumLabel.text = [NSString stringWithFormat:@"%@%@", [SSTool disposePname:@"8" price:dic[@"toNum"]], dic[@"toCode"]];;
    cell.timeLabel.text = dic[@"createTime"];
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(124);
}

@end
