//
//  Heyue_CengJiao_Order_VC.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/8/3.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "Heyue_CengJiao_Order_VC.h"

#import "Heyue_ChengJiao_Order_Cell.h"

#import "Heyue_Order_ChengjiaoModel.h"
#import "Heyue_Share_ViewController.h"

#import "SSKJ_NoDataView.h"
#define kPageSize @"15"

static NSString *ChengJiaoOrderID = @"ChengJiaoOrderID";

@interface Heyue_CengJiao_Order_VC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView * tableView;

@property (nonatomic,strong) NSMutableArray * dataSource;

@property (nonatomic, assign) NSInteger page;

@end

@implementation Heyue_CengJiao_Order_VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.page = 1;
    
    [self tableView];
    
    [self requestChengJiaoOrder_URL];
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kBgColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)){
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [_tableView registerClass:[Heyue_ChengJiao_Order_Cell class] forCellReuseIdentifier:ChengJiaoOrderID];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@(ScaleW(5)));
            make.left.bottom.right.equalTo(@(ScaleW(0)));
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

#pragma mark - 上拉、下拉

-(void)headerRefresh{
    self.page = 1;
    [self requestChengJiaoOrder_URL];
}


-(void)footerRefresh{
    self.page ++;
    [self requestChengJiaoOrder_URL];
}

- (void)beginrefreashData{
    [self headerRefresh];
}

-(void)endRefresh{
    if (self.tableView.mj_header.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_header endRefreshing];
    }
    
    if (self.tableView.mj_footer.state == MJRefreshStateRefreshing) {
        [self.tableView.mj_footer endRefreshing];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return .1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(235);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    Heyue_ChengJiao_Order_Cell *cell = [tableView dequeueReusableCellWithIdentifier:ChengJiaoOrderID forIndexPath:indexPath];
    
    cell.bottomlineView.hidden = NO;
    if (indexPath.row == self.dataSource.count - 1) {
         cell.bottomlineView.hidden = YES;
    }
    cell.chengJiaoModel = self.dataSource[indexPath.row];
    WS(weakSelf);
    cell.shareBlock = ^(Heyue_Order_ChengjiaoModel * _Nonnull chengJiaoModel) {
        [weakSelf shareWithModel:chengJiaoModel];
    };
    
    return cell;
}


-(void)shareWithModel:(Heyue_Order_ChengjiaoModel *)chengjiaoModel
{
    Heyue_Share_ViewController *vc = [[Heyue_Share_ViewController alloc]init];
    vc.chengjiaoModel = chengjiaoModel;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark -- 网络请求 --
- (void)requestChengJiaoOrder_URL{
    MBProgressHUD *hud;
    if (self.dataSource.count < 1) {
     hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }else{
        hud = nil;
    }
    
    
    
    NSDictionary *params = @{
                             @"page":@(self.page),
                             };
    
    //Heyue_Chengjiao_Api
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:URL_HEYUE_History_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        if (netModel.status.integerValue == 200) {
            if ([netModel.data[@"data"] isKindOfClass:[NSArray class]])
            {
                NSArray *array = [Heyue_Order_ChengjiaoModel mj_objectArrayWithKeyValuesArray:netModel.data[@"data"]];
                
                
                
                if (array.count != kPageSize.integerValue)
                {
                    self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                }
                else
                {
                    self.tableView.mj_footer.state = MJRefreshStateIdle;
                }
                
                if (self.page == 1) {
                    [self.dataSource removeAllObjects];
                }
                [self.dataSource addObjectsFromArray:array];
            }
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
        [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:1.f];
        
        [self.tableView reloadData];
        [self endRefresh];
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        [self endRefresh];

    }];
}

- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
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
