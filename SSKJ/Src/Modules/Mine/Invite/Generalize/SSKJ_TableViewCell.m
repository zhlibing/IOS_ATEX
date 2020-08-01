//
//  SSKJ_TableViewCell.m
//  SSKJ
//
//  Created by 姚立志 on 2019/11/8.
//  Copyright © 2019 刘小雨. All rights reserved.
//

#import "SSKJ_TableViewCell.h"

@implementation SSKJ_TableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
        [self.contentView setBackgroundColor: kBgColor];
            
    }
    return self;
}



@end
