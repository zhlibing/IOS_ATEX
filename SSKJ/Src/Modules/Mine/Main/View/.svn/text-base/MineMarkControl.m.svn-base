//
//  MineMarkControl.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/19.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "MineMarkControl.h"


@interface MineMarkControl ()

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation MineMarkControl

- (instancetype)init
{
    self = [super init];
    if (self)
    {
     
        [self setBackgroundColor:RGBACOLOR(54, 58, 63, 1)];
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
    }
    return self;
}



/**
 设置图标名称
 
 @param image 图标名称
 */
-(void)setImage:(NSString*)image
{
    [self.imageView setImage:[UIImage imageNamed:image]];
}


/**
 设置标题
 
 @param title 标题
 */
-(void)setTitle:(NSString*)title titleColor:(UIColor *)textColor
{
    [self.titleLabel setText:SSKJLocalized(title, nil)];
    self.titleLabel.textColor = textColor;
}



-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    [self.imageView setFrame:CGRectMake(0, 0, (frame.size.height), (frame.size.height))];
    [self.titleLabel setFrame:CGRectMake(self.imageView.right, 0, frame.size.width-self.imageView.width, self.imageView.height)];
    [self byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(frame.size.height, frame.size.height)];
}




#pragma mark - Getter / Setter
-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
        [_titleLabel setNumberOfLines:0];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_titleLabel setFont:systemFont(ScaleW(12))];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setText:@"签到成功"];
    }
    return _titleLabel;
}

-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
    }
    return _imageView;
}







@end
