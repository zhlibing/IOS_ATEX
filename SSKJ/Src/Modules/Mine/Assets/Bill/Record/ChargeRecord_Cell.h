//
//  ChargeRecord_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/16.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATEX_Charge_IndexModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface ChargeRecord_Cell : UITableViewCell
-(void)setCellWithModel:(ATEX_Charge_IndexModel *)model;
@end

NS_ASSUME_NONNULL_END
