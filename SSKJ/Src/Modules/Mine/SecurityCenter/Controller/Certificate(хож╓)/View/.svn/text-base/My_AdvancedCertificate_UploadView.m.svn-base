//
//  My_AdvancedCertificate_UploadView.m
//  ZYW_MIT
//
//  Created by 刘小雨 on 2019/3/28.
//  Copyright © 2019年 Wang. All rights reserved.
//

#import "My_AdvancedCertificate_UploadView.h"

@interface My_AdvancedCertificate_UploadView ()

@property (nonatomic,strong) UIImageView *backGroundImageView;  //!< 用户选择照片
@property (nonatomic, strong) UIImageView *imageView;  //!< 项目需求照片（身份证正面、身份证反面、手持照片）


@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *messageLabel;




@end

@implementation My_AdvancedCertificate_UploadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setBackgroundColor:[UIColor clearColor]];
        
        
        [self addSubview:self.imageView];
        [self addSubview:self.titleLabel];
        [self addSubview:self.messageLabel];
        [self addSubview:self.backGroundImageView];
        
        
        [self setItemColor:NO];
    
    }
    return self;
}



/**
 重置Frame
 
 @param frame CGRect 类型的Frame
 */
-(void)resetFrame:(CGRect)frame
{
    [self setFrame:frame];
    
    [self.imageView setFrame:CGRectMake(0, 0, ScaleW(220), ScaleW(120))];
    [self.imageView setCenterX:self.centerX];
    [self.backGroundImageView setFrame:CGRectMake(self.imageView.x, self.imageView.y, self.imageView.width, self.imageView.height)];
    
    [self.titleLabel setFrame:CGRectMake(0, self.imageView.bottom + ScaleW(25), frame.size.width, ScaleW(20))];
    
    
    
    
    #pragma mark 根据内容高度设置高度
    {
        CGFloat height = [self.messageLabel.text boundingRectWithSize:CGSizeMake((frame.size.width - ScaleW(40)), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.messageLabel.font} context:nil].size.height;
        
        [self.messageLabel setFrame:CGRectMake(ScaleW(20), self.titleLabel.bottom + ScaleW(25), frame.size.width - ScaleW(40), height)];
        [self setHeight:(self.messageLabel.bottom + ScaleW(30))];
    }
}




#pragma mark - Private Method
-(void)selectImageEvent
{
    if (self.selectPhotoBlock) {
        self.selectPhotoBlock();
    }
}

-(void)setIdCardType:(IDentityCardType)idCardType
{
    NSString *imageName = @"";
    NSString *title = @"";
    NSString *message = @"";
    _idCardType = idCardType;
    switch (idCardType)
    {
        case IDentityCardFront:
        {
            imageName = @"mine_auth_front";
            title = SSKJLocalized(@"请上传身份证正面", nil);
            message = SSKJLocalized(@"身份证正面确保无水印无污渍，身份信息清晰，非文字反向照片，请勿进行PS处理", nil);
        }
            break;
        case IDentityCardBack:
        {
            imageName = @"mine_auth_back";
            title = SSKJLocalized(@"请上传身份证背面", nil);
            message = SSKJLocalized(@"身份证背面确保无水印无污渍，身份信息清晰，非文字反向照片，请勿进行PS处理", nil);
        }
            break;
        case IDentityCardHandHeld:
        {
            imageName = @"mine_auth_hand";
            title = SSKJLocalized(@"请上传手持身份证", nil);
            message = SSKJLocalized(@"需要您本人单手手持有一张放置有身份证、有您手写的COIN DF和当天日期的白纸，确保身份证和白纸在您胸前，不遮挡您的脸部，并且身份证和白纸上的信息清晰可见。", nil);
        }
            break;
    }
    
    
    [self.imageView setImage:[UIImage imageNamed:imageName]];
    [self.titleLabel setText:title];
    [self.messageLabel setText:message];
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    [self.backGroundImageView setImage:image];
}

-(void)setImageURL:(NSString *)imageURL
{
    _imageURL = imageURL;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:imageURL]];
}






#pragma mark - Getter / Setter
-(UIImageView *)imageView
{
    if (nil == _imageView )
    {
        _imageView = [[UIImageView alloc]init];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        [_imageView setMasksToBounds:YES];
    }
    return _imageView;
}

-(UILabel *)titleLabel
{
    if (nil == _titleLabel)
    {
        _titleLabel  = [[UILabel alloc]init];
        [_titleLabel setFont:systemFont(ScaleW(13))];
        [_titleLabel setTextColor:kTitleColor];
        [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (nil == _messageLabel)
    {
        _messageLabel  = [[UILabel alloc]init];
        [_messageLabel setFont:systemFont(ScaleW(13))];
        [_messageLabel setNumberOfLines:0];
        [_messageLabel setTextColor:kSubTitleColor];
    }
    return _messageLabel;
}


-(UIImageView *)backGroundImageView
{
    if (!_backGroundImageView)
    {
        _backGroundImageView = [[UIImageView alloc]init];
        [_backGroundImageView setContentMode:UIViewContentModeScaleAspectFill];
        [_backGroundImageView setMasksToBounds:YES];
    }
    return _backGroundImageView;
}




-(void)setItemColor:(BOOL)color
{
    if (color)
    {
        [self.imageView setBackgroundColor:[UIColor blueColor]];
        [self.backGroundImageView setBackgroundColor:[UIColor grayColor]];
        [self.titleLabel setBackgroundColor:[UIColor orangeColor]];
        [self.messageLabel setBackgroundColor:[UIColor yellowColor]];
    }
}



@end
