//
//  LXY_KLine_VolumeView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/22.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXY_KLine_DataModel.h"


NS_ASSUME_NONNULL_BEGIN


@protocol LXY_KLine_VolumeView_Porotcol <NSObject>

-(void)getMaxVolume:(double)maxVolume minVolume:(double)minVolume;

@end

@interface LXY_KLine_VolumeView : UIView

//@property (nonatomic, assign) LXY_KLINETYPE klineType;
// 开始绘制的K线的下标
@property (nonatomic, assign) NSInteger startDrawIndex;
// 当前显示的K线点数量
@property (nonatomic, assign) NSInteger countOfShowCandle;

@property (nonatomic, assign) double scrollGap;


@property (nonatomic, strong) NSMutableArray<LXY_KLine_DataModel *> *dataSource;

@property (nonatomic, weak) id <LXY_KLine_VolumeView_Porotcol> delegate;


-(void)drawView;

@end

NS_ASSUME_NONNULL_END
