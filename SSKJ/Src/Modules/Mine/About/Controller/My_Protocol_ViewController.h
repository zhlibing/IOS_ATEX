//
//  My_Protocol_ViewController.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "SSKJ_BaseViewController.h"

typedef NS_ENUM(NSUInteger, PROTOCOLTYPE) {
    PROTOCOLTYPEPRIVATE,    //!< 隐私条款
    PROTOCOLTYPESERVICE,    //!< 服务协议

};

NS_ASSUME_NONNULL_BEGIN

@interface My_Protocol_ViewController : SSKJ_BaseViewController

@property (nonatomic, assign) PROTOCOLTYPE protocolType;
@end

NS_ASSUME_NONNULL_END
