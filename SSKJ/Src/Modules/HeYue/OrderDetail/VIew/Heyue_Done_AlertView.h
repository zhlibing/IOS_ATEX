//
//  Heyue_Done_AlertView.h
//  SSKJ
//
//  Created by zpz on 2019/9/18.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Heyue_OrderDdetail_Model.h"


NS_ASSUME_NONNULL_BEGIN

@interface Heyue_Done_AlertView : UIView

@property (nonatomic, copy) void (^DoneBlock)(Heyue_OrderDdetail_Model *weituoModel);

- (void)initDataWithWeituoModel:(Heyue_OrderDdetail_Model *)weituoModel;

- (void)showAlertView;

@property (nonatomic, strong) NSString *nePrice;

@end

NS_ASSUME_NONNULL_END
