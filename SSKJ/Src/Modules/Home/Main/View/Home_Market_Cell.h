//
//  HeBi_Market_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/9.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_Market_Index_Model.h"

NS_ASSUME_NONNULL_BEGIN

@interface Home_Market_Cell : UITableViewCell
-(void)setCellWithModel:(SSKJ_Market_Index_Model *)model;
@end

NS_ASSUME_NONNULL_END
