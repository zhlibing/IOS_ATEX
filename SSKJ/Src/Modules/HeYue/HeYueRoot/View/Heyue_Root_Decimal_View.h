//
//  Heyue_Root_Decimal_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Heyue_Root_Decimal_View : UIView

@property (nonatomic,strong) UIButton * baocangBtn;
@property (nonatomic,copy) void (^HeyueBaoCangBlock)(void);

@end

NS_ASSUME_NONNULL_END
