//
//  LXY_KLine_AccessoryView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/29.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_DataModel.h"
#import "LXY_KLine_AccessoryLabelView.h"




@protocol LXY_KLine_Accessory_Porotcol <NSObject>

-(void)getMaxValue:(double)maxValue minValue:(double)minValue;

@end


NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLine_AccessoryView : UIView

@property (nonatomic, assign) LXY_ACCESSORYTYPE accessoryType;

// 开始绘制的K线的下标
@property (nonatomic, assign) NSInteger startDrawIndex;
// 当前显示的K线点数量
@property (nonatomic, assign) NSInteger countOfShowCandle;

@property (nonatomic, strong) NSMutableArray<LXY_KLine_DataModel *> *dataSource;

@property (nonatomic, weak) id <LXY_KLine_Accessory_Porotcol> delegate;


-(void)drawView;

@end

NS_ASSUME_NONNULL_END
