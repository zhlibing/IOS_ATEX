//
//  ATEX_SafeCenter_Cell.h
//  SSKJ
//
//  Created by 刘小雨 on 2020/4/14.
//  Copyright © 2020 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATEX_SafeCenter_Cell : UITableViewCell

-(void)setTitle:(NSString *)title statusString:(NSString *)statusString isShowImage:(BOOL)isShowImage;

@end

NS_ASSUME_NONNULL_END
