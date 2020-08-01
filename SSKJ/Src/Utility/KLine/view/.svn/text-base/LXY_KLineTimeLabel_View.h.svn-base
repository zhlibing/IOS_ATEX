//
//  LXY_KLineTimeLabel_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LXY_KLine_DataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLineTimeLabel_View : UIView
// 开始绘制的K线的下标
@property (nonatomic, assign) NSInteger startDrawIndex;
// 当前显示的K线点数量
@property (nonatomic, assign) NSInteger countOfShowCandle;

@property (nonatomic, assign) CGFloat scrollGap;
@property (nonatomic, strong) NSMutableArray<LXY_KLine_DataModel *> *dataSource;

-(void)longPressWithModel:(LXY_KLine_DataModel *)model positionX:(CGFloat)positionX;

-(void)hideLongPressLabel;

-(void)drawView;

@end

NS_ASSUME_NONNULL_END
