//
//  ETF_BBTrade_MoreSegment_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/28.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_BBTrade_MoreSegment_View : UIView
@property (nonatomic, strong) NSArray *titlesArray;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^selectBlock)(NSInteger index,NSString *title);
@end

NS_ASSUME_NONNULL_END
