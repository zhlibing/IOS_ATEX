//
//  SKCertificationStateViewController.h
//  SSKJ
//
//  Created by 孙 on 2019/7/23.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_BaseViewController.h"
typedef enum _SKYState {
    CertificationSuccess  = 0,//认证成功
    CertificationFailure,//认证失败
    CertificationOngoing  //认证进行中
} SKYState;

NS_ASSUME_NONNULL_BEGIN

@interface Mine_CertificationState_ViewController : SSKJ_BaseViewController


@end

NS_ASSUME_NONNULL_END
