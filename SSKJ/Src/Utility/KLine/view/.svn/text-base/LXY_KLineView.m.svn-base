//
//  LXY_KLineView.m
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import "LXY_KLineView.h"

#import "LXY_KLine_MainView.h"          // 主k线图

#import "LXY_KLine_VolumeView.h"        // 成交量图

#import "LXY_KLine_AccessoryView.h"     // 指标图

#import "LXY_KLine_DataModel.h"

#import "LXY_KLinePositionTool.h"

#import "LXY_KLine_PriceLabel_View.h"

#import "LXY_KLineVolume_CoordinateView.h"

#import "LXY_KLineTimeLabel_View.h"

#import "LXY_KLine_MAView.h"

#import "LXY_KLine_TipView.h"

#import "LXY_KLine_CurrentPriceLineView.h"

#import "LXY_KLine_AccessoryCoordinateView.h"

#import "LXY_KLine_VolumeMALabelView.h"

#import "LXY_KLine_AccessoryLabelView.h"



@interface LXY_KLineView ()<UIScrollViewDelegate,LXY_KLine_MineView_Porotcol,LXY_KLine_VolumeView_Porotcol,LXY_KLine_Accessory_Porotcol>

@property (nonatomic, strong) UIScrollView *scrollView;

// 主k线图
@property (nonatomic, strong) LXY_KLine_MainView *kLine_MainView;

// 成交量图
@property (nonatomic, strong) LXY_KLine_VolumeView *kLine_VolumeView;


// 指标图
@property (nonatomic, strong) LXY_KLine_AccessoryView *accessoryView;

// 价格图
@property (nonatomic, strong) LXY_KLine_PriceLabel_View *kLine_PriceView;

// 成交量y轴坐标图
@property (nonatomic, strong) LXY_KLineVolume_CoordinateView *kLine_volumeCoordinateView;

// 成交量指标图
@property (nonatomic, strong) LXY_KLine_VolumeMALabelView *kLlie_volumeLabelView;

// 指标图上方的label图
@property (nonatomic, strong) LXY_KLine_AccessoryLabelView *kLine_accessoryLabelView;

// 指标y轴坐标图
@property (nonatomic, strong) LXY_KLine_AccessoryCoordinateView *kLine_accessoryCoordinateView;

// 长按出现的浮层
@property (nonatomic, strong) LXY_KLine_TipView *kLine_tipView;

// 显示ma值的view
@property (nonatomic, strong) LXY_KLine_MAView *kLineMAView;


@property (nonatomic, strong) LXY_KLine_CurrentPriceLineView *currentPirceLineView;

// 长按时k线图上出现的竖线（十字线）
@property (nonatomic, strong) UIView *longPress_VView1;
// 长按时成交量图上出现的竖线（十字线）
@property (nonatomic, strong) UIView *longPress_VView2;
// 长按时指标图上出现的竖线（十字线）
@property (nonatomic, strong) UIView *longPress_VView3;
// 长按时k线图上出现的横线（十字线）
@property (nonatomic, strong) UIView *longPress_HView;

// 时间label图
@property (nonatomic, strong) LXY_KLineTimeLabel_View *kLine_timeLabelView;

@property (nonatomic, assign) BOOL isShowLast;
#pragma mark - 手势
@property (nonatomic, strong) UIPinchGestureRecognizer *pinGesture;
@property (nonatomic, strong) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) UITapGestureRecognizer *tapGesture;
@property (nonatomic, strong) UIPanGestureRecognizer *panGesture;


@property (nonatomic, assign) double lastScale;

@property (nonatomic, strong) NSMutableArray *dataSource;

// 原始数据
@property (nonatomic, strong) NSMutableArray *originalDataSource;

// model数据
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, copy) NSString *formatterString;

@property (nonatomic, assign) LXY_KLINETYPE klineType;


@end

@implementation LXY_KLineView

-(instancetype)initWithFrame:(CGRect)frame accessoryType:(LXY_ACCESSORYTYPE)accessoryType mainAccessoryType:(LXY_KMAINACCESSORYTYPE)mainAccessoryType
{
    if (self = [super initWithFrame:frame]) {
        _accessoryType = accessoryType;
        _mainAccessoryType = mainAccessoryType;
        self.backgroundColor =  [UIColor lxy_kLineBGColor];
        [self addSubview:self.scrollView];
        
        [self addSubview:self.kLine_MainView];
        [self.kLine_MainView addSubview:self.kLine_PriceView];
        [self addSubview:self.kLineMAView];
        
        
        [self addSubview:self.kLine_VolumeView];
        [self.kLine_VolumeView addSubview:self.kLine_volumeCoordinateView];
        [self addSubview:self.kLlie_volumeLabelView];
        
        [self addSubview:self.accessoryView];
        [self.accessoryView addSubview:self.kLine_accessoryCoordinateView];
        [self addSubview:self.kLine_accessoryLabelView];
        
        self.kLineMAView.mainAccessoryType = mainAccessoryType;
        
        [self addSubview:self.kLine_timeLabelView];
        [self addSubview:self.kLine_tipView];
        [self.kLine_MainView addSubview:self.currentPirceLineView];
        self.layer.masksToBounds = YES;
        self.lastScale = 1;
        
    }
    return self;
}

#pragma mark - UI

-(UIScrollView *)scrollView
{
    if (nil == _scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(lxy_kLineView_left, 0, self.width - lxy_kLineView_left - lxy_kLineView_right, self.height)];
        _scrollView.backgroundColor = [UIColor lxy_kLineBGColor];
        _scrollView.delegate = self;
        [_scrollView addGestureRecognizer:self.pinGesture];
        [_scrollView addGestureRecognizer:self.longPressGesture];
        [_scrollView addGestureRecognizer:self.tapGesture];
    }
    return _scrollView;
}

-(UIPinchGestureRecognizer *)pinGesture
{
    if (!_pinGesture) {
        _pinGesture = [[UIPinchGestureRecognizer alloc]initWithTarget:self action:@selector(pinEvent:)];
    }
    return _pinGesture;
}

