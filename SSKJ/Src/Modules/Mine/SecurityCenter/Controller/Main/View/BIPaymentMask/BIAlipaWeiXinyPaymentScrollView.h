//
//  BIAlipaWeiXinyPaymentScrollView.h
//  SSKJ
//
//  Created by 姚立志 on 2019/6/20.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BIPaymentBoardItemView.h"


NS_ASSUME_NONNULL_BEGIN

@interface BIAlipaWeiXinyPaymentScrollView : UIScrollView

@property (nonatomic,strong) BIPaymentBoardItemView *nameView; //!< 名字
@property (nonatomic,strong) BIPaymentBoardItemView *accountNumnerView; //!< (微信或支付宝)账号、开户银行
@property (nonatomic,strong) BIPaymentBoardItemView *codeView; //!< 二维码
@property (nonatomic,strong) BIPaymentBoardItemView *bankNumberView; //!< 银行卡号
@property (nonatomic,strong) BIPaymentBoardItemView *openBankView; //!< 卡户支行
@property (nonatomic,strong) BIPaymentBoardItemView *passwordView; //!< 密码





-(void)setImage:(UIImage*)image;





/**
 创建不同的视图

 @param type 1 为支付宝和微信类型 2 为银行卡类型
 @return 返回当前对象
 */
- (instancetype)initWithType:(NSInteger)type;



/**
 设置Frame

 @param frame frame
 @param type NSInteger  1 为支付宝和微信类型(总高度为350) 2 为银行卡类型
 */
-(void)resetFrame:(CGRect)frame withType:(NSInteger)type;

/**
 
 @param username 用户名
 @param account 付款账号
 @param url 二维码Url
 */
-(void)setUserName:(NSString*)username withPayAccount:(NSString*)account withQRUrl:(NSString*)url;


/**
 
 @param username 用户名
 @param bankName 银行名称
 @param account 银行卡账号
 @param openOptionBank 开户行
 */
-(void)setUserName:(NSString*)username withBankName:(NSString*)bankName withPayAccount:(NSString*)account withOpenOptionBank:(NSString*)openOptionBank;




@end



NS_ASSUME_NONNULL_END
