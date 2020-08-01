//
//  VPay_Shop_Notice_View.h
//  SSKJ
//
//  Created by 刘小雨 on 2018/8/23.
//  Copyright © 2018年 James. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SSKJ_ScrollNotice_View : UIView

@property (nonatomic, copy) void (^moreBlock)(void);
@property (nonatomic, copy) void (^clickBlock)(NSInteger index);
-(void)setNoticeArray:(NSArray *)noticeArray;
- (void)configureModels:(NSArray *)models;

-(void)setIsMainPage;
@end
