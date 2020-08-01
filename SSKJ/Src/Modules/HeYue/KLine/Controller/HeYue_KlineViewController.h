//
//  HeYue_KlineViewController.h
//  SSKJ
//
//  Created by zhao on 2019/8/28.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
#import "SSKJ_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface HeYue_KlineViewController : SSKJ_BaseViewController
@property (nonatomic, assign) BOOL isNeedPop;

@property (nonatomic, strong) SSKJ_Market_Index_Model *coinModel;


@end
/*
 K线类型（minute，minute5，minute15，minute30，minute60，day，hour4，week，month）
 */

typedef NS_ENUM(NSInteger, kLineType) {
    kLineTypeNone,
    kLineTypeMinute,
    kLineTypeMinute5,
    kLineTypeMinute15,
    kLineTypeMinute30,
    kLineTypeMinute60,
    kLineTypeHour4,
    kLineTypeDay,
    kLineTypeWeek,
    kLineTypeMonth
};

@interface kLineTypeModel : NSObject

@property(nonatomic)kLineType type;
@property(nonatomic)NSInteger viewType;//线图
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *typeString;
@property(nonatomic, copy)NSString *timeFormatter;
@property(nonatomic)NSInteger minute;




@end
NS_ASSUME_NONNULL_END
