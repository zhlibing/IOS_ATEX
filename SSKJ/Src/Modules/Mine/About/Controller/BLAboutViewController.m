//
//  BLAboutViewController.m
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "BLAboutViewController.h"


#import "My_Generalize_BottomView.h"
#import "Mine_Feedback_ViewController.h"
#import "My_Protocol_ViewController.h"
#import "SSKJ_UserProtocolViewController.h"

#import <WebKit/WebKit.h>


@interface BLAboutViewController () <UITableViewDelegate,UITableViewDataSource,WKUIDelegate,WKNavigationDelegate>

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) My_Generalize_BottomView *footerView;
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIView *headerLineView;

@property (nonatomic, strong) NSMutableDictionary *publicDict;


@end

@implementation BLAboutViewController

- (NSMutableDictionary *)publicDict {
    if (!_publicDict) {
        _publicDict = [NSMutableDictionary dictionary];
    }
    return _publicDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = kBgColor;
    self.title = SSKJLocalized(@"关于我们", nil);
    [self setupUI];
}


-(My_Generalize_BottomView *)footerView
{
    if (nil == _footerView)
    {
        _footerView = [[My_Generalize_BottomView alloc]initWithFrame:CGRectMake(0, ScreenHeight-ScaleW(200), ScreenWidth, ScaleW(200))];
        WS(weakSelf);
        _footerView.privateBlock = ^{
            My_Protocol_ViewController *vc = [[My_Protocol_ViewController alloc]init];
            vc.protocolType = PROTOCOLTYPEPRIVATE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        
        _footerView.serviceBlock = ^{
            My_Protocol_ViewController *vc = [[My_Protocol_ViewController alloc]init];
            vc.protocolType = PROTOCOLTYPESERVICE;
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _footerView;
}



- (void)setupUI {
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.backgroundColor = kBgColor;
    tableView.dataSource = self;
    tableView.separatorColor = kBgColor;
    tableView.bounces = NO;
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [_tableView addSubview:self.footerView];
}


#pragma mark - Deletage Method
#pragma mark UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"aboutCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;;
    }
    if (indexPath.row == 0) {
        cell.textLabel.text = SSKJLocalized(@"联系我们", nil);
        cell.textLabel.textColor = kTitleColor;
        cell.backgroundColor = kBgColor;
        cell.contentView.backgroundColor = kBgColor;
        
    }else if (indexPath.row == 1){
        cell.textLabel.textColor = kTitleColor;
        cell.textLabel.text = SSKJLocalized(@"意见反馈",nil);
        cell.backgroundColor = kBgColor;
        cell.contentView.backgroundColor = kBgColor;
        
    }
    if (indexPath.row == 2) {
        cell.textLabel.text = SSKJLocalized(@"费率说明", nil);
        cell.textLabel.textColor = kTitleColor;
        cell.backgroundColor = kBgColor;
        cell.contentView.backgroundColor = kBgColor;
        
    }else if (indexPath.row == 3){
        cell.textLabel.textColor = kTitleColor;
        cell.textLabel.text = SSKJLocalized(@"关于VIP",nil);
        cell.backgroundColor = kBgColor;
        cell.contentView.backgroundColor = kBgColor;
        
    }
    
    cell.textLabel.font = systemFont(ScaleW(15));
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(10))];
    view.backgroundColor = kBgColor;
    return view;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row)
    {
        #pragma mark case 0 联系我们
        case 0:
        {
            [self requestContract];
        }
            break;
        #pragma mark case 1 获取联系客服
        case 1:
        {
            Mine_Feedback_ViewController *vc = [[Mine_Feedback_ViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        #pragma mark case 2 3 费率说明和关于我们
        case 2:
        case 3:
        {
            SSKJ_UserProtocolViewController *protocol = [[SSKJ_UserProtocolViewController alloc]init];
            [protocol setType:indexPath.row];
            [self.navigationController pushViewController:protocol animated:YES];
        }
            break;
    }
}


#pragma mark 获取联系客服
-(void)requestContract
{
    
    [[WLHttpManager shareManager] requestWithURL_HTTPCode:Mine_AboutUS_URL RequestType:RequestTypeGet Parameters:nil Success:^(NSInteger statusCode, id responseObject)
     {
         WL_Network_Model *net_model = [WL_Network_Model mj_objectWithKeyValues:responseObject];
         
         if ([net_model.status integerValue] == 200)
         {
             NSString *title = SSKJLocalized(@"联系客服", nil);
             NSString *email = net_model.data;
             [SSKJ_Default_AlertView showWithTitle:title message:email cancleTitle:@"" confirmTitle:@"确定" confirmBlock:^{
                 
             }];
         }
         else
         {
             [MBHUD showError:net_model.msg];
         }

         
     } Failure:^(NSError *error, NSInteger statusCode, id responseObject)
     {}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
