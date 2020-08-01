//
//  BIPaymentBoardView.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BISecurityCenterModel.h"



@protocol BIPaymentBoardViewDelegate <NSObject>

-(void)paymentBoardAction:(NSInteger)sender;

@end


typedef NS_ENUM(NSInteger,PayMentAddEditType)
{
    PayMentAddType = 0, //!< 添加类型
    PayMentEditType = 1, //!< 编辑类型
};




NS_ASSUME_NONNULL_BEGIN

@interface BIPaymentBoardView : UIView


@property (nonatomic,strong) id <BIPaymentBoardViewDelegate> delegate; //!< 代理对象

@property (nonatomic, assign) PayMentAddEditType addEditType; //!< 类型
@property (nonatomic,assign) NSInteger type; //!< 支付方式 1支付宝  2微信  3银行（默认支付宝）
@property (nonatomic, strong) BISecurityCenterModel *model; //!< 设置数据模型，一定要先设置编辑还是添加类型和默认类型之后才能设置改数据模型








@end

NS_ASSUME_NONNULL_END
