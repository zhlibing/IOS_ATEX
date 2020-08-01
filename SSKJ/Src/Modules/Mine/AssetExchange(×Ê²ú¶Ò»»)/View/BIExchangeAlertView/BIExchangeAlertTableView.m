//
//  BIExchangeAlertTableView.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/27.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BIExchangeAlertTableView.h"

@interface BIExchangeAlertTableView ()


@property (nonatomic, strong) NSMutableArray *itemArray; //!< 数组
@property (nonatomic,weak) id <BIExchangeAlertTableViewDelegate> exchangeDelegate; //!< 代理对象

@end

@implementation BIExchangeAlertTableView


- (instancetype)initWithDelegate:(id <BIExchangeAlertTableViewDelegate>)deletage
{
    self = [super init];
    if (self)
    {
        self.backgroundColor = kBgColor;
        [self setExchangeDelegate:deletage];
        [self setDelegate:self];
        [self setDataSource:self];
        [self setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self registerClass:[BIExchangeAlertTableViewCell class] forCellReuseIdentifier:@"BIExchangeAlertTableViewCell"];
        
        
    }
    return self;
}


-(void)setItemObjectArray:(NSMutableArray *)itemArray
{
    [self setHidden:NO];
    [self.itemArray setArray:itemArray];
    [self reloadData];
}



#pragma mark - Deletage Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    return 10;
    return [self.itemArray count];
}

- (BIExchangeAlertTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    BIExchangeAlertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"BIExchangeAlertTableViewCell"];
    [cell setModel:[self.itemArray objectAtIndex:indexPath.row]];
    return cell;
}




- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return ScaleW(30);
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return [[UIView alloc]initWithFrame:CGRectZero];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self setHidden:YES];
    if ([self.exchangeDelegate respondsToSelector:@selector(didSelectRowAtIndexPathObject:)])
    {
        [self.exchangeDelegate didSelectRowAtIndexPathObject:[self.itemArray objectAtIndex:indexPath.row]];
    }
}





#pragma mark - Getter / Setter
-(NSMutableArray *)itemArray
{
    if (!_itemArray)
    {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}


@end
