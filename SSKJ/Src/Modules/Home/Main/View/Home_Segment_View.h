//
//  FBDeal_Segment_Control.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2018/9/11.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Home_Segment_View : UIView
@property (nonatomic, strong) UIImageView *lineView;

@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, copy) BOOL (^selectedIndexBlock)(NSInteger index);
@property (nonatomic,copy)void(^loginBlock)(void);

-(instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles normalColor:(UIColor *)normalColor selectedColor:(UIColor *)selectedColor fontSize:(CGFloat)fontSize;

@end
