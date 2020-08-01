//
//  SystemNoticeViewController.m
//  ICC
//
//  Created by zpz on 2019/7/15.
//  Copyright © 2019 WeiLv Technology. All rights reserved.
//

#import "SystemNoticeViewController.h"

@interface SystemNoticeViewController ()

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UIView *contentView;


@property (nonatomic, strong) UIImageView *mainImgView;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *ensureBtn;

@end

//

@implementation SystemNoticeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
    [self viewConfig];
}

-(void)viewConfig
{
    
    [self.view addSubview:self.mainImgView];
    [self.mainImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(52)));
        make.right.equalTo(@(ScaleW(-52)));
        make.centerY.equalTo(self.view.mas_centerY).offset(ScaleW(-20));
        make.height.equalTo(@(ScaleW(360)));
        
    }];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:UIImageNamed(@"home_notice_bg")];
    [self.mainImgView addSubview:imageV];
    [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(@0);
        make.height.equalTo(@(ScaleW(141)));
    }];
     
    UILabel *newLabel = [UILabel createWithText:SSKJLanguage(@"平台公告") textColor:kSubTitleColor font:kBoldFont(19)];
    [self.mainImgView addSubview:newLabel];
    [newLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(23)));
        make.top.equalTo(@(ScaleW(40)));
    }];
    
    UILabel *newLabelen = [UILabel createWithText:SSKJLanguage(@"最新公告") textColor:kSubTitleColor font:kFont(12)];
    [self.mainImgView addSubview:newLabelen];
    [newLabelen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(ScaleW(23)));
        make.top.equalTo(newLabel.mas_bottom).offset(ScaleW(6));
    }];
    
    [self titleLabel];
    
    [self scrollView];
    
    [self contentView];
    
    [self messageLabel];
    
    [self ensureBtn];
    
}

-(UIImageView *)mainImgView
{
    if (!_mainImgView) {
        _mainImgView = [[UIImageView alloc]init];
        _mainImgView.backgroundColor = kSubBgColor;
        _mainImgView.userInteractionEnabled = YES;
        _mainImgView.layer.masksToBounds = YES;
        _mainImgView.layer.cornerRadius = ScaleW(12);
    }
    return _mainImgView;
}


- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [WLTools allocLabel:self.titleString font:kFont(16) textColor:kTitleColor frame:CGRectZero textAlignment:NSTextAlignmentLeft];
        [_mainImgView addSubview:self.titleLabel];
        [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(25)));
            make.right.equalTo(@(ScaleW(-25)));
            make.top.equalTo(@(ScaleW(150)));
        }];
    }
    return _titleLabel;
}

-(UILabel *)messageLabel
{
    if (!_messageLabel) {
        _messageLabel = [WLTools allocLabel:self.content font:systemFont(ScaleW(14)) textColor:kTitleColor frame:CGRectZero textAlignment:(NSTextAlignmentLeft)];
        [self.contentView addSubview:self.messageLabel];
        [_messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(5)));
            make.right.equalTo(@(ScaleW(-5)));
//            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(20));
             make.top.bottom.equalTo(@0);
        }];
        
        
    }
    return _messageLabel;
}


-(UIButton *)ensureBtn

{
    if (!_ensureBtn) {
        _ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ensureBtn btn:_ensureBtn font:ScaleW(15) textColor:kTitleColor text:nil image:nil sel:@selector(ensureBtn:) taget:self];
        [_ensureBtn setImage:UIImageNamed(@"home_x_w") forState:UIControlStateNormal];
        [self.view addSubview:_ensureBtn];
        [_ensureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mainImgView.mas_bottom).offset(ScaleW(15));
            make.height.width.equalTo(@(ScaleW(44)));
            make.centerX.equalTo(@0);

        }];
        
        
    }
    return _ensureBtn;
}


-(void)ensureBtn:(UIButton *)sender
{
        [self dismissViewControllerAnimated:NO completion:nil];
//    !self.ensureBlock?:self.ensureBlock();
    
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        self.scrollView = [[UIScrollView alloc] init];
        [self.mainImgView addSubview:_scrollView];
//        if (@available(iOS 11.0, *)){
//            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }else{
//            self.automaticallyAdjustsScrollViewInsets = NO;
//        }
        [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(ScaleW(20)));
            make.right.equalTo(@(ScaleW(-20)));
            make.top.equalTo(self.titleLabel.mas_bottom).offset(ScaleW(20));
            make.bottom.equalTo(@0);
//            make.height.greaterThanOrEqualTo(@(ScaleW(155)));
//            make.height.lessThanOrEqualTo(@(ScreenHeight - ScaleW(200)));
        }];
    }
    return _scrollView;
}

- (UIView *)contentView{
    if (!_contentView) {
        _contentView = [UIView new];
        [_scrollView addSubview:_contentView];
        [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.left.bottom.equalTo(@0);
            make.centerX.equalTo(self.scrollView);
        }];
    }
    return _contentView;
}

@end
