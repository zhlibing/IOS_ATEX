//
//  LXY_Deep_TableView.m
//  SSKJ
//
//  Created by 刘小雨 on 2019/3/19.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import "LXY_Deep_TableView.h"
#import "LXY_Deep_TableViewCell.h"
#import "LXY_Deep_HeaderView.h"

static NSString *cellID = @"LXY_Deep_TableViewCell.h";
@interface LXY_Deep_TableView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LXY_Deep_HeaderView *headerView;

@property (nonatomic, strong) NSMutableArray *buyModelArray;
@property (nonatomic, strong) NSMutableArray *sellModelArray;

@property (nonatomic, assign) double maxVolume;     // 最大成交量
@property (nonatomic, assign) double minVolume;     // 最小成交量

@property (nonatomic, copy) NSString *coinCode;
@end

@implementation LXY_Deep_TableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.tableView];
        self.tableView.backgroundColor = [UIColor lxy_kLine_Main_BGColor];

    }
    return self;
}


-(UITableView *)tableView
{
    if (nil == _tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _tableView.bounces = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableHeaderView = self.headerView;
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableView registerClass:[LXY_Deep_TableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}


-(LXY_Deep_HeaderView *)headerView
{
    if (nil == _headerView) {
        _headerView = [[LXY_Deep_HeaderView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScaleW(30))];
    }
    return _headerView;
    
}

#pragma mark - 添加数据
-(void)setData:(NSDictionary *)data
{
    self.buyModelArray = [LXY_DeepModel mj_objectArrayWithKeyValuesArray:data[@"bids"]];
    
    if (self.buyModelArray.count > 20) {
        self.buyModelArray = [self.buyModelArray subarrayWithRange:NSMakeRange(0, 20)];
    }
    
    self.sellModelArray = [LXY_DeepModel mj_objectArrayWithKeyValuesArray:data[@"asks"]];
    
    if (self.sellModelArray.count > 20) {
        self.sellModelArray = [self.sellModelArray subarrayWithRange:NSMakeRange(0, 20)];
    }
    
    self.tableView.height = (self.buyModelArray.count + 1) * kCell_Height + ScaleW(80);
    self.height = self.tableView.bottom;
    [self calculateMaxAndMin];
    [self.tableView reloadData];
}


#pragma mark - 计算销量的最大值和最小值，成交量的最大值最小值

-(void)calculateMaxAndMin
{
    LXY_DeepModel *firstModel = self.buyModelArray.firstObject;
    
    self.maxVolume = firstModel.volume.doubleValue;
    self.minVolume = firstModel.volume.doubleValue;
    
    for (LXY_DeepModel *model in self.buyModelArray) {
        
        
        if (model.volume.doubleValue > self.maxVolume) {
            self.maxVolume = model.volume.doubleValue;
        }
        
        if (model.volume.doubleValue < self.minVolume) {
            self.minVolume = model.volume.doubleValue;
        }
    }
    
    for (LXY_DeepModel *model in self.sellModelArray) {
       
        
        if (model.volume.doubleValue > self.maxVolume) {
            self.maxVolume = model.volume.doubleValue;
        }
        
        if (model.volume.doubleValue < self.minVolume) {
            self.minVolume = model.volume.doubleValue;
        }
    }
}

#pragma mark - UITableViewDelegate UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.buyModelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCell_Height;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LXY_Deep_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    LXY_DeepModel *buyModel = self.buyModelArray[indexPath.row];
    LXY_DeepModel *sellModel = self.sellModelArray[indexPath.row];
    [cell setBuyModel:buyModel sellModel:sellModel index:indexPath.row maxVolume:self.maxVolume coinCode:self.coinCode];
    return cell;
}

-(void)setCoinCode:(NSString *)coinCode
{
    _coinCode = coinCode;
    [self.headerView setCoinCode:coinCode];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
