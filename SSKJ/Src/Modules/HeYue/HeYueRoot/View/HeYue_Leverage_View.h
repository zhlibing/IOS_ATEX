//
//  HeYue_Leverage_View.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/4/1.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^XuanZeLeverageBlock)(NSString *date);


@interface HeYue_Leverage_View : UIView

@property (nonatomic,copy) XuanZeLeverageBlock levetageBlock;


@property (nonatomic,strong) NSArray * dataArr;

@end

NS_ASSUME_NONNULL_END
