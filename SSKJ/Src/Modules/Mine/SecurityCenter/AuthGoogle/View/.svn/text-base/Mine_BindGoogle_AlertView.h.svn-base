//
//  My_BindGoogle_AlertView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, GOOGLETYPE)
{
    GOOGLETYPEBIND,  //!< 绑定
    GOOGLETYPEADD,  //!< 开启
    GOOGLETYPEDELETE,  //!< 关闭
    GOOGLETYPE_Safty,//安全验证
    GOOGLETYPE_TB,//提币弹出
    
};

NS_ASSUME_NONNULL_BEGIN

@interface Mine_BindGoogle_AlertView : UIView

@property (nonatomic, copy) void (^submitBlock)(NSString *googleCode,NSString *smsCode);
@property (nonatomic ,strong) void(^cancleCallBack)(void);

@property (nonatomic, assign) GOOGLETYPE type; //!< 类型


-(void)showWithType:(GOOGLETYPE)googleType;
-(void)hide;

@end

NS_ASSUME_NONNULL_END
