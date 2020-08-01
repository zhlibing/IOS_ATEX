//
//  alertSelectView.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/4/13.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alertSelectView : UIView
@property(nonatomic,copy)void(^selectIndexBlock)(NSInteger index);
//设置数据
@property(nonatomic,strong)NSArray *dataArray;

@end
