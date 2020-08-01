//
//  XBTextLoopView.h
//  文字轮播
//
//  Created by 周旭斌 on 2017/4/9.
//  Copyright © 2017年 周旭斌. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^selectTextBlock)(NSString *selectString, NSInteger index);
typedef void(^timeSelectedTextBlock)(NSInteger index);

@interface XBTextLoopView : UIView
@property (nonatomic, copy) timeSelectedTextBlock timeSelectedBlock;


/**
 直接调用这个方法

 @param dataSource 数据源
 @param timeInterval 时间间隔,默认是1.0秒
 @param frame 控件大小
 */
+ (instancetype)textLoopViewWith:(NSArray *)dataSource loopInterval:(NSTimeInterval)timeInterval initWithFrame:(CGRect)frame selectBlock:(selectTextBlock)selectBlock;
@property (nonatomic, copy) void(^currentIndexBlock)(NSInteger index);
@property (nonatomic, strong) UIColor *contentColor;
@end