- (UILongPressGestureRecognizer *)longPressGesture
{
    if (nil == _longPressGesture) {
        _longPressGesture = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longPressEvent:)];
    }
    return _longPressGesture;
}

- (UITapGestureRecognizer *)tapGesture
{
    if (nil == _tapGesture) {
        _tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapEvent:)];
    }
    return _tapGesture;
}

-(UIPanGestureRecognizer *)panGesture
{
    if (nil == _panGesture) {
        _panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panEvent:)];
    }
    return _panGesture;
}

#pragma mark 主k线图部分


-(LXY_KLine_MainView *)kLine_MainView
{
    if (!_kLine_MainView) {
        
        CGFloat height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_bottom) * lxy_kMainViewScale;
        
        //        CGFloat height = (self.height  - lxy_kLineView_bottom);
        
        
        if (_accessoryType != LXY_ACCESSORYTYPENONE) {
            height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_Middle2 - lxy_kLineView_bottom) * (1 - 2 * lxy_kAccessaryScalw);
        }
        _kLine_MainView = [[LXY_KLine_MainView alloc]initWithFrame:CGRectMake(lxy_kLineView_left,lxy_kLineView_top , self.width - lxy_kLineView_left - lxy_kLineView_right, height)];
        _kLine_MainView.delegate = self;
        _kLine_MainView.klineType = LXY_KLINETYPETIME;
        _kLine_MainView.accessoryType = self.mainAccessoryType;
        _kLine_MainView.backgroundColor = [UIColor lxy_kLine_Main_BGColor];
        _kLine_MainView.userInteractionEnabled = YES;
    }
    return _kLine_MainView;
}
- (LXY_KLine_PriceLabel_View *)kLine_PriceView
{
    if (nil == _kLine_PriceView) {
        _kLine_PriceView = [[LXY_KLine_PriceLabel_View alloc]initWithFrame:CGRectMake(self.kLine_MainView.width - ScaleW(80), 0, ScaleW(80), self.kLine_MainView.height)];
        _kLine_PriceView.backgroundColor = [UIColor clearColor];
    }
    return _kLine_PriceView;
}

- (LXY_KLine_MAView *)kLineMAView
{
    if (nil == _kLineMAView) {
        _kLineMAView = [[LXY_KLine_MAView alloc]initWithFrame:CGRectMake(self.kLine_MainView.x, 0, self.kLine_MainView.width, lxy_kLineView_top)];
        _kLineMAView.hidden = YES;
        _kLineMAView.backgroundColor = [UIColor clearColor];
    }
    return _kLineMAView;
}
- (LXY_KLine_CurrentPriceLineView *)currentPirceLineView
{
    if (nil == _currentPirceLineView) {
        _currentPirceLineView = [[LXY_KLine_CurrentPriceLineView alloc]initWithFrame:CGRectMake(0, 0, self.kLine_MainView.width, 50)];
        _currentPirceLineView.hidden = YES;
        WS(weakSelf);
        _currentPirceLineView.toLastBlock = ^{
            
            //            dispatch_async(dispatch_get_main_queue(), ^{
            //                [UIView animateWithDuration:.3 animations:^{
            //                    weakSelf.scrollView.contentOffset = CGPointMake(weakSelf.scrollView.contentSize.width - weakSelf.scrollView.width, 0);
            //
            //                }];
            //            });
            [weakSelf.scrollView scrollRectToVisible:CGRectMake(weakSelf.scrollView.contentSize.width - weakSelf.scrollView.width, 0, weakSelf.scrollView.width, weakSelf.scrollView.height) animated:YES];
        };
    }
    return _currentPirceLineView;
}
#pragma mark 成交图部分
-(LXY_KLine_VolumeView *)kLine_VolumeView
{
    if (nil == _kLine_VolumeView) {
        
        CGFloat height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_bottom) * (1 - lxy_kMainViewScale);
        
        if (_accessoryType != LXY_ACCESSORYTYPENONE) {
            height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_Middle2 - lxy_kLineView_bottom) * lxy_kAccessaryScalw;
        }
        
        _kLine_VolumeView = [[LXY_KLine_VolumeView alloc]initWithFrame:CGRectMake(self.kLine_MainView.x, self.kLine_MainView.bottom + lxy_kLineView_Middle1, self.kLine_MainView.width, height)];
        _kLine_VolumeView.backgroundColor = [UIColor lxy_kLine_Volume_BGColor];
        _kLine_VolumeView.userInteractionEnabled = NO;
        _kLine_VolumeView.delegate = self;
    }
    return _kLine_VolumeView;
}
- (LXY_KLineVolume_CoordinateView *)kLine_volumeCoordinateView
{
    if (nil == _kLine_volumeCoordinateView) {
        _kLine_volumeCoordinateView = [[LXY_KLineVolume_CoordinateView alloc]initWithFrame:CGRectMake(self.kLine_PriceView.x, 0, ScaleW(80), self.kLine_VolumeView.height)];
        _kLine_volumeCoordinateView.backgroundColor = [UIColor clearColor];
    }
    return _kLine_volumeCoordinateView;
}

-(LXY_KLine_VolumeMALabelView *)kLlie_volumeLabelView
{
    if (nil == _kLlie_volumeLabelView) {
        _kLlie_volumeLabelView = [[LXY_KLine_VolumeMALabelView alloc]initWithFrame:CGRectMake(self.kLine_VolumeView.x, self.kLine_VolumeView.y - lxy_kLineView_Middle2, self.kLine_VolumeView.width, lxy_kLineView_Middle2)];
    }
    return _kLlie_volumeLabelView;
}


