//
//  QBWShowNoDataView.m
//  ZYW_MIT
//
//  Created by 张本超 on 2018/4/28.
//  Copyright © 2018年 Wang. All rights reserved.
//

#import "QBWShowNoDataView.h"
@interface QBWShowNoDataView()
//主视图
@property(nonatomic,strong)UIImageView *img;
@end
@implementation QBWShowNoDataView
//
+(instancetype)showNoData:(BOOL)haveData toView:(UIView *)view offY:(CGFloat) offY
{
    QBWShowNoDataView *viewResult = [[QBWShowNoDataView alloc]initWithFrame:view.bounds];
    viewResult.y = offY;
    for (UIView *v in view.subviews) {
        if ([v isKindOfClass:[QBWShowNoDataView class]]) {
            [v removeFromSuperview];
            break;
        }
    }
    if (haveData)
    {
        
    }else{
      [view addSubview:viewResult];
    }
    return viewResult;
};
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.img = [[UIImageView alloc]initWithFrame:self.bounds];
        self.img.image = [UIImage imageNamed:@"GO_Public_NoData"];
        [self addSubview:self.img];
    }
    return self;
}
@end
