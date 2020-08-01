//
//  My_Generalize_Cell.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/29.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_baseTableViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface My_Generalize_Cell : SSKJ_baseTableViewCell
@property (nonatomic, copy) NSString *title;
@property (nonatomic, strong) UIView *lineView;

@end

NS_ASSUME_NONNULL_END
