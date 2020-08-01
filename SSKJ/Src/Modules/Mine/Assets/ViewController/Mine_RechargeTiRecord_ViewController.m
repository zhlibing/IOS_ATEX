//
//  BFEXRecordViewController.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/5.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Mine_RechargeTiRecord_ViewController.h"
#import "Mine_RechargeTiRecord_TableViewCell.h"
#import "BFEXOtherTableViewCell.h"
#import "QBWShowNoDataView.h"
#import "WLLChongZhiRecordModel.h"
#import "WLLTiBiRecordModel.h"
#import "WLLAssetsInfoModel.h"
#import "Home_Segment_View.h"
#import "BI_Asset_OtherRecord_Model.h"

#define kPageSize @"15"

@interface Mine_RechargeTiRecord_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UIView *mainTitleView;
@property (nonatomic, strong) UIButton *chartBtn;
@property (nonatomic, strong) UIButton *getMoneyBtn;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) Home_Segment_View *segmentControl;


@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSMutableArray *chongzhiArray;
@property (nonatomic, strong) NSMutableArray *tibiArray;
@property (nonatomic, strong) NSMutableArray *otherArray;



@property (nonatomic, assign) NSInteger currentPage;



@end

@implementation Mine_RechargeTiRecord_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = SSKJLocalized(@"账单明细", nil);
    self.view.backgroundColor = kSubBgColor;
//    [self.view addSubview:self.segmentControl];
    [self tableView];

    self.currentPage = 1;
    
    if (self.type == 1) {
        self.title = SSKJLocalized(@"充币记录", nil);

    }else if (self.type == 2){
        self.title = SSKJLocalized(@"提币记录", nil);

    }
}
-(NSMutableArray *)chongzhiArray
{
    if (!_chongzhiArray) {
        _chongzhiArray = [NSMutableArray array];
    }
    return _chongzhiArray;
}
-(NSMutableArray *)tibiArray{
    if (!_tibiArray) {
        _tibiArray = [NSMutableArray array];
    }
    return _tibiArray;
}
-(NSMutableArray *)otherArray{
    if (!_otherArray) {
        _otherArray = [NSMutableArray array];
    }
    return _otherArray;
}
#pragma mark - method
#pragma mark 充值列表
- (void)requestListWithIsChongzhi:(BOOL)isChongzhi
{
    NSString *type = @"1";
    if (!isChongzhi) {
        type = @"2";
    }
    WS(weakSelf);
    
    NSDictionary *params = @{
                             @"id":kUserID,
                             @"type":type,
                             @"stockCode":self.model.stockCode,
                             @"pageNumber":@(self.currentPage),
                             @"pageSize":kPageSize
                             };
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_GoldEntryAndExit_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
                 
                 NSArray *array = [WLLTiBiRecordModel mj_objectArrayWithKeyValuesArray:netWorkModel.data[@"list"]];
                 
                 NSArray *totalArray;
                 if (isChongzhi) {
                     if (weakSelf.currentPage == 1) {
                         [weakSelf.chongzhiArray removeAllObjects];
                     }
                     if (array.count != kPageSize.integerValue) {
                         weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                     }else{
                         weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                     }
                     
                     [weakSelf.chongzhiArray addObjectsFromArray:array];
                     totalArray = self.chongzhiArray;

                 }else{
                     if (weakSelf.currentPage == 1) {
                         [weakSelf.tibiArray removeAllObjects];
                     }
                     if (array.count != kPageSize.integerValue) {
                         weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                     }else{
                         weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                     }
                     [weakSelf.tibiArray addObjectsFromArray:array];
                     totalArray = self.tibiArray;

                 }
                 
                 if (array.count != kPageSize.integerValue) {
                     weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                 }else{
                     weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                 }
                 
                 
                 [SSKJ_NoDataView showNoData:totalArray.count toView:weakSelf.tableView offY:0];
                 [weakSelf.tableView reloadData];
                 [weakSelf.tableView.mj_header endRefreshing];
                 weakSelf.currentPage ++;
                 
             
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
             [self.chongzhiArray removeAllObjects];
             [weakSelf.tableView reloadData];
             [SSKJ_NoDataView showNoData:weakSelf.chongzhiArray.count toView:weakSelf.tableView offY:0];
             //            [MBProgressHUD showError:json[@"status"]];
             [weakSelf.tableView.mj_header endRefreshing];
             [weakSelf.tableView.mj_footer endRefreshing];
         }
         
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf.view];
         [MBProgressHUD showError:SSKJLocalized(@"请求超时", nil)];
         [weakSelf.tableView.mj_footer endRefreshing];
         
     }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.backgroundColor=kSubBgColor;
        _tableView.tableFooterView = [UIView new];
        
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
        _tableView.frame = CGRectMake(0, Height_NavBar, Screen_Width, Screen_Height - Height_NavBar);
        _tableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreashData)];
        WS(weakSelf);
        _tableView.mj_footer=[MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf refrashAddMoreData];
        }];
        [_tableView registerClass:[Mine_RechargeTiRecord_TableViewCell class] forCellReuseIdentifier:@"cellid"];
    }
    return _tableView;
}

