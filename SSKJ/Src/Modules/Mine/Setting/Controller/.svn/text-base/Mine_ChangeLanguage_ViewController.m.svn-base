//
//  Mine_ChangeLanguage_ViewController.m
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/15.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import "Mine_ChangeLanguage_ViewController.h"
#import "ChangeLanguage_TableViewCell.h"

#import "AppDelegate.h"

static NSString *cellID = @"ChangeLanguage_TableViewCell";

@interface Mine_ChangeLanguage_ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation Mine_ChangeLanguage_ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = SSKJLocalized(@"语言切换", nil);
    [self.view addSubview:self.tableView];
}

-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Height_NavBar, ScreenWidth, ScreenHeight - ScaleW(10) - Height_NavBar) style:UITableViewStylePlain];
            
        _tableView.backgroundColor = kBgColor;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[ChangeLanguage_TableViewCell class] forCellReuseIdentifier:cellID];
        _tableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(50);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ChangeLanguage_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    NSString *language = [[SSKJLocalized sharedInstance]currentLanguage];
    
    if (indexPath.row == 0) {
        [cell setTitle:@"简体中文" andSelected:[language isEqualToString:@"zh-Hans"]];
    }else{
        [cell setTitle:@"English" andSelected:[language isEqualToString:@"en"]];
    }

    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *key;
    if (indexPath.row == 0) {
        key = @"zh-Hans";
    }else{
        key = @"en";
    }
    
    [[SSKJLocalized sharedInstance]setLanguage:key];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate gotoMain];

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
