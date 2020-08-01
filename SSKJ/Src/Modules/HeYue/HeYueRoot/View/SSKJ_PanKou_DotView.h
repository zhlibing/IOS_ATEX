//
//  SSKJ_PanKou_DotView.h
//  SSKJ
//
//  Created by zpz on 2019/10/25.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSKJ_PanKou_DotView : UIView

@property(nonatomic, copy)NSString *coin;
@property (nonatomic, copy) void (^changeDotBlock)(NSInteger dotNumber);

@end

NS_ASSUME_NONNULL_END
