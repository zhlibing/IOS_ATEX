//
//  BFEXRecordOptionView.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BFEXRecordOptionItemControl.h"



NS_ASSUME_NONNULL_BEGIN

@interface BFEXRecordOptionView : UIView


@property (nonatomic, strong) BFEXRecordOptionItemControl *oneControl; //!< 第一个
@property (nonatomic, strong) BFEXRecordOptionItemControl *twoControl; //!< 第二个
@property (nonatomic, strong) BFEXRecordOptionItemControl *threeControl; //!< 第三个
@property (nonatomic, strong) UIView *lineView;  //!< 分割线



-(void)resetFrame:(CGRect)frame;






@end

NS_ASSUME_NONNULL_END
