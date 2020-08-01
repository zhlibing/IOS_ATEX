//
//  BFEXRecordOptionItemControl.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BFEXRecordOptionItemControl : UIControl


@property (nonatomic, strong) UILabel *titleLabel; //!< 标题标签

-(void)resetFrame:(CGRect)frame;


//!< 设置选中状态
-(void)setItemSelect:(BOOL)select;

@end

NS_ASSUME_NONNULL_END