#pragma mark  指标图部分
-(LXY_KLine_AccessoryView *)accessoryView
{
    if (nil == _accessoryView) {
        CGFloat height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_Middle2 - lxy_kLineView_bottom) * lxy_kAccessaryScalw;
        
        _accessoryView = [[LXY_KLine_AccessoryView alloc]initWithFrame:CGRectMake(self.kLine_MainView.x, self.kLine_VolumeView.bottom + lxy_kLineView_Middle2, self.scrollView.width, height)];
        _accessoryView.delegate = self;
        _accessoryView.userInteractionEnabled = NO;
        _accessoryView.hidden = (self.accessoryType == LXY_ACCESSORYTYPENONE);
        _accessoryView.accessoryType = self.accessoryType;
    }
    return _accessoryView;
}

-(LXY_KLine_AccessoryCoordinateView *)kLine_accessoryCoordinateView
{
    if (nil == _kLine_accessoryCoordinateView) {
        _kLine_accessoryCoordinateView = [[LXY_KLine_AccessoryCoordinateView alloc]initWithFrame:CGRectMake(self.kLine_PriceView.x, 0, ScaleW(80), self.accessoryView.height)];
        _accessoryView.hidden = (self.accessoryType == LXY_ACCESSORYTYPENONE);
    }
    return _kLine_accessoryCoordinateView;
}


-(LXY_KLine_AccessoryLabelView *)kLine_accessoryLabelView
{
    if (nil == _kLine_accessoryLabelView) {
        _kLine_accessoryLabelView = [[LXY_KLine_AccessoryLabelView alloc]initWithFrame:CGRectMake(self.accessoryView.x, self.accessoryView.y - lxy_kLineView_Middle2, self.accessoryView.width, lxy_kLineView_Middle2)];
        _kLine_accessoryLabelView.hidden = (self.accessoryType == LXY_ACCESSORYTYPENONE);
    }
    return _kLine_accessoryLabelView;
}


#pragma mark 其余共用部分
-(LXY_KLineTimeLabel_View *)kLine_timeLabelView
{
    if (nil == _kLine_timeLabelView) {
        _kLine_timeLabelView = [[LXY_KLineTimeLabel_View alloc]initWithFrame:CGRectMake(self.kLine_MainView.x, self.kLine_VolumeView.bottom + 2, self.kLine_MainView.width, self.scrollView.height - self.kLine_MainView.bottom - 2)];
        _kLine_timeLabelView.backgroundColor = [UIColor clearColor];
    }
    return _kLine_timeLabelView;
}




- (LXY_KLine_TipView *)kLine_tipView
{
    if (nil == _kLine_tipView) {
        _kLine_tipView = [[LXY_KLine_TipView alloc]initWithFrame:CGRectMake(self.kLine_MainView.x, self.kLine_MainView.y, 100, 76)];
        _kLine_tipView.backgroundColor = [UIColor lxy_tipBgColor];
        _kLine_tipView.hidden = YES;
        
        _kLine_tipView.layer.borderWidth = 0.5;
        _kLine_tipView.layer.borderColor = kLineColor.CGColor;
    }
    return _kLine_tipView;
}


-(UIView *)longPress_VView1
{
    if (nil == _longPress_VView1) {
        _longPress_VView1 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, [LXY_KLinePositionTool kLineWidth], self.kLine_MainView.height)];
        _longPress_VView1.backgroundColor = [UIColor lxy_crossLineColor];
    }
    return _longPress_VView1;
}

-(UIView *)longPress_VView2
{
    if (nil == _longPress_VView2) {
        _longPress_VView2 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, self.kLine_VolumeView.height)];
        _longPress_VView2.backgroundColor = [UIColor lxy_crossLineColor];
    }
    return _longPress_VView2;
}
-(UIView *)longPress_VView3
{
    if (nil == _longPress_VView3) {
        _longPress_VView3 =[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0.5, self.accessoryView.height)];
        _longPress_VView3.backgroundColor = [UIColor lxy_crossLineColor];
    }
    return _longPress_VView3;
}

-(UIView *)longPress_HView
{
    if (nil == _longPress_HView) {
        _longPress_HView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.kLine_MainView.width, 1)];
        _longPress_HView.backgroundColor = [UIColor lxy_crossLineColor];
    }
    return _longPress_HView;
}





-(void)setAccessoryType:(LXY_ACCESSORYTYPE)accessoryType
{
    //    LXY_KLine_DataModel *lastModel;
    //    if (self.kLine_MainView.startDrawIndex + self.kLine_MainView.countOfShowCandle >= self.dataSource.count) {
    //        lastModel = self.dataSource.lastObject;
    //    }else{
    //        lastModel = self.dataSource[self.kLine_MainView.startDrawIndex + self.kLine_MainView.countOfShowCandle - 1];
    //    }
    
    LXY_KLine_DataModel *lastModel = self.dataSource.lastObject;
    _accessoryType = accessoryType;
    _accessoryView.accessoryType = accessoryType;
    self.kLine_accessoryLabelView.accessoryType = accessoryType;
    
    [self.kLine_accessoryLabelView showLabelWithModel:lastModel];
    
    if (accessoryType != LXY_ACCESSORYTYPENONE) {
        self.kLine_MainView.height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_Middle2 - lxy_kLineView_bottom) * (1 - 2 * lxy_kAccessaryScalw);
        self.kLine_PriceView.height = self.kLine_MainView.height;
        self.kLine_VolumeView.y = self.kLine_MainView.bottom + lxy_kLineView_Middle1;
        self.kLine_VolumeView.height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_Middle2 - lxy_kLineView_bottom) * lxy_kAccessaryScalw;
        self.kLine_volumeCoordinateView.height = self.kLine_VolumeView.height;
        self.accessoryView.height = self.kLine_VolumeView.height;
        self.accessoryView.hidden = NO;
        self.kLine_accessoryLabelView.hidden = NO;
        self.accessoryView.y = self.kLine_VolumeView.bottom + lxy_kLineView_Middle2;
        self.kLine_accessoryLabelView.y = self.accessoryView.y - 20;
        self.kLine_timeLabelView.y = self.accessoryView.bottom + 2;
        self.kLlie_volumeLabelView.y = self.kLine_MainView.bottom;
    }else{
        self.kLine_MainView.height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1  - lxy_kLineView_bottom) * lxy_kMainViewScale;
        self.kLine_PriceView.height = self.kLine_MainView.height;
        self.kLine_VolumeView.y = self.kLine_MainView.bottom + lxy_kLineView_Middle1;
        self.kLine_VolumeView.height = (self.height - lxy_kLineView_top - lxy_kLineView_Middle1 - lxy_kLineView_bottom) * (1 - lxy_kMainViewScale);
        self.kLine_volumeCoordinateView.height = self.kLine_VolumeView.height;
        self.accessoryView.hidden = YES;
        self.kLine_accessoryLabelView.hidden = YES;
        self.kLine_timeLabelView.y = self.kLine_VolumeView.bottom + 2;
        self.kLlie_volumeLabelView.y = self.kLine_MainView.bottom;
        
    }
    
    
    [self scrollViewDidScroll:self.scrollView];
    
}

