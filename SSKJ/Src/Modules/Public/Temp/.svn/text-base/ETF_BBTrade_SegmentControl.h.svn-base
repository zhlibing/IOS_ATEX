//
//  ETF_BBTrade_SegmentControl.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/5/8.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ETF_BBTrade_SegmentControl : UIView
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) void (^selectedIndexBlock)(NSInteger index);
@property (nonatomic, copy) void (^moreBlock)(void);
@property (nonatomic, copy) void (^zhibiaoBlock)(void);

-(void)setMoreWithTitle:(NSString *)title;

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
