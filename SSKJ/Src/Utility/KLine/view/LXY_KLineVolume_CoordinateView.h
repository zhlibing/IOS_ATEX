//
//  LXY_KLineVolume_CoordinateView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLineVolume_CoordinateView : UIView
// 最大成交量
@property (nonatomic, assign) double maxVolume;

// 最小成交量
@property (nonatomic, assign) double minVolume;

-(void)drawView;
@end

NS_ASSUME_NONNULL_END