-(void)setMainAccessoryType:(LXY_KMAINACCESSORYTYPE)mainAccessoryType
{
    _mainAccessoryType = mainAccessoryType;
    self.kLine_MainView.accessoryType = mainAccessoryType;
    self.kLineMAView.mainAccessoryType = mainAccessoryType;
    
    [self.kLineMAView showViewWith:self.dataSource.lastObject];
    [self.kLlie_volumeLabelView showLabelWithModel:self.dataSource.lastObject];
    [self scrollViewDidScroll:self.scrollView];
}



-(void)setData:(NSArray *)dataArray klineType:(LXY_KLINETYPE)klineType timeFormatter:(NSString *)timeFormatter
{
    self.formatterString = timeFormatter;
    //    self.scrollView.contentOffset = CGPointMake(0, 0);
    self.originalDataSource = [NSMutableArray arrayWithArray:dataArray];
    
    self.klineType = klineType;
    NSArray *array = [[dataArray reverseObjectEnumerator] allObjects];
    
    self.dataSource = [LXY_KLine_DataModel mj_objectArrayWithKeyValuesArray:array];
    
    [self startDrawView];
    
}


-(void)startDrawView
{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:self.formatterString];
    self.formatter = formatter;
    for (int i = 0; i < self.dataSource.count; i++) {
        LXY_KLine_DataModel *model = self.dataSource[i];
        if ([model.buy isEqual:[NSNull null]] || model.buy.doubleValue == 0) {
            model.buy = model.close;
        }
        
        if ([model.sell isEqual:[NSNull null]] || model.sell.doubleValue == 0) {
            model.sell = model.close;
        }
        
        model.totalVolume = model.volume;
        
        model.dataSource = self.dataSource;
        if (i == 0) {
            model.previousKlineModel = nil;
        }else{
            model.previousKlineModel = self.dataSource[i - 1];
            //            model.volume = [NSString stringWithFormat:@"%f",(model.totalVolume.doubleValue - model.previousKlineModel.totalVolume.doubleValue)];
        }
        
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:model.timestamp.doubleValue];
        
        NSString *time = [formatter stringFromDate:date];
        model.time = [formatter stringFromDate:date];
        //        if (i >= 4) {
        //            double ma5 = 0;
        //            for (int j = i; j > i - 5; j--) {
        //                LXY_KLine_DataModel *maModel = self.dataSource[j];
        //                ma5 += maModel.close.doubleValue;
        //            }
        //            model.ma5 = ma5 / 5.0;    // 五日均价
        ////            model.ma5Volume = model.ma5Volume / 5.0;    // 五日成交量均价
        //        }
        //        if (i >= 9) {
        //            double ma10 = 0;
        //            for (int j = i; j > i - 10; j--) {
        //                LXY_KLine_DataModel *maModel = self.dataSource[j];
        //                ma10 += maModel.close.doubleValue;
        //            }
        //            model.ma10 = ma10 / 10.0;    // 十日均价
        //        }
        //        if (i >= 19) {
        //            double ma20 = 0;
        //            for (int j = i; j > i - 20; j--) {
        //                LXY_KLine_DataModel *maModel = self.dataSource[j];
        //                ma20 += maModel.close.doubleValue;
        //            }
        //            model.ma20 = ma20 / 20.0;    // 二十日均价
        //        }
    }
    
    
    self.kLine_MainView.klineType = self.klineType;
    
    self.kLine_MainView.dataSource = self.dataSource;
    
    self.kLine_VolumeView.dataSource = self.dataSource;
    
    self.kLine_PriceView.dataSource = self.dataSource;
    
    [self.kLineMAView showViewWith:self.dataSource.lastObject];
    [self.kLlie_volumeLabelView showLabelWithModel:self.dataSource.lastObject];
    
    
    CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
    
    self.scrollView.contentSize = CGSizeMake(klineWidth * self.dataSource.count + self.scrollView.width / (LXY_NumberofTimeLine + 1), self.scrollView.height);
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.contentSize.width - self.scrollView.width, 0);
    [self scrollViewDidScroll:self.scrollView];
    

}

