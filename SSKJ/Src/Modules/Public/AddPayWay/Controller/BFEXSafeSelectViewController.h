//
//  BFEXSafeSelectViewController.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/7/10.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BFEXSafeSelectViewController : UIViewController

-(void)showViewAlert:(id)type;



/**
 展示添加收款方式弹窗
 @param type 区别是编辑还是添加(必传,edit对应编辑,add对应添加)
 @param Model 数据，没有时传nil
 */
-(void)showViewAlertNew:(NSString *)type andModel:(id)Model;

@end