-(void)refreashData
{
    
    [[WLHttpManager shareManager]cancleAllTask];
    
    self.currentPage = 1;
    switch (self.type)
    {
        case 1:
        {
            self.currentPage = 1;
            [self.chongzhiArray removeAllObjects];
            [self.tableView reloadData];

            [self requestListWithIsChongzhi:YES];
        }
            break;
        case 2:
        {
            self.currentPage = 1;
            [self.tibiArray removeAllObjects];
            [self.tableView reloadData];
            [self requestListWithIsChongzhi:NO];
        }
            break;
        case 3:
        {
            self.currentPage = 1;

            [self othersApiRequst];
        }
            break;
            
        default:
            break;
    }
    
}

-(void)refrashAddMoreData
{
    switch (self.type) {
        case 1:
        {
            [self requestListWithIsChongzhi:self.type == 1];
        }
            break;
        case 2:
        {
            [self requestListWithIsChongzhi:self.type == 1];
        }
            break;
        case 3:
        {
            [self othersApiRequst];
        }
            break;
            
        default:
            break;
    }
}
-(void)othersApiRequst
{
    NSDictionary *params = @{
                             @"id":kUserID,
                             @"code":self.model.stockCode,
                             @"pageNumber":@(self.currentPage),
                             @"pageSize":kPageSize
                             };
    WS(weakSelf);
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_AssetDetailOther_URL RequestType:RequestTypeGet Parameters:params Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model * netWorkModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         if (netWorkModel.status.integerValue == SUCCESSED )
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 
                 NSArray *array = [BI_Asset_OtherRecord_Model mj_objectArrayWithKeyValuesArray:netWorkModel.data[@"list"]];
                 if (weakSelf.currentPage == 1) {
                     [weakSelf.otherArray removeAllObjects];
                 }
                 
                 [weakSelf.otherArray addObjectsFromArray:array];
                 
                 if (array.count != kPageSize.integerValue) {
                     weakSelf.tableView.mj_footer.state = MJRefreshStateNoMoreData;
                 }else{
                     weakSelf.tableView.mj_footer.state = MJRefreshStateIdle;
                 }
                 
                 [SSKJ_NoDataView showNoData:self.otherArray.count toView:weakSelf.tableView offY:0];
                 [weakSelf.tableView reloadData];
                 [weakSelf endRefresh];

                 weakSelf.currentPage ++;
                 
             });
         }
         else
         {
             [MBHUD showError:netWorkModel.msg];
             [self.chongzhiArray removeAllObjects];
             [weakSelf.tableView reloadData];
             [SSKJ_NoDataView showNoData:self.chongzhiArray.count toView:self.tableView offY:0];
             //            [MBProgressHUD showError:json[@"status"]];
             [weakSelf endRefresh];
         }
         
         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {
         [MBHUD hideHUDForView:weakSelf.view];
         [MBProgressHUD showError:SSKJLocalized(@"请求超时", nil)];
         [weakSelf.tableView.mj_footer endRefreshing];
         
     }];
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

#pragma mark - 页面即将显示
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];  
    [self.tableView.mj_header beginRefreshing];

}

#pragma mark  - 页面即将消失
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
}


-(Home_Segment_View *)segmentControl
{
    if (nil == _segmentControl) {
        
//        UIView *view=[FactoryUI createViewWithFrame:<#(CGRect)#> Color:<#(UIColor *)#>]
//        
        _segmentControl = [[Home_Segment_View alloc]initWithFrame:CGRectMake(0, Height_NavBar + ScaleW(10), ScreenWidth, ScaleW(40)) titles:@[SSKJLocalized(@"充币", nil),SSKJLocalized(@"提币", nil),SSKJLocalized(@"其他", nil)] normalColor:kSubTitleColor selectedColor:kBlueColor fontSize:ScaleW(15)];
        [_segmentControl setBackgroundColor:kBgColor];
        
        WS(weakSelf);
        _segmentControl.selectedIndexBlock = ^(NSInteger index) {
            
            
            weakSelf.type = index + 1;
            [weakSelf.tableView.mj_header beginRefreshing];

            
            return YES;
        };
        
    }
    return _segmentControl;
}



