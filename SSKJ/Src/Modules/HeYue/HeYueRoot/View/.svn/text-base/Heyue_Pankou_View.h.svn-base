//
//  Heyue_Pankou_View.h
//  SSKJ
//
//  Created by 赵亚明 on 2019/7/26.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PanKou_Socket_Model.h"

#import "SSKJ_Market_Index_Model.h"


NS_ASSUME_NONNULL_BEGIN

@interface Heyue_Pankou_View : UIView

@property (nonatomic,copy) void (^CurrentPriceBlock)(NSString *price);

/**
 盘口数据
 */
@property (nonatomic,strong) PanKou_Socket_Model *pankouModel;
/**
 币种
 */
@property (nonatomic, strong) SSKJ_Market_Index_Model *model;
@end

NS_ASSUME_NONNULL_END
