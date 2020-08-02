//
//  My_Yuanli_Model.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/4/1.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface My_Yuanli_Model : NSObject

@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *created_at;//时间
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *account;
@property (nonatomic, copy) NSString *fuid;
@property (nonatomic, copy) NSString *mark; //!< 返佣标记
@property (nonatomic, copy) NSString *num;


@end

NS_ASSUME_NONNULL_END