-(void)popSelf
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScaleW(10);
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectZero];
    view.backgroundColor =kSubBgColor;
    return view;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSArray * array = self.chongzhiArray;
    switch (self.type) {
        case 1:
        {
            array = self.chongzhiArray;
        }
            break;
        case 2:
        {
            array = self.tibiArray;
        }
            break;
         
        case 3:
        {
            array = self.otherArray;
        }
            break;
        default:
            break;
    }
    return array.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Mine_RechargeTiRecord_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid"];

    switch (_type) {
        case 1:
        {
            
            
            [cell setValuedataSoure:self.chongzhiArray[indexPath.section] type:_type];
            return cell;
        }
           
            break;
        case 2:
        {
           
            NSInteger index = indexPath.section;
            WS(weakSelf);
            cell.cancleBlock = ^{
                [weakSelf cancleTiBiWithIndex:index];
            };
            
            [cell setValuedataSoure:weakSelf.tibiArray[indexPath.section] type:_type];
            return cell;
        }
            
            break;
        case 3:
        {
            BFEXOtherTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"BFEXRecordViewController%ld",(long)_type]];
            if (!cell) {
                cell =  [[BFEXOtherTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:[NSString stringWithFormat:@"BFEXRecordViewController%ld",(long)_type]];
                
            }
            [cell resetValueWith:self.otherArray[indexPath.section]];
            return cell;
        }
            
            break;
            
        default:
            break;
    }
    
    return [[UITableViewCell alloc]initWithFrame:CGRectZero];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - UITableViewDelegate

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    CGFloat height = 0.f;
//    switch (_type) {
//        case 1:
//        {
//            //充币
//            WLLTiBiRecordModel *model = self.chongzhiArray[indexPath.row];
//
//            switch (model.inspectStatus.integerValue) {
//
//                case 1: // 成功
//                {
//                    height = 124;
//                }
//                    break;
//                case 0: // 失败
//                {
//                    height = 124;
//                }
//                    break;
//
//                default:
//                {
//                    height = 124;
//                }
//                    break;
//            }
//
//
//        }
//            break;
//        case 2:
//        {
//            //提币
//            WLLTiBiRecordModel *model = self.tibiArray[indexPath.row];
//
//            switch (model.inspectStatus.integerValue) {
//                    //成功
//                case 1:
//                {
//                    height = 145;
//                }
//                    break;
//                    //拒绝
//                case 2:
//                {
//                    height = 145;
//                }
//                    break;
//                    // 取消
//                case 0:
//                {
//                    height = 145;
//                }
//                    break;
//
//                default:
//                {
//                    //审核中
//                    height = 145;
//                }
//                    break;
//            }
//
//        }
//            break;
//        case 3:
//        {
//           //其他
//            BI_Asset_OtherRecord_Model *model = self.otherArray[indexPath.row];
//            NSString *returnString = model.detail;
//             height = [self returnHeightOtherHeight:returnString];
//        }
//            break;
//        default:
//            break;
//    }
//    return height;
//}

-(CGFloat)returnHeightOtherHeight:(NSString *)returnString
{
    return 57 + [self.view returnHeight:returnString font:14.f width:Screen_Width - 120] + 20;
}


-(void)btnClicked:(UIButton *)sender
{
    
}


#pragma mark - 提币撤销

-(void)cancleTiBiWithIndex:(NSInteger)index
{
    WS(weakSelf);

    [SSKJ_Default_AlertView showWithTitle:SSKJLanguage(@"撤销提币") message:SSKJLocalized(@"是否确定撤销？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
        [weakSelf requestCancleWithIndex:index];
    }];
    
//    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:SSKJLocalized(@"取消", nil)  message:SSKJLocalized(@"是否确定取消？", nil) preferredStyle:UIAlertControllerStyleAlert];
//
//    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"取消", nil) style:UIAlertActionStyleCancel handler:nil];
//    WS(weakSelf);
//    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:SSKJLocalized(@"确定", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [weakSelf requestCancleWithIndex:index];
//    }];
//
//    [alertView addAction:cancleAction];
//    [alertView addAction:confirmAction];
//    [self.navigationController presentViewController:alertView animated:YES completion:nil];
//
}


-(void)requestCancleWithIndex:(NSInteger)index
{
    ///app/addr/cancelCharge
    WLLTiBiRecordModel *model = self.tibiArray[index];
    
    
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    
    //
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:URL_TiBiRevoke_URL RequestType:RequestTypePost Parameters:@{@"id":model.ID} Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showError:responseObject[@"msg"]];

            [self refreashData];
        }else{
            [MBProgressHUD showError:responseObject[@"msg"]];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"加载失败", nil)];
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
