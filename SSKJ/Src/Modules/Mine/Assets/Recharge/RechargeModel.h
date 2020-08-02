//
//  RechargeModel.h
//  SSKJ
//
//  Created by 姚立志 on 2020/8/2.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RechargeModel : NSObject


@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *qrcode;

@end

NS_ASSUME_NONNULL_END
