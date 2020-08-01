//
//  XBTextLoopTableViewCell.m
//  SSKJ
//
//  Created by 张本超 on 2018/12/21.
//  Copyright © 2018 刘小雨. All rights reserved.
//

#import "XBTextLoopTableViewCell.h"
#define kCellHeight ScaleW(40)
@interface XBTextLoopTableViewCell()
@end

@implementation XBTextLoopTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
//        [self viewConfig];
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.contentTxtLabel];
    }
    return self;
}

-(void)viewConfig
{

}
-(UILabel *)contentTxtLabel{
    if (!_contentTxtLabel) {
        _contentTxtLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, kCellHeight)];
        _contentTxtLabel.font = [UIFont systemFontOfSize:ScaleW(12)];
        _contentTxtLabel.textColor = [UIColor redColor];
        _contentTxtLabel.backgroundColor = [UIColor clearColor];
//        _contentTxtLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _contentTxtLabel;
}

@end
