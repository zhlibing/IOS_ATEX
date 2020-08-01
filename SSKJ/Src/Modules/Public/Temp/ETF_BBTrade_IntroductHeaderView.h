//
//  ETF_BBTrade_IntroductHeaderView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_BBTrade_IntroductHeaderView : UIView

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^segmentSelectBlock)(NSInteger index);

- (void)changeUI;

@end

NS_ASSUME_NONNULL_END