-(void)refreshWithSocketData:(LXY_KLine_DataModel *)socketModel minuteInvital:(NSInteger)minuteInvital
{
    LXY_KLine_DataModel *lastModel = self.dataSource.lastObject;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    NSDate *lastDate = [NSDate dateWithTimeIntervalSince1970:lastModel.timestamp.doubleValue];
    
    NSString *lastDateString = [formatter stringFromDate:lastDate];
    NSDate *lastDate1 = [formatter dateFromString:lastDateString];
    
    NSDate *socketDate = [NSDate dateWithTimeIntervalSince1970:socketModel.timestamp.doubleValue];
    
    NSTimeInterval second = [socketDate timeIntervalSinceDate:lastDate1];
    
    if (second / 60 >= minuteInvital && minuteInvital != 0) {
        
//        socketModel.open = socketModel.price;
//        socketModel.close = socketModel.price;
//        socketModel.high = socketModel.price;
//        socketModel.low = socketModel.price;
//        socketModel.timestamp = socketModel.timestamp;
//
//        socketModel.volume = lastModel.volume;
        [self.dataSource addObject:socketModel];
        
        [self startDrawView];
    }else{
        lastModel.close = socketModel.price;
        if (lastModel.low.doubleValue > socketModel.price.doubleValue) {
            lastModel.low = socketModel.price;
        }
        
        if (lastModel.high.doubleValue < socketModel.price.doubleValue) {
            lastModel.high = socketModel.price;
        }
        
        lastModel.buy = socketModel.buy;
        lastModel.sell = socketModel.sell;
        lastModel.volume = socketModel.volume;
        
        self.kLine_MainView.dataSource = self.dataSource;
        self.kLine_VolumeView.dataSource = self.dataSource;
        if (self.isShowLast) {
            [self scrollViewDidScroll:self.scrollView];
        }
    }
    
    
    
    
//    [self.currentPirceLineView setSocketPrice:socketModel.price];
    return;
    
    
    //    if (self.dataSource.count >= 5) {
    //        double ma5 = 0;
    //        for (NSInteger i = self.dataSource.count - 1; i >= self.dataSource.count - 5; i--) {
    //            LXY_KLine_DataModel *model = self.dataSource[i];
    //            ma5 += model.ma5;
    //        }
    //
    //        ma5 = ma5 / 5;
    //        socketModel.ma5 = ma5;
    //    }
    //
    //    if (self.dataSource.count >= 10) {
    //        double ma10 = 0;
    //        for (NSInteger i = self.dataSource.count - 1; i >= self.dataSource.count - 10; i--) {
    //            LXY_KLine_DataModel *model = self.dataSource[i];
    //            ma10 += model.ma10;
    //        }
    //
    //        ma10 = ma10 / 10;
    //        socketModel.ma10 = ma10;
    //    }
    //
    //    if (self.dataSource.count >= 20) {
    //        double ma20 = 0;
    //        for (NSInteger i = self.dataSource.count - 1; i >= self.dataSource.count - 20; i--) {
    //            LXY_KLine_DataModel *model = self.dataSource[i];
    //            ma20 += model.ma20;
    //        }
    //
    //        ma20 = ma20 / 20;
    //        socketModel.ma20 = ma20;
    //    }
    //
    //
    //    NSTimeInterval timeInterval = [WLTools timeIntervalWithFromTime:lastModel.datetime toTime:socketModel.datetime];
    //
    //    if (timeInterval >= self.refreshTimeCount && self.refreshTimeCount != 0) {
    //        [self.dataSource addObject:socketModel];
    //        CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
    //        self.scrollView.contentSize = CGSizeMake(klineWidth * self.dataSource.count, 0);
    //        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - self.scrollView.width, 0, self.scrollView.width, self.scrollView.height) animated:YES];
    //    }else{
    //
    //        [self.dataSource replaceObjectAtIndex:self.dataSource.count - 1 withObject:socketModel];
    //        if (self.isShowLast) {
    //            [self scrollViewDidScroll:self.scrollView];
    //        }
    //    }
    //
    
}

- (void)setCurrentPrice:(NSString *)price{
    [self.currentPirceLineView setSocketPrice:price];

}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.dataSource.count == 0) {
        self.currentPirceLineView.hidden = YES;
    }else{
        self.currentPirceLineView.hidden = NO;
    }
    if (self.dataSource.count == 0) {
        return;
    }
    
    CGFloat startX  = scrollView.contentOffset.x;
    if (startX < 0) {
        startX = 0;
        //        return;
    }
    
    if (startX > scrollView.contentSize.width - scrollView.width) {
        startX = scrollView.contentSize.width - scrollView.width;
        if (startX < 0) {
            startX = 0;
        }
        //        return;
    }
    
    
    
    CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
    
    
    CGFloat lastModelX = klineWidth * self.dataSource.count;
    
    NSInteger lastIndex = 0;
    NSInteger visiableCount = 0;
    
    if (lastModelX > self.scrollView.contentOffset.x + self.scrollView.width) {
        lastIndex = (self.scrollView.contentOffset.x + self.scrollView.width) / klineWidth;
        visiableCount = self.scrollView.width / (klineWidth);
        self.kLine_MainView.scrollGap = [LXY_KLinePositionTool kLineWidth] / 2;
        self.kLine_VolumeView.scrollGap = [LXY_KLinePositionTool kLineWidth] / 2;
        
    }else{
        lastIndex = self.dataSource.count - 1;
        visiableCount = (lastModelX + [LXY_KLinePositionTool kLineWidth]  - self.scrollView.contentOffset.x) / klineWidth;
        self.kLine_MainView.scrollGap = self.scrollView.contentOffset.x + self.scrollView.width - lastModelX;
        self.kLine_VolumeView.scrollGap = self.scrollView.contentOffset.x + self.scrollView.width - lastModelX;
        
    }
    
    self.kLine_timeLabelView.scrollGap = self.kLine_MainView.scrollGap;
    
    
    
    //    NSInteger visiableNumber = (NSInteger) ((self.kLine_MainView.width + [LXY_KLinePositionTool kLineGap]) / (klineWidth));
    NSInteger visiableNumber = visiableCount;
    NSInteger startDrawIndex = lastIndex - visiableCount + 1;
    
    //    NSInteger startDrawIndex = (NSInteger)((startX) / klineWidth  + 0.5);
    
    if (startDrawIndex < 0) {
        startDrawIndex = 0;
    }
    
    if (startDrawIndex + visiableNumber > self.dataSource.count) {
        visiableNumber = self.dataSource.count - startDrawIndex;
    }
    
    if (visiableNumber > self.dataSource.count) {
        visiableNumber = self.dataSource.count;
    }
    
    if (startDrawIndex + visiableNumber >= self.dataSource.count) {
        self.isShowLast = YES;
    }else{
        self.isShowLast = NO;
    }
    
    
    self.kLine_MainView.startDrawIndex = startDrawIndex;
    self.kLine_MainView.countOfShowCandle = visiableNumber;
    
    self.kLine_VolumeView.dataSource = self.dataSource;
    self.kLine_VolumeView.startDrawIndex = startDrawIndex;
    self.kLine_VolumeView.countOfShowCandle = visiableNumber;
    
    self.kLine_PriceView.dataSource = self.dataSource;
    self.kLine_timeLabelView.dataSource = self.dataSource;
    self.kLine_PriceView.startDrawIndex = startDrawIndex;
    self.kLine_PriceView.countOfShowCandle = visiableNumber;
    self.kLine_timeLabelView.startDrawIndex = self.kLine_MainView.startDrawIndex;
    //    self.kLine_timeLabelView.scrollGap = self.scrollView.width / 4 - (self.scrollView.contentSize.width - self.scrollView.contentOffset.x - self.scrollView.width);
    self.kLine_timeLabelView.countOfShowCandle = self.kLine_MainView.countOfShowCandle;
    
    self.accessoryView.dataSource = self.dataSource;
    self.accessoryView.startDrawIndex = startDrawIndex;
    self.accessoryView.countOfShowCandle = visiableNumber;
    self.kLine_accessoryCoordinateView.dataSource = self.dataSource;
    self.kLine_accessoryCoordinateView.startDrawIndex = startDrawIndex;
    self.kLine_accessoryCoordinateView.countOfShowCandle = visiableNumber;
    
    [self.kLine_MainView drawView];
    [self.kLine_VolumeView drawView];
    //    [self.kLine_timeLabelView drawView];
    [self.accessoryView drawView];
    [self.kLine_accessoryCoordinateView drawView];
}


