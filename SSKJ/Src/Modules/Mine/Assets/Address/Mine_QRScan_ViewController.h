//
//  QBScanCodeViewController.h
//  ZYW_MIT
//
//  Created by 张本超 on 2018/5/8.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSKJ_BaseViewController.h"
@interface Mine_QRScan_ViewController : SSKJ_BaseViewController
@property(nonatomic,copy)void(^codeScaningString)(NSString *string);
@end
