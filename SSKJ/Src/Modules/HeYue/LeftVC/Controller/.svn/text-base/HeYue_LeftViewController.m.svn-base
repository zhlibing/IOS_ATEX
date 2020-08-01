//
//  HeYue_LeftViewController.m
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "HeYue_LeftViewController.h"

#import "Heyue_Left_NavView.h"

#import "SSKJ_Market_Index_Model.h"

#import "HeYue_LeftSample_TableViewCell.h"

static NSString * HeyueLeftCellID = @"Heyue_Left_Cell";

static NSString *MarketSocketIdentifier = @"MarketSocketIdentifier";

@interface HeYue_LeftViewController ()<UITableViewDelegate,UITableViewDataSource,ManagerSocketDelegate>

@property (nonatomic,strong) ManagerSocket * marketSocket;

@property (nonatomic,strong) Heyue_Left_NavView *navView;

@property (nonatomic,strong) NSMutableArray *dataSource;

@property (nonatomic,strong) UITableView * tableView;

@end

@implementation HeYue_LeftViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.navView];
    self.view.backgroundColor = kBgColor;

    [self tableView];
    
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self requestCoinListURL];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self closeSocket];
    
}

#pragma mark -- ManagerSocketDelegate


-(ManagerSocket *)marketSocket
{
    if (nil == _marketSocket) {
        _marketSocket = [[ManagerSocket alloc]initWithUrl:MarketSocketUrl identifier:MarketSocketIdentifier];
    }
    return _marketSocket;
}

//打开Socket
-(void)openSocket{
    if (![self.marketSocket socketIsConnected]) {

    //SocketUrl
    self.marketSocket.delegate = self;
    WS(weakSelf);
    [self.marketSocket openConnectSocketWithConnectSuccess:^{
        
        NSString *codeString = @"ticker@";
        for (SSKJ_Market_Index_Model *model in self.dataSource) {
            if ([codeString hasSuffix:@"@"]) {
                codeString = [codeString stringByAppendingString:model.code];
            }else{
                codeString = [codeString stringByAppendingFormat:@"|%@",model.code];
            }
        }
        
        NSString *type = [WLTools convertToJson:@{@"sub":codeString}];

        
        [weakSelf.marketSocket socketSendMsg:type];
        [weakSelf.marketSocket startSendHeartTimer];
        
    }];

    }
}
//关闭Socket
-(void)closeSocket{
    self.marketSocket.delegate = nil;
    [self.marketSocket closeConnectSocket];
}

//接收推送数据
-(void)socketDidReciveData:(id)data identifier:(NSString *)identifier{
    SSKJ_Market_Index_Model *model=[SSKJ_Market_Index_Model mj_objectWithKeyValues:data];
    
    for (int i = 0; i < self.dataSource.count; i++) {
        SSKJ_Market_Index_Model *indexModel = self.dataSource[i];
        if ([indexModel.code isEqualToString:model.code]) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:i inSection:0];
            model.image = indexModel.image;
            [self.dataSource replaceObjectAtIndex:i withObject:model];

           HeYue_LeftSample_TableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
            cell.model = model;
        }
    }
    
}

#pragma mark -- 导航设置 --
- (Heyue_Left_NavView *)navView{
    if (_navView == nil) {
        _navView = [[Heyue_Left_NavView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth * 0.8, ScaleW(55) + Height_StatusBar)];
        WS(weakSelf);
        _navView.BackBlock = ^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        };
    }
    return _navView;
}
#pragma mark -- 建表 --
- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;
        _tableView.backgroundColor = kBgColor;
        [_tableView registerClass:[HeYue_LeftSample_TableViewCell class] forCellReuseIdentifier:HeyueLeftCellID];
        if (@available(iOS 11.0, *)){
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }else{
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.navView.mas_bottom);
            make.left.equalTo(@0);
            make.width.equalTo(@(ScreenWidth * 0.8));
            make.bottom.equalTo(@0);
        }];
    }
    return _tableView;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return ScaleW(50);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HeYue_LeftSample_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:HeyueLeftCellID forIndexPath:indexPath];
    
//    [cell initWithCellModel:self.dataSource[indexPath.row]];
    cell.model = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SSKJ_Market_Index_Model *listModel=self.dataSource[indexPath.row];
    
    if (self.selectCoinBlock) {
        self.selectCoinBlock(listModel);
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];

}

#pragma mark -- 网络请求 --
#pragma mark -- 请求币种列表 --
- (void)requestCoinListURL{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    //kMarketURL
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:BI_BBCoinList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        
        [hud hideAnimated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == 200) {
            
            self.dataSource = [SSKJ_Market_Index_Model mj_objectArrayWithKeyValuesArray:netModel.data];
            
            //开启推送
            if (self.dataSource.count > 0) {
                if ([self.marketSocket socketIsConnected] == NO){
                    [self openSocket];
                }
            }
            
            [self.tableView reloadData];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
        
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [hud hideAnimated:YES];
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
