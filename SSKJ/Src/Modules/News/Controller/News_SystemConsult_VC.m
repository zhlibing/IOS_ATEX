//
//  GoCoin_SystemConsult_VC.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/3/29.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "News_SystemConsult_VC.h"

#import "News_System_Cell.h"

#import "Home_NewsDetail_ViewController.h"

#import "Market_Index_Banner_Model.h"

#import "News_Zizun_Index_Model.h"

#import "SDCycleScrollView.h"


#define kPage_Size @"10"

@interface News_SystemConsult_VC ()<UITableViewDelegate,UITableViewDataSource,SDCycleScrollViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@property (nonatomic,strong) UIView *headerView;


@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger page;

@property(nonatomic,strong)NSMutableArray<Market_Index_Banner_Model *> *bannerArray;



@end

@implementation News_SystemConsult_VC

- (void)viewDidLoad {
    [super viewDidLoad];
            
    [self tableView];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self headerRefresh];
}

#pragma mark - 列表表格视图
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc] init];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        _tableView.backgroundColor=kSubBgColor;
        
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        
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
        
        _tableView.tableHeaderView = self.headerView;
        [self.view addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(@0);
            
            make.width.equalTo(@(ScreenWidth));
            
            make.top.equalTo(@0);
//            make.top.equalTo(@(Height_NavBar));

    
            make.bottom.equalTo(@(0));
            
        }];
        

        WS(weakSelf);

        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf headerRefresh];
        }];
        
        
        
        _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            
            [weakSelf footerRefresh];
        }];
        
    }
    
    return _tableView;
}

-(SDCycleScrollView *)bannerView
{
    if (_bannerView==nil)
    {
        NSString *img =@"banner_default";

        CGFloat width = ScreenWidth - ScaleW(28);
        _bannerView=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(ScaleW(14),ScaleW(0), width, ScaleW(196)) delegate:self placeholderImage:[UIImage imageNamed:img]];
        _bannerView.backgroundColor = [UIColor clearColor];
        _bannerView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        
        _bannerView.delegate = self;
        
        _bannerView.autoScrollTimeInterval = 3.0;
        
        _bannerView.pageControlStyle = SDCycleScrollViewPageContolStyleNone;
        
//        _bannerView.currentPageDotImage = [UIImage imageNamed:@"lunbo_selected"];
//
//        _bannerView.pageDotImage = [UIImage imageNamed:@"lunbo_normal"];
        _bannerView.layer.masksToBounds = YES;
        _bannerView.layer.cornerRadius = ScaleW(10);
    }
    
    return _bannerView;
}

- (void)headerRefresh
{
    self.page = 1;
    [self requestGetincomeUrl];
    
    [self requestGetBanner];
    
}

-(void)footerRefresh
{
    [self requestGetincomeUrl];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(110);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_System_Cell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"SystemCell%ld",(long)indexPath.row]];
    
    if (cell == nil) {
        
        cell = [[News_System_Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"SystemCell%ld",(long)indexPath.row]];
    }
    
    [cell initDataWithModel:self.dataSource[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    News_Zizun_Index_Model *model = self.dataSource[indexPath.row];
    Home_NewsDetail_ViewController *vc = [[Home_NewsDetail_ViewController alloc]init];
    vc.detailType = DetailTypeNews;
    vc.newsModel = model;
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIView *)headerView
{
    if (_headerView == nil) {
        
        _headerView.backgroundColor = kSubBgColor;
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(196))];
        [_headerView addSubview:self.bannerView];
        [self.view addSubview:_headerView];
    }
    return _headerView;
}

- (NSMutableArray *)dataSource
{
    if (_dataSource == nil) {
        
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark -- 获取系统资讯 --
- (void)requestGetincomeUrl
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSDictionary *params = @{
                             @"type":@(2),
                             @"page":@(self.page),
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_ZixunList_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netWorkModel.status.integerValue == SUCCESSED ) {
            [weakSelf handleListWith:netWorkModel];
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
            [weakSelf endRefresh];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
        [weakSelf endRefresh];

    }];
}

-(void)handleListWith:(WL_Network_Model *)net_model
{
    NSArray * array = [News_Zizun_Index_Model mj_objectArrayWithKeyValuesArray:net_model.data[@"data"]];
    
    if (self.page == 1) {
        [self.dataSource removeAllObjects];
    }
    
    
    if (array.count != kPage_Size.integerValue) {
        self.tableView.mj_footer.state = MJRefreshStateNoMoreData;
    }else{
        self.tableView.mj_footer.state = MJRefreshStateIdle;
    }
    
    [self.dataSource addObjectsFromArray:array];
    
    [SSKJ_NoDataView showNoData:self.dataSource.count toView:self.tableView offY:self.headerView.height];
    
    self.page++;
    
    [self endRefresh];

    
    [self.tableView reloadData];
    
    
}

#pragma mark -- 获取轮播图 --
- (void)requestGetBanner
{

    WS(weakSelf);
  
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:JBWallet_NewsHeader_URL RequestType:RequestTypePost Parameters:@{@"type":@"1",@"position":@"1"} Success:^(NSInteger statusCode, id responseObject)
     {
        
        WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (netWorkModel.status.integerValue == SUCCESSED )
        {
                        
            NSArray *array = [[netWorkModel.data firstObject] objectForKey:@"image"];
            NSMutableArray *itemArray = [NSMutableArray array];
            for (NSString * url in array)
            {
                Market_Index_Banner_Model *model = [[Market_Index_Banner_Model alloc]init];
                [model setImage:url];
                [itemArray addObject:model];
            }
                        
            
            [weakSelf setBannerArray:itemArray];
            
            
            
            if (weakSelf.bannerArray.count)
            {
                                
                NSMutableArray *array = [NSMutableArray array];
                for (Market_Index_Banner_Model *model in weakSelf.bannerArray)
                {
                    [array addObject:[WLTools imageURLWithURL:model.image]];
                }
                
                
                weakSelf.bannerView.imageURLStringsGroup = array;
            }
        }
        else
        {
            [MBProgressHUD showError:netWorkModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
       
    }];
}

-(NSMutableArray<Market_Index_Banner_Model *> *)bannerArray
{
    if (_bannerArray==nil)
    {
        _bannerArray=[NSMutableArray array];
    }
    
    return _bannerArray;
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
