//
//  Heyue_Root_Cangwei_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_Root_Cangwei_View : UIView

@property (nonatomic,strong) UITextField * numberTextField;

@property (nonatomic,copy) void (^CangweiBlock)(CGFloat cangwei);

@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) UILabel *numberTitle;
//1.做多  2.做空
@property (nonatomic, assign) NSInteger isBuySell;
@end

NS_ASSUME_NONNULL_END
