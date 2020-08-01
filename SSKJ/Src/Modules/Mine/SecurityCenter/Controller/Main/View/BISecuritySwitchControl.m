//
//  BISecuritySwitchControl.m
//  SSKJ
//
//  Created by 姚立志 on 2019/6/24.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "BISecuritySwitchControl.h"



@interface BISecuritySwitchControl ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel; //!< 标题标签



@end

@implementation BISecuritySwitchControl



- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self setItemColor:NO];
    }
    return self;
}


-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
}


#pragma mark 设置图片的位置
-(void)setImageEdge:(CGRect)edgeFrame
{
    [self.imageView setFrame:edgeFrame];
}


-(void)setImage:(NSString*)image
{
    [self.imageView setImage:[UIImage imageNamed:image]];
}


#pragma mark 设置标签的位置
-(void)setTitleEdge:(CGRect)edgeFrame
{
    [self.titleLabel setFrame:edgeFrame];
}

#pragma mark 设置字体位置
-(void)setTextAlignment:(NSTextAlignment)alignment
{
    [self.titleLabel setTextAlignment:alignment];
}


#pragma mark 设置字体颜色
-(void)setTextColor:(UIColor * _Nullable)color
{
    [self.titleLabel setTextColor:color];
}


#pragma mark 设置字体大小
-(void)setFont:(UIFont * _Nullable)font
{
    [self.titleLabel setFont:font];
}

#pragma mark 设置标题
-(void)setTitle:(NSString *)title
{
    [self.titleLabel setText:SSKJLocalized(title, nil)];
}

#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (!_imageView)
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFit];
    }
    return _imageView;
}


-(UILabel *)titleLabel
{
    if (!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]init];
    }
    return _titleLabel;
}



-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self setBackgroundColor:[UIColor redColor]];
        [self.imageView setBackgroundColor:[UIColor yellowColor]];
    }
}

@end
