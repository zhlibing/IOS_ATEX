//
//  HeYue_Leverage_View.m
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/1.
//  Copyright © 2019 Wang. All rights reserved.
//

#import "HeYue_Leverage_View.h"

@interface HeYue_Leverage_View()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSArray *dataSource;

@end

@implementation HeYue_Leverage_View

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 5;
        self.layer.shadowColor = [UIColor colorWithRed:3.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1f].CGColor;
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 8;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.backgroundColor = [UIColor clearColor];
        [self tableView];
    }
    return self;
}

#pragma mark - 列表表格视图
-(UITableView *)tableView
{
    if (_tableView==nil)
    {
        _tableView=[[UITableView alloc] init];
        
        _tableView.delegate=self;
        
        _tableView.dataSource=self;
        
        _tableView.backgroundColor= [UIColor clearColor];
        
        _tableView.separatorStyle=UITableViewCellSeparatorStyleNone;
        
        [self addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.left.bottom.right.equalTo(@0);
            
        }];
  
    }
    
    return _tableView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100 / 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
//    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.backgroundColor = kBgColor;
    
    cell.detailTextLabel.text = self.dataSource[indexPath.row];
    [cell.detailTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(cell.contentView.mas_centerX);
        make.centerY.equalTo(cell.contentView.mas_centerY);
    }];
    cell.detailTextLabel.textColor = kTitleColor;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.levetageBlock) {
        
        self.levetageBlock(self.dataSource[indexPath.row]);
    }
}

- (void)setDataArr:(NSArray *)dataArr
{
    self.dataSource = [NSArray arrayWithArray:dataArr];
    
    [self.tableView reloadData];
}



@end
