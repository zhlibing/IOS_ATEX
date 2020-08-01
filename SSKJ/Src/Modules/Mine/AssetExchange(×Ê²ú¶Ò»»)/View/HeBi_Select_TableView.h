//
//  HeBi_Select_TableView.h
//  SSKJ
//
//  Created by 刘小雨 on 2019/4/16.
//  Copyright © 2019年 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HeBi_Select_TableView : UIView
@property (nonatomic, copy) void (^selectCoinBlock)(NSInteger index);
@property (nonatomic, strong) NSArray<NSString *> *dataSource;
@end

NS_ASSUME_NONNULL_END
