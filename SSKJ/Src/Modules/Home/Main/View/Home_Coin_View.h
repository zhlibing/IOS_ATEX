//
//  Home_Coin_View.h
//  SSKJ
//
//  Created by zpz on 2019/10/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Home_Coin_View : UIView

@property(nonatomic, strong)NSArray *array;

@property (nonatomic,copy)void(^selectBlock)(NSInteger index);


@end

NS_ASSUME_NONNULL_END
