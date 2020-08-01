//
//  LXY_KLine_MAView.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/10/25.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LXY_KLine_DataModel.h"
#import "LXY_KLine_MainView.h"



NS_ASSUME_NONNULL_BEGIN

@interface LXY_KLine_MAView : UIView
@property (nonatomic, assign) LXY_KMAINACCESSORYTYPE mainAccessoryType;
-(void)showViewWith:(LXY_KLine_DataModel *)model;
-(void)hideView;
@end

NS_ASSUME_NONNULL_END