#pragma mark - 手势

#pragma mark 缩放
-(void)pinEvent:(UIPinchGestureRecognizer *)pinGesture
{
    //    CGPoint touchPoint = [pinGesture locationInView:self];
    
    static CGFloat oldScale = 1.0f;
    CGFloat difValue = pinGesture.scale - oldScale;
    if(ABS(difValue) > 0.01) {
        CGFloat oldKLineWidth = [LXY_KLinePositionTool kLineWidth];
        
        [LXY_KLinePositionTool setkLineWith:oldKLineWidth * (difValue > 0 ? (1 + 0.02) : (1 - 0.02))];
        oldScale = pinGesture.scale;
        
        if( pinGesture.numberOfTouches == 2 ) {
            CGPoint p1 = [pinGesture locationOfTouch:0 inView:self.scrollView];
            CGPoint p2 = [pinGesture locationOfTouch:1 inView:self.scrollView];
            CGPoint centerPoint = CGPointMake((p1.x+p2.x)/2, (p1.y+p2.y)/2);
            NSUInteger oldLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [LXY_KLinePositionTool kLineGap]) / ([LXY_KLinePositionTool kLineGap] + oldKLineWidth);
            NSUInteger newLeftArrCount = ABS((centerPoint.x - self.scrollView.contentOffset.x) - [LXY_KLinePositionTool kLineGap]) / ([LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth]);
            
            
            
            self.kLine_MainView.startDrawIndex = self.kLine_MainView.startDrawIndex + (oldLeftArrCount - newLeftArrCount);
            if (self.kLine_MainView.startDrawIndex < 0) {
                self.kLine_MainView.startDrawIndex = 0;
            }
            CGFloat klineWidth = [LXY_KLinePositionTool kLineGap] + [LXY_KLinePositionTool kLineWidth];
            NSInteger visiableNumber = (NSInteger) ((self.kLine_MainView.width + [LXY_KLinePositionTool kLineGap]) / (klineWidth));
            
            self.scrollView.contentSize = CGSizeMake(klineWidth * self.dataSource.count + self.scrollView.width / (LXY_NumberofTimeLine + 1), self.scrollView.height);
            self.scrollView.contentOffset = CGPointMake(self.kLine_MainView.startDrawIndex * klineWidth, 0);
            
            //            if (self.kLine_MainView.startDrawIndex + visiableNumber > self.dataSource.count) {
            //                //                visiableNumber = self.dataSource.count - self.kLine_MainView.startDrawIndex;
            //                //                self.kLine_MainView.startDrawIndex = self.dataSource.count - visiableNumber;
            //                visiableNumber = self.dataSource.count - self.kLine_MainView.startDrawIndex;
            //            }
            //
            //            self.kLine_MainView.countOfShowCandle = visiableNumber;
            //
            //            if (self.kLine_MainView.startDrawIndex + visiableNumber >= self.dataSource.count) {
            //                self.isShowLast = YES;
            //            }else{
            //                self.isShowLast = NO;
            //            }
            //
            //            self.kLine_VolumeView.startDrawIndex = self.kLine_MainView.startDrawIndex;
            //            self.kLine_VolumeView.countOfShowCandle = self.kLine_MainView.countOfShowCandle;
            //
            //            self.accessoryView.startDrawIndex = self.kLine_MainView.startDrawIndex;
            //            self.accessoryView.countOfShowCandle = self.kLine_MainView.countOfShowCandle;
            //
            //            [self.kLine_MainView drawView];
            //            [self.kLine_VolumeView drawView];
            //            [self.accessoryView drawView];
            
            [self scrollViewDidScroll:self.scrollView];
        }
        
    }
    
    
    
}

