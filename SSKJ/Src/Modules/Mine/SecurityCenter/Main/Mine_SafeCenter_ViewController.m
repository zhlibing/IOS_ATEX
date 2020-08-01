//
//  BLSafeCenterViewController.m
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import "Mine_SafeCenter_ViewController.h"
#import "Mine_ChangePWD_ViewController.h"
#import "Lion_Forget_SetViewController.h"
#import "Mine_SetFundPwd_ViewController.h"

// view
#import "ATEX_SafeCenter_Cell.h"

static NSString *safeCell = @"safeCell";

@interface Mine_SafeCenter_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSArray *titleArray;

@end

@implementation Mine_SafeCenter_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = SSKJLocalized(@"安全中心", nil);
    self.titleArray = @[
                        SSKJLocalized(@"登录密码", nil),
                        SSKJLocalized(@"资金密码", nil),
                        ];
    [self setUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(void)setUI
{
    [self.view addSubview:self.tableView];
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScaleW(110)) style:UITableViewStylePlain];
        
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ATEX_SafeCenter_Cell class] forCellReuseIdentifier:safeCell];
        if (@available(iOS 11.0, *))
        {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 10;
            _tableView.estimatedSectionHeaderHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
        }
        else
        {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        
        
        _tableView.separatorColor = kLightLineColor;
        
        _tableView.backgroundColor = kBgColor;
        
        _tableView.contentInset = UIEdgeInsetsMake(ScaleW(10), 0, 0, 0);
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
               
    }
    return _tableView;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(49);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ATEX_SafeCenter_Cell *cell = [tableView dequeueReusableCellWithIdentifier:safeCell];
    if (indexPath.row == 0) {
        [cell setTitle:self.titleArray[indexPath.row] statusString:SSKJLocalized(@"修改", nil) isShowImage:NO];
    }else{
        
        if ([SSKJ_User_Tool sharedUserTool].userInfoModel.config.payment_password_set.integerValue == 1) {
                [cell setTitle:self.titleArray[indexPath.row] statusString:SSKJLocalized(@"修改", nil) isShowImage:NO];
        }else{
            [cell setTitle:self.titleArray[indexPath.row] statusString:SSKJLocalized(@"未设置", nil) isShowImage:YES];
        }
        
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        Mine_ChangePWD_ViewController *vc = [[Mine_ChangePWD_ViewController alloc]init];
        vc.phoneNumber = kAccount;
        [self.navigationController pushViewController:vc animated:YES];
    }else{
        Mine_SetFundPwd_ViewController *vc = [[Mine_SetFundPwd_ViewController alloc]init];
        [vc setPhoneNumber:kAccount];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

