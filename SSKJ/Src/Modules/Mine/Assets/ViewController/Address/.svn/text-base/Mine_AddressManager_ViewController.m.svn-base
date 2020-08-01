//
//  BLAddAddressViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "Mine_AddressManager_ViewController.h"
#import "BLMangeAddressViewController.h"
#import "BFEXMoneyEdtingTableViewCell.h"
#import "QBWShowNoDataView.h"

#import "HeBi_AddAddress_ViewController.h"


@interface Mine_AddressManager_ViewController () <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, assign) NSInteger dataCount;

@property (nonatomic, strong) UIView *usdtHeaderView;


@property (nonatomic, strong) MBProgressHUD *HUD;

@end

@implementation Mine_AddressManager_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = SSKJLocalized(@"提币地址", nil);
    [self setupUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self requesAddressList];
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

#pragma mark - method
/**
 初始化
 */
- (void)setupUI {
    // header label

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - Height_NavBar) style:UITableViewStylePlain];
        
    tableView.backgroundColor = kSubBgColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView = tableView;
    tableView.tableFooterView = [UIView new];
    _tableView.contentInset = UIEdgeInsetsMake(ScaleW(10), 0, 0, 0);
    if (@available(iOS 11.0, *)) {
        tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    
}

#pragma mark - 请求提币地址
- (void)requesAddressList

{
    __weak typeof(self) weakSelf = self;
    self.HUD = [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
    
    NSDictionary *dic = @{
                          @"id":kUserID
                          };
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_AddressList_URL RequestType:RequestTypePost Parameters:dic Success:^(NSInteger statusCode, id responseObject) {
        if ([responseObject[@"code"] integerValue] == 200) {
            [weakSelf.dataSource removeAllObjects];

            [weakSelf.dataSource addObjectsFromArray:responseObject[@"data"][@"BTC"]];
            
            [weakSelf.tableView reloadData];
            [weakSelf.HUD hideAnimated:YES];

        } else {
            [MBProgressHUD showError:responseObject[@"msg"]];
            [weakSelf.HUD hideAnimated:YES];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        [MBProgressHUD showError:SSKJLocalized(@"服务器请求异常", nil)];
        [weakSelf.HUD hideAnimated:YES];
    }];

}

/**
 添加地址
 */
- (void)addAddress:(UIButton *)button {
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    BFEXMoneyEdtingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[NSString stringWithFormat:@"BFEXMoneyEdtingTableViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
    if (!cell) {
        cell = [[BFEXMoneyEdtingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[NSString stringWithFormat:@"BFEXMoneyEdtingTableViewCell%ld%ld",(long)indexPath.section,(long)indexPath.row]];
        //cell.backgroundColor = RGBCOLOR16(0xf4f9fa);
        WS(weakSelf);
        cell.deleBlock = ^{
            
            [SSKJ_Default_AlertView showWithTitle:SSKJLocalized(@"提醒", nil) message:SSKJLocalized(@"确定删除该地址吗?", nil) cancleTitle:SSKJLocalized(@"取消", nil) confirmTitle:SSKJLocalized(@"确定", nil) confirmBlock:^{
                                [weakSelf tableView:tableView deleteAddressIndexPath:indexPath];

            }];
        };
    }
    [cell setValueWithData:self.dataSource[indexPath.row]];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.getAddressBlock) {
        self.getAddressBlock(self.dataSource[indexPath.row][@"toAddr"]);
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return   UITableViewCellEditingStyleNone;
}
//先要设Cell可编辑
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 55.0f;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return self.usdtHeaderView;
}
-(UIView *)usdtHeaderView{
    if (!_usdtHeaderView) {
        _usdtHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width,   55)];
        _usdtHeaderView.backgroundColor = kBgColor;
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, Screen_Width, 45)];
        backView.backgroundColor = kBgColor;
        [_usdtHeaderView addSubview:backView];
        UILabel *messagelabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, Screen_Width - 10, 45)];
        [self.view label:messagelabel font:18 textColor:kTitleColor text:@"USDT"];
        messagelabel.font = [UIFont boldSystemFontOfSize:18];
        [backView addSubview:messagelabel];
        //btn
        UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [addBtn setImage:[UIImage imageNamed:@"mine_add"] forState:UIControlStateNormal];
        addBtn.width = 60;
        addBtn.height = 45;
        addBtn.right = backView.right - 5;
        addBtn.top = 0;
        [addBtn addTarget:self action:@selector(addUSDTBtn:) forControlEvents:(UIControlEventTouchUpInside)];
        [backView addSubview:addBtn];
    }
    return _usdtHeaderView;
}

#pragma mark - 添加地址页面

-(void)addUSDTBtn:(UIButton *)sender
{
    BLMangeAddressViewController *addressVC = [[BLMangeAddressViewController alloc] init];
    addressVC.currentType = @"2";
    [self.navigationController pushViewController:addressVC animated:YES];
}


//进入编辑模式，按下出现的编辑按钮后
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self tableView:tableView deleteAddressIndexPath:indexPath];
    }
}
//修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}
//设置进入编辑状态时，Cell不会缩进
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark - 删除地址
- (void)tableView:(UITableView *)tableView deleteAddressIndexPath:(NSIndexPath *)indexPath {
    //删除
    NSDictionary *dataDic = self.dataSource[indexPath.row];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];

    params[@"id"]  = dataDic[@"id"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    WS(weakSelf);
    [[WLHttpManager shareManager]requestWithURL_HTTPCode:BI_DeleteAddress_URL RequestType:RequestTypePost Parameters:params Success:^(NSInteger statusCode, id responseObject) {
        
        [MBProgressHUD hideHUDForView:weakSelf.view animated:YES];
        
        WL_Network_Model *netModel = [WL_Network_Model mj_objectWithKeyValues:responseObject];
        
        if (netModel.status.integerValue == SUCCESSED) {
            [MBProgressHUD showSuccess:netModel.msg];
            [weakSelf requesAddressList];
        }else{
            [MBProgressHUD showError:netModel.msg];
        }
    } Failure:^(NSError *error, NSInteger statusCode, id responseObject) {
        
    }];

}


// 长按cell，复制操作
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
// 可以执行的操作,action包括（cut、copy、paste、select、selectAll)，这里只执行 copy 操作
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    // 设置只能复制
    if (action == @selector(cut:)){
        return NO;
    }
    else if(action == @selector(copy:)){
        return YES;
    }
    else if(action == @selector(paste:)){
        return NO;
    }
    else if(action == @selector(select:)){
        return NO;
    }
    else if(action == @selector(selectAll:)){
        return NO;
    }
    else{
        return [super canPerformAction:action withSender:sender];
    }
}

// 执行操作
- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender{
    if (action == @selector(copy:)) {
        //  把获取到的字符串放置到剪贴板上
        [UIPasteboard generalPasteboard].string = self.dataSource[indexPath.row][@"toAddr"];
        [MBProgressHUD showSuccess:@"地址复制成功"];
    }
}


@end
