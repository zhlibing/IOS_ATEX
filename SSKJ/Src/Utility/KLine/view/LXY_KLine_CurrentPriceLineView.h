//
//  LXY_KLine_CurrentPriceLineView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/26.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLine_CurrentPriceLineView : UIView

@property (nonatomic, copy) void (^toLastBlock)(void);

-(void)setCurrentPriceWithPositionY:(CGFloat)positionY positionX:(CGFloat)positionX isLast:(BOOL)isLast currentPrice:(NSString *)currentPrice;

-(void)setSocketPrice:(NSString *)socketPrice;

@end

NS_ASSUME_NONNULL_END
