//
//  My_UserInfo_ViewController.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_UserInfo_ViewController.h"
#import "My_Info_Cell.h"

@interface My_UserInfo_ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemArray;
@end

@implementation My_UserInfo_ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavigationBarHidden:NO];
    self.title = SSKJLocalized(@"个人信息", nil);
    
    
    [self addSubviews:YES];
}


-(void)addSubviews:(BOOL)subviews
{
    if (subviews)
    {
        [self unit:YES];
        [self.view addSubview:self.tableView];
        [self.tableView reloadData];
    }
}




#pragma mark - Getter / Setter
-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, ScaleW(10), ScreenWidth, ScreenHeight - Height_NavBar - ScaleW(10)) style:UITableViewStylePlain];
        [_tableView setBackgroundColor:kBgColor];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.separatorColor = [UIColor blueColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[My_Info_Cell class] forCellReuseIdentifier:@"My_Info_Cell"];
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
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        UIView *style = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 11)];
        style.layer.backgroundColor = [[UIColor colorWithRed:247.0f/255.0f green:247.0f/255.0f blue:250.0f/255.0f alpha:1.0f] CGColor];
        style.alpha = 1;
        
        _tableView.tableHeaderView=style;
        
    }
    return _tableView;
}

-(NSMutableArray *)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}




#pragma mark - UITableViewDelegate UITableViewDatsSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(60);
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    My_Info_Cell *cell = [tableView dequeueReusableCellWithIdentifier:@"My_Info_Cell"];
    [cell setItemObject:[self.itemArray objectAtIndex:indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(void)unit:(BOOL)unit
{
    if (unit)
    {
        for (int i = 0 ; i < 5; i++)
        {
            Mine_UserInfoModel *model = [[Mine_UserInfoModel alloc]init];
            switch (i)
            {
//                case 0:
//                {
//                    [model setTitle:@"等级"];
//
//                    NSInteger vip = [SSKJ_User_Tool sharedUserTool].userInfoModel.vipLevel.integerValue;
//
//                    [model setDescribe:[NSString stringWithFormat:@"V%ld",vip]];
//                }
//                    break;
                case 0:
                {
                    if (![RegularExpression validateEmail:kAccount]) {
                        [model setTitle:@"手 机 号:"];
                    }else{
                        [model setTitle:@"邮箱地址:"];
                    }
                    [model setDescribe:kAccount];
                    
                }
                    break;
                case 1:
                {
                    [model setTitle:@"交 易 ID:"];
                    [model setDescribe:[SSKJ_User_Tool sharedUserTool].userInfoModel.userUid];
                }
                    break;
                case 2:
                {
                    [model setTitle:@"姓      名:"];
                    
                   if ([SSKJ_User_Tool sharedUserTool].userInfoModel.username.length > 0) {
                     [model setDescribe:[SSKJ_User_Tool sharedUserTool].userInfoModel.username];
                   }else{
                       [model setDescribe:@"----"];
                   };
                }
                    break;
//                case 3:
//                {
//                    [model setTitle:@"等      级:"];
//                    NSInteger vip = [SSKJ_User_Tool sharedUserTool].userInfoModel.vipLevel.integerValue;
//                    //
//                    if (vip ==0) {
//
//                         [model setDescribe:SSKJLocalized(@"普通用户",  nil)];
//                    }
//                    else{
//                       [model setDescribe:[NSString stringWithFormat:@"%ld%@",vip,SSKJLocalized(@"级", nil)]];
//                    }
//
//                    break;
//
//                }
                case 3:
                {
                    [model setTitle:@"身份证号:"];
                    
                   if ([SSKJ_User_Tool sharedUserTool].userInfoModel.idCard.length > 0){
                       
                        [model setDescribe:[SSKJ_User_Tool sharedUserTool].userInfoModel.idCard];
                   }
                   else{
                       
                    [model setDescribe:@"----"];
                       
                   };
                     break;
                }
                   
            }
            [self.itemArray addObject:model];
        }
    }
}


@end
