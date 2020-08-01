//
//  Register_Choose_Country_View.h
//  ZYW_MIT
//
//  Created by 赵亚明 on 2019/6/25.
//  Copyright © 2019 Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Register_Choose_Country_View : UIView

@property (nonatomic,copy) void (^ChooseCountryBlock) (void);

@property (nonatomic,strong) UILabel * areaLabel;

@property (nonatomic,strong) UIView * lineView;

@property (nonatomic,strong) UIButton * countryBtn;

@property (nonatomic,strong) UIButton * saoJiaoBtn;

@end

NS_ASSUME_NONNULL_END
