//
//  BLPopVerView.h
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^presentBlock)(NSString *code);

@interface BLPopVerView : UIView

@property (nonatomic, strong) UIViewController *parentVC;

@property (nonatomic, copy) presentBlock presentBlock;

@property (nonatomic, copy) NSString *phoneNumber;

@property (nonatomic, copy) NSString *fromVC;

- (void)present:(presentBlock)block;

+ (instancetype)popVerView;

@end
