//
//  My_AdvancedCertificate_UploadView.h
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, IDentityCardType)
{
    IDentityCardFront = 1,     // 身份证正面
    IDentityCardBack = 2,      // 身份证背面
    IDentityCardHandHeld = 3,  // 手持证件面
};

@interface My_AdvancedCertificate_UploadView : UIControl



@property (nonatomic, assign) IDentityCardType idCardType;
@property (nonatomic, copy) void (^selectPhotoBlock)(void);
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *imageURL;





/**
 重置Frame

 @param frame CGRect 类型的Frame
 */
-(void)resetFrame:(CGRect)frame;


@end

NS_ASSUME_NONNULL_END
