//
//  BSafeCenterCell.h
//  ZYW_MIT
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BLLabel.h"
@interface BLSafeCenterCell : UITableViewCell

@property (nonatomic, copy) void (^switchBlock)(BOOL selected);

@property (nonatomic, assign) BOOL zhiwenSelected;

@property (weak, nonatomic) IBOutlet UIImageView *swithImageView;

@property (weak, nonatomic) IBOutlet BLLabel *cellTitle;

@property (weak, nonatomic) IBOutlet BLLabel *status;



@end
