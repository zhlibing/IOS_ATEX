//
//  STO_BB_DepthView.h
//  SSKJ
//
//  Created by zpz on 2019/7/30.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface STO_BB_DepthView : UIView


-(void)setDeepData:(NSDictionary *)deepData;

@end


@interface STO_BB_DepthViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *maiLabel;
@property(nonatomic, strong)UILabel *maiNumLabel;
@property(nonatomic, strong)UILabel *maiPriceLabel;
@property(nonatomic, strong)UILabel *mLabel;
@property(nonatomic, strong)UILabel *mNumLabel;
@property(nonatomic, strong)UILabel *mPriceLabel;

@end

NS_ASSUME_NONNULL_END