#pragma makr - 长按
-(void)longPressEvent:(UILongPressGestureRecognizer *)longPressGesture
{
    static NSInteger lastIndex = 0;
    
    CGPoint point = [longPressGesture locationInView:self.kLine_MainView];
    
    //    NSInteger index = point.x  / ([LXY_KLinePositionTool kLineWidth] + [LXY_KLinePositionTool kLineGap]);
    
    NSInteger index = [self.kLine_MainView indexWithPositionX:point.x];
    
    if (index >= self.dataSource.count && longPressGesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if (index < 0) {
        return;
    }
    
    LXY_KLine_StockChartPositionModel *positionModel = [self.kLine_MainView positionModelWithIndex:index];
    
    LXY_KLine_DataModel *klineModel = self.dataSource[index];
    
    if (UIGestureRecognizerStateChanged == longPressGesture.state || UIGestureRecognizerStateBegan == longPressGesture.state) {
        if (index == lastIndex && longPressGesture.state != UIGestureRecognizerStateBegan) {
            return;
        }else{
            lastIndex = index;
        }
        [self showCrossViewWith:positionModel];
        [self.kLineMAView showViewWith:klineModel];
        [self.kLine_PriceView longPressWithModel:klineModel positionY:positionModel.closeY];
        [self.kLine_timeLabelView longPressWithModel:klineModel positionX:positionModel.centerX];
        self.kLine_tipView.hidden = NO;
        if (positionModel.centerX < self.kLine_MainView.width / 2) {
            self.kLine_tipView.x = self.kLine_MainView.right - self.kLine_tipView.width;
        }else{
            self.kLine_tipView.x = self.kLine_MainView.x;
        }
        [self.kLine_tipView showTipViewWith:klineModel];
        if (self.accessoryView.accessoryType != LXY_ACCESSORYTYPENONE) {
            [self.kLine_accessoryLabelView showLabelWithModel:klineModel];
        }
        [self.kLlie_volumeLabelView showLabelWithModel:klineModel];
        
    }else{
        [self hideCrossView];
        //        [self.kLineMAView hideView];
        [self.kLine_PriceView hideLongPressLabel];
        [self.kLine_timeLabelView hideLongPressLabel];
        self.kLine_tipView.hidden = YES;
        //        self.kLine_accessoryLabelView.hidden = YES;
        
        //        LXY_KLine_DataModel *lastModel;
        //        if (self.kLine_MainView.startDrawIndex + self.kLine_MainView.countOfShowCandle >= self.dataSource.count) {
        //        }else{
        //            lastModel = self.dataSource[self.kLine_MainView.startDrawIndex + self.kLine_MainView.countOfShowCandle - 1];
        //        }
        LXY_KLine_DataModel *lastModel = self.dataSource.lastObject;
        
        if (self.accessoryView.accessoryType != LXY_ACCESSORYTYPENONE) {
            [self.kLine_accessoryLabelView showLabelWithModel:lastModel];
        }
        
        if (self.kLine_MainView.accessoryType != LXY_KMAINACCESSORYTYPENONE) {
            [self.kLineMAView showViewWith:self.dataSource.lastObject];
        }
        
        [self.kLlie_volumeLabelView showLabelWithModel:lastModel];
    }
}


-(void)tapEvent:(UITapGestureRecognizer *)tapGesture
{
    static NSInteger lastIndex = 0;
    
    CGPoint point = [tapGesture locationInView:self.kLine_MainView];
    
    //    NSInteger index = point.x  / ([LXY_KLinePositionTool kLineWidth] + [LXY_KLinePositionTool kLineGap]);
    
    NSInteger index = [self.kLine_MainView indexWithPositionX:point.x];
    
    if (index >= self.dataSource.count && tapGesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if (index < 0) {
        return;
    }
    
    if (self.kLine_tipView.hidden == YES) {
        LXY_KLine_StockChartPositionModel *positionModel = [self.kLine_MainView positionModelWithIndex:index];
        
        LXY_KLine_DataModel *klineModel = self.dataSource[index];
        
        [self showCrossViewWith:positionModel];
        [self.kLineMAView showViewWith:klineModel];
        [self.kLine_PriceView longPressWithModel:klineModel positionY:positionModel.closeY];
        [self.kLine_timeLabelView longPressWithModel:klineModel positionX:positionModel.centerX];
        self.kLine_tipView.hidden = NO;
        if (positionModel.centerX < self.kLine_MainView.width / 2) {
            self.kLine_tipView.x = self.kLine_MainView.right - self.kLine_tipView.width;
        }else{
            self.kLine_tipView.x = self.kLine_MainView.x;
        }
        [self.kLine_tipView showTipViewWith:klineModel];
        if (self.accessoryView.accessoryType != LXY_ACCESSORYTYPENONE) {
            [self.kLine_accessoryLabelView showLabelWithModel:klineModel];
        }
        [self.kLlie_volumeLabelView showLabelWithModel:klineModel];
        
        [_scrollView addGestureRecognizer:self.panGesture];

    }else{
        [self hideCrossView];
        //        [self.kLineMAView hideView];
        [self.kLine_PriceView hideLongPressLabel];
        [self.kLine_timeLabelView hideLongPressLabel];
        self.kLine_tipView.hidden = YES;
        //        self.kLine_accessoryLabelView.hidden = YES;
        
        //        LXY_KLine_DataModel *lastModel;
        //        if (self.kLine_MainView.startDrawIndex + self.kLine_MainView.countOfShowCandle >= self.dataSource.count) {
        //        }else{
        //            lastModel = self.dataSource[self.kLine_MainView.startDrawIndex + self.kLine_MainView.countOfShowCandle - 1];
        //        }
        LXY_KLine_DataModel *lastModel = self.dataSource.lastObject;
        
        if (self.accessoryView.accessoryType != LXY_ACCESSORYTYPENONE) {
            [self.kLine_accessoryLabelView showLabelWithModel:lastModel];
        }
        
        if (self.kLine_MainView.accessoryType != LXY_KMAINACCESSORYTYPENONE) {
            [self.kLineMAView showViewWith:self.dataSource.lastObject];
        }
        
        [self.kLlie_volumeLabelView showLabelWithModel:lastModel];
        
        [_scrollView removeGestureRecognizer:self.panGesture];
    }
    
    
    
}

-(void)panEvent:(UIPanGestureRecognizer *)panGesture
{
    static NSInteger lastIndex = 0;
    
    CGPoint point = [panGesture locationInView:self.kLine_MainView];
    
    //    NSInteger index = point.x  / ([LXY_KLinePositionTool kLineWidth] + [LXY_KLinePositionTool kLineGap]);
    
    NSInteger index = [self.kLine_MainView indexWithPositionX:point.x];
    
    if (index >= self.dataSource.count && panGesture.state != UIGestureRecognizerStateEnded) {
        return;
    }
    
    if (index < 0) {
        return;
    }
    
    LXY_KLine_StockChartPositionModel *positionModel = [self.kLine_MainView positionModelWithIndex:index];
    
    LXY_KLine_DataModel *klineModel = self.dataSource[index];
    
    [self showCrossViewWith:positionModel];
    [self.kLineMAView showViewWith:klineModel];
    [self.kLine_PriceView longPressWithModel:klineModel positionY:positionModel.closeY];
    [self.kLine_timeLabelView longPressWithModel:klineModel positionX:positionModel.centerX];
    self.kLine_tipView.hidden = NO;
    if (positionModel.centerX < self.kLine_MainView.width / 2) {
        self.kLine_tipView.x = self.kLine_MainView.right - self.kLine_tipView.width;
    }else{
        self.kLine_tipView.x = self.kLine_MainView.x;
    }
    [self.kLine_tipView showTipViewWith:klineModel];
    if (self.accessoryView.accessoryType != LXY_ACCESSORYTYPENONE) {
        [self.kLine_accessoryLabelView showLabelWithModel:klineModel];
    }
    [self.kLlie_volumeLabelView showLabelWithModel:klineModel];
}


#pragma mark - 显示十字线
-(void)showCrossViewWith:(LXY_KLine_StockChartPositionModel *)positionModel
{
    self.longPress_VView1.height = self.kLine_MainView.height;
    [self.kLine_MainView addSubview:self.longPress_VView1];
    self.longPress_VView1.width = [LXY_KLinePositionTool kLineWidth];
    self.longPress_VView1.centerX = positionModel.centerX;
    [self.kLine_MainView addSubview:self.longPress_HView];
    self.longPress_HView.y = positionModel.closeY;
//    self.longPress_HView.hidden = YES;
    
    self.longPress_VView2.height = self.kLine_VolumeView.height;
    self.longPress_VView2.width = [LXY_KLinePositionTool kLineWidth];
    [self.kLine_VolumeView addSubview:self.longPress_VView2];
    self.longPress_VView2.centerX = positionModel.centerX;
    
    self.longPress_VView3.height = self.accessoryView.height;
    self.longPress_VView3.width = [LXY_KLinePositionTool kLineWidth];
    [self.accessoryView addSubview:self.longPress_VView3];
    self.longPress_VView3.centerX = positionModel.centerX;
}

#pragma mark - 隐藏十字线
-(void)hideCrossView
{
    [self.longPress_VView1 removeFromSuperview];
    [self.longPress_HView removeFromSuperview];
    [self.longPress_VView2 removeFromSuperview];
    [self.longPress_VView3 removeFromSuperview];
    
}

#pragma mark - k线图绘制回调 LXY_KLine_MineView_Porotcol

-(void)getMaxPrice:(double)maxprice minPirce:(double)minPrice lastModel:(nonnull LXY_KLine_DataModel *)model lastPositionModel:(nonnull LXY_KLine_StockChartPositionModel *)lastPositionModel
{
    self.kLine_PriceView.maxPrice = maxprice;
    self.kLine_PriceView.minPrice = minPrice;
    self.kLine_PriceView.coinName = model.name?:@"";
    
    WS(weakSelf);
    
    //    dispatch_async(dispatch_get_main_queue(), ^{
    [self.kLine_PriceView drawView];
    //    });
    
    [self.kLine_timeLabelView drawView];
    
    
}

#pragma mark - k线图绘制成交量回调 LXY_KLine_VolumeView_Porotcol
-(void)getMaxVolume:(double)maxVolume minVolume:(double)minVolume
{
    self.kLine_volumeCoordinateView.maxVolume = maxVolume;
    self.kLine_volumeCoordinateView.minVolume = minVolume;
    WS(weakSelf);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.kLine_volumeCoordinateView drawView];
    });
}


