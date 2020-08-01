//
//  HubExchangeViewController.m
//  ZYW_MIT
//
//  Created by 晶雪之恋 on 2018/9/17.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "HubExchangeViewController.h"
#import "HubExchangeHeaderView.h"
#import "TransferAccount_Record_Controller.h"
#import "HubExchangeAssetModel.h"

@interface HubExchangeViewController ()<HubExchangeHeaderViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HubExchangeHeaderView *headerView;

@property (nonatomic, copy) NSArray *dataArray;

@property (nonatomic, strong) HubExchangeAssetModel *selectModel;

@end

@implementation HubExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = SSKJLocalized(@"兑换", nil);
    [self addRightNavgationItemWithImage:[UIImage imageNamed:@"Mine_duihuanjilu"]];
    [self setupSubView];
    self.view.backgroundColor = UIColorFromRGB(0xF5F5F5);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)setupSubView
{
    [self tableView];
}


#pragma mark 兑换记录
// 右侧按钮
-(void)rigthBtnAction:(id)sender
{
    TransferAccount_Record_Controller *recordVc = [[TransferAccount_Record_Controller alloc]init];
    recordVc.type = 1;
    recordVc.assetModel = self.selectModel;
    [self.navigationController pushViewController:recordVc animated:YES];
}

- (void)getExchangeInfoWithParam:(NSDictionary *)param pwd:(NSString *)pwdStr
{
    [self requestExchangeWithParam:param];
}

// 要兑换的币种
- (void)getExchangeModel:(HubExchangeAssetModel *)model
{
    self.selectModel = model;
}



// 兑换
- (void)requestExchangeWithParam:(NSDictionary *)param
{
    #pragma mark 处理
}
//{
//    if ([kLogined integerValue] != 1)
//    {
//        return;
//    }
//
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//
//    WS(weakSelf);
//    [hud hideAnimated:YES afterDelay:5.f];
//    [HttpTool postWithURL:Exchange_URL params:param success:^(id json) {
//        NSString *status = json[@"status"];
//        [hud hideAnimated:YES];
//        if (status.integerValue == SUCCESSED)
//        {
//            NSArray *array = [HubExchangeAssetModel mj_objectArrayWithKeyValuesArray:json[@"data"]];
//            weakSelf.dataArray = [NSMutableArray arrayWithArray:array];
//            TransferAccount_Record_Controller *recordVc = [[TransferAccount_Record_Controller alloc]init];
//            recordVc.type = 1;
//            recordVc.assetModel = weakSelf.selectModel;
//            [self.headerView clearView];
//            [weakSelf.navigationController pushViewController:recordVc animated:YES];
////            [weakSelf.headerView refreshHeaderViewWithParam:weakSelf.dataArray];
//        }
//
//        [MBProgressHUD showError:json[@"msg"]];
//    } failure:^(NSError *error) {
//        [hud hideAnimated:YES];
//        [MBProgressHUD showError:@"请求超时"];
//        LSLog(@"error : %@",error);
//    }];
//}



- (UITableView *)tableView
{
    if (_tableView == nil)
    {
        _tableView = [UITableView new];
        _tableView.backgroundColor = kBgColor;
        [self.view addSubview:self.tableView];
        self.tableView.tableFooterView = self.headerView;
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@0);
            make.bottom.equalTo(@0);
            make.left.equalTo(@0);
            make.right.equalTo(@0);
        }];
    }
    return _tableView;
}

- (HubExchangeHeaderView *)headerView
{
    if (_headerView == nil)
    {
        _headerView = [[HubExchangeHeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 500)];
//        [_headerView refreshHeaderViewWithParam:nil];
        _headerView.delegate = self;
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


@end
