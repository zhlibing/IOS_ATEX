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

@interface SKCertificationStateViewController : SSKJ_BaseViewController
@property (nonatomic,assign) SKYState state; //操作类型
@property (nonatomic,assign) int type; // 1 初级认证   2 高级认证
//@property (nonatomic,strong) id AdvanceOrPriView; 

@end

NS_ASSUME_NONNULL_END