-(void)drawFinishedWithLastModel:(LXY_KLine_DataModel *)model lastPositionModel:(LXY_KLine_StockChartPositionModel *)positionModel lastIndex:(NSInteger)index
{
    WS(weakSelf);
    [UIView animateWithDuration:0.1 animations:^{
        LXY_KLine_DataModel *dataModel = self.dataSource.lastObject;
        LXY_KLine_StockChartPositionModel *lastPositionModel = positionModel;
        if (index >= self.dataSource.count) {
            //            lastPositionModel = self.dataSource.lastObject;
        }
        LXY_KLine_DataModel *model = self.dataSource.lastObject;
        
        CGFloat xx = self.scrollView.width - self.scrollView.width / 4;
        if (positionModel.centerX >= self.kLine_MainView.width - 1.5 * ([LXY_KLinePositionTool kLineWidth] + [LXY_KLinePositionTool kLineGap])) {
            weakSelf.currentPirceLineView.centerY = self.kLine_MainView.height - 30;
            [weakSelf.currentPirceLineView setCurrentPriceWithPositionY:self.kLine_MainView.height - 30 positionX:positionModel.centerX isLast:weakSelf.isShowLast currentPrice:model.close];
            [weakSelf.kLine_PriceView hideCurrentPriceLabel];
        }else{
            weakSelf.currentPirceLineView.centerY = positionModel.closeY;
            [weakSelf.currentPirceLineView setCurrentPriceWithPositionY:positionModel.closeY positionX:positionModel.centerX isLast:weakSelf.isShowLast currentPrice:model.close];
            weakSelf.kLine_PriceView.lastModel = model;
            weakSelf.kLine_PriceView.lastPositionModel = positionModel;
            [weakSelf.kLine_PriceView refreshCurrentPricelabel];
        }
        
    }];
    
}

#pragma mark - k线图绘制回调 LXY_KLine_Accessory_Porotcol

-(void)getMaxValue:(double)maxValue minValue:(double)minValue
{
    self.kLine_accessoryCoordinateView.maxValue = maxValue;
    self.kLine_accessoryCoordinateView.minValue = minValue;
    WS(weakSelf);
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.kLine_accessoryCoordinateView drawView];
    });
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
