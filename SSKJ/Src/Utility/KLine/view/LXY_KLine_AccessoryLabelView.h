//
//  LXY_KLine_AccessoryLabelView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/11/9.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_DataModel.h"



typedef NS_ENUM(NSUInteger, LXY_ACCESSORYTYPE) {            // 指标类型
    LXY_ACCESSORYTYPENONE,      // 没有指标
    LXY_ACCESSORYTYPEMACD,      // MACD指标
    LXY_ACCESSORYTYPEKDJ,       // KDJ指标
    LXY_ACCESSORYTYPERSI,       // RSI指标
    LXY_ACCESSORYTYPEWR,        // WR指标
};


NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLine_AccessoryLabelView : UIView

@property (nonatomic, assign) LXY_ACCESSORYTYPE accessoryType;

-(void)showLabelWithModel:(LXY_KLine_DataModel *)model;
@end

NS_ASSUME_NONNULL_END
