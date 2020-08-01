//
//  Login_Type_Option.h
//  SSKJ
//
//  Created by zpz on 2019/12/2.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Login_Type_Option : UIView

- (instancetype)initWithTitles:(NSArray *)array;

@property (nonatomic,copy)void(^selectBlock)(BOOL isPhone);

@end

NS_ASSUME_NONNULL_END
