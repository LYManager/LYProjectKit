//
//  ImageTableViewCell.m
//  BattleWord
//
//  Created by 李帅 on 2019/10/20.
//  Copyright © 2019 李帅. All rights reserved.
//

#import "ImageTableViewCell.h"

#define RGB(R, G, B, A)\
[UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:A]
#define kCellbackColor [UIColor colorWithRed:6/255.0 green:19/255.0 blue:51/255.0 alpha:0.48] // cell背景色
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
@implementation ImageTableViewCell

//重写init方法构建cell内容
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kCellbackColor;
        
        [self.contentView addSubview:self.ruleImage];
        
    }
    
    return self;
}


-(UIImageView *)ruleImage
{
    if (_ruleImage == nil) {
        
        _ruleImage = [[UIImageView alloc] initWithFrame:CGRectMake(14, 0, kScreenW-14, 333)];
        _ruleImage.image = [UIImage imageNamed:@"123"];
        
        // _arrowImage.image = [UIImage imageNamed:@"right_arrow"];
    }
    return _ruleImage;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
