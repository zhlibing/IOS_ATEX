//
//  BLAddAddressViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Mine_AddressManager_ViewController.h"
#import "Mine_AddAddress_ViewController.h"
#import "Mine_AddressList_TableViewCell.h"
#import "Login_Google_AlertView.h"

static NSString *cellID = @"Mine_AddressList_TableViewCell";

@interface Mine_AddressManager_ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) AddressManager_HeaderView *headerView;
@property (nonatomic, weak) UITableView *tableView;
//omni
@property (nonatomic, strong) NSMutableArray *omniArray;
//erc20
@property (nonatomic, strong) NSMutableArray *ercArray;

@property (nonatomic, strong) UIButton *addButton;


@property (nonatomic, strong) MBProgressHUD *HUD;

@property (nonatomic, strong) ExtractAddress_IndexModel *selectModel;
@end

@implementation Mine_AddressManager_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"提币地址", nil);
    
//    self.walletType = WalletTypeOMNI;
    
    [self setWalletType:self.walletType];
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (kLogin) {
        [self requesAddressList];
    }
}

-(void)setWalletType:(WalletType)walletType
{
    _walletType = walletType;
    
    self.headerView.walletType = walletType;
    
}


#pragma mark - method
/**
 初始化
 */
- (void)setupUI {
    // header label

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, self.addButton.top - ScaleW(10) - Height_NavBar) style:UITableViewStylePlain];
        
    tableView.backgroundColor = kBgColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    [_tableView registerClass:[Mine_AddressList_TableViewCell class] forCellReuseIdentifier:cellID];
    tableView.tableFooterView = [UIView new];
    tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requesAddressList)];
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
    [self.view addSubview:self.addButton];
    
}

-(AddressManager_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[AddressManager_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(70))];
        WS(weakSelf);
        _headerView.changeWalletTypeBlock = ^(WalletType walletType) {
            weakSelf.walletType = walletType;
            [weakSelf.tableView reloadData];
        };
    }
    return _headerView;
}


- (UIButton *)addButton{
    if (_addButton == nil) {
        _addButton = [WLTools allocButton:SSKJLanguage(@"添加地址") textColor:kWhiteColor nom_bg:nil hei_bg:nil frame:CGRectMake(ScaleW(15), ScreenHeight - ScaleW(45) - ScaleW(20), ScreenWidth - ScaleW(30), ScaleW(45))];
        _addButton.titleLabel.font = kFont(15);
        [_addButton addTarget:self action:@selector(addAddress) forControlEvents:UIControlEventTouchUpInside];
        _addButton.layer.masksToBounds = YES;
        _addButton.layer.cornerRadius = ScaleW(5);
        _addButton.backgroundColor = kBlueColor;
        [self.view addSubview:_addButton];
    }
    return _addButton;
}


/**
 添加地址
 */
- (void)addAddress
{
    Mine_AddAddress_ViewController *addressVC = [[Mine_AddAddress_ViewController alloc] init];
    addressVC.walletType = self.walletType;
    [self.navigationController pushViewController:addressVC animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *array;
    if (self.walletType == WalletTypeOMNI) {
        array = self.omniArray;
    }else{
        array = self.ercArray;
    }
    
    [SSKJ_NoDataView showNoData:array.count toView:self.tableView offY:ScaleW(70)];
    
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    Mine_AddressList_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    NSArray *array;
    if (self.walletType == WalletTypeOMNI) {
        array = self.omniArray;
    }else{
        array = self.ercArray;
    }
    
    [cell setValueWithData:array[indexPath.row]];
    WS(weakSelf);
     cell.deleBlock = ^{
         weakSelf.selectModel = array[indexPath.row];
         [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"删除地址", nil) message:SSKJLocalized(@"确认删除该地址吗？", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
             [weakSelf deleteAddress];
         }];
     };
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ScaleW(84);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array;
    if (self.walletType == WalletTypeOMNI) {
        array = self.omniArray;
    }else{
        array = self.ercArray;
    }
    if (self.getAddressBlock) {
        self.getAddressBlock(array[indexPath.row]);
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return ScaleW(70);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.headerView;
}


#pragma mark - 请求提币地址
- (void)requesAddressList
{
    __weak typeof(self) weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_AddressList_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];

        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        [weakSelf.tableView.mj_header endRefreshing];
        if (netModel.status.integerValue == SUCCESSED) {

            [weakSelf handleAddressListWithModel:netModel];
            
            [weakSelf.HUD hideAnimated:YES];

        } else {
            [MBProgressHUD showError:responseObject[@"msg"]];
            [weakSelf.HUD hideAnimated:YES];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.HUD hideAnimated:YES];
    }];

}

-(void)handleAddressListWithModel:(WL_Network_Model *)netModel
{
    
    self.omniArray = [ExtractAddress_IndexModel mj_objectArrayWithKeyValuesArray:[netModel.data firstObject][@"omni"]];
    self.ercArray = [ExtractAddress_IndexModel mj_objectArrayWithKeyValuesArray:[netModel.data firstObject][@"erc20"]];
        
    [self.tableView reloadData];

}

#pragma mark - 删除地址
- (void)deleteAddress{
    //删除

    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"address_id"]  = self.selectModel.ID;
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_DeleteAddress_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:netModel.msg];
            [weakSelf requesAddressList];
        }
        else
        {
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
    }];

}




@end
