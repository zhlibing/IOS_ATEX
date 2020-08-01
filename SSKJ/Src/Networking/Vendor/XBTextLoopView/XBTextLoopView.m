//
//  XBTextLoopView.m
//  文字轮播
//
//  Created by 周旭斌 on 2017/4/9.
//  Copyright © 2017年 周旭斌. All rights reserved.
//

#import "XBTextLoopView.h"
#import "XBTextLoopTableViewCell.h"
@interface XBTextLoopView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, assign) NSTimeInterval interval;
@property (nonatomic, strong) NSTimer *myTimer;
@property (nonatomic, assign) NSInteger currentRowIndex;
@property (nonatomic, copy) selectTextBlock selectBlock;

@end

@implementation XBTextLoopView

#pragma mark - 初始化方法
+ (instancetype)textLoopViewWith:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame selectBlock:(selectTextBlock)selectBlock {
    XBTextLoopView *loopView = [[XBTextLoopView alloc] initWithFrame:frame];
    loopView.backgroundColor = [UIColor clearColor];
    loopView.dataSource = dataSource;
    loopView.selectBlock = selectBlock;
    loopView.interval = timeInterval ? timeInterval : 5.0;
   loopView.myTimer = [NSTimer scheduledTimerWithTimeInterval:5.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [loopView timer];
    }];
    return loopView;
}

- (void)setContentColor:(UIColor *)contentColor {
    _contentColor = contentColor;
    [self.tableView reloadData];
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    XBTextLoopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (!cell) {
        cell = [[XBTextLoopTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.contentTxtLabel.height = self.height;
        cell.contentTxtLabel.width = self.width;
        
    }
    cell.backgroundColor = [UIColor clearColor];
    cell.contentTxtLabel.text = _dataSource[indexPath.row];
    cell.contentTxtLabel.textColor = self.contentColor;
    return cell;
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_selectBlock) {
        self.selectBlock(_dataSource[indexPath.row], indexPath.row);
    }
}

#pragma mark - scrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    // 以无动画的形式跳到第1组的第0行
    if (_currentRowIndex == _dataSource.count) {
        _currentRowIndex = 0;
        [_tableView setContentOffset:CGPointZero];
    }
     !self.currentIndexBlock?:self.currentIndexBlock(_currentRowIndex);
}

#pragma mark - priviate method
- (void)setInterval:(NSTimeInterval)interval {
    _interval = interval;

    [_myTimer invalidate];
    
    //_myTimer = nil;
    // 定时器
   // NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(timer) userInfo:nil repeats:YES];
    WS(weakSelf);
 
    //_myTimer = timer;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        // tableView
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _tableView = tableView;
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.rowHeight = frame.size.height;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.backgroundColor = [UIColor clearColor];
        [self addSubview:tableView];
    }
    return self;
}

- (void)timer {
    self.currentRowIndex++;
    if (self.timeSelectedBlock) {
        self.timeSelectedBlock(self.currentRowIndex);
    }
    //SSLog(@"%ld", _currentRowIndex);
    [self.tableView setContentOffset:CGPointMake(0, _currentRowIndex * _tableView.rowHeight) animated:YES];
    
}

-(void)setCurrentRowIndex:(NSInteger)currentRowIndex
{
    _currentRowIndex = currentRowIndex;
   
}



@end
