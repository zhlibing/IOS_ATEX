//
//  BLSafeCenterViewController.h
//  BiLe
//
//  Created by 李赛 on 2017/02/14.
//  Copyright © 2018年 LS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_BaseViewController.h"

@interface Mine_SafeCenter_ViewController : SSKJ_BaseViewController

@property (nonatomic, strong) SSKJ_UserInfo_Model *userModel;

-(void)reloadBankList;
@end
