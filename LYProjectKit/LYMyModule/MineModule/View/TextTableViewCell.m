//
//  TextTableViewCell.m
//  BattleWord
//
//  Created by 李帅 on 2019/10/21.
//  Copyright © 2019 李帅. All rights reserved.
//

#import "TextTableViewCell.h"

#define RGB(R, G, B, A)\
[UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:A]
#define kCellbackColor [UIColor colorWithRed:6/255.0 green:19/255.0 blue:51/255.0 alpha:0.48] // cell背景色
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
@implementation TextTableViewCell

//重写init方法构建cell内容
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor clearColor];

        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.codeLab];
        [self.backView addSubview:self.phoneLab];
        [self.backView addSubview:self.idLab];

        
    }
    
    return self;
}

-(UIView *)backView
{
    
    if (_backView == nil) {
        self.backView = [[UIImageView alloc]initWithFrame:CGRectMake(14, 0, kScreenW-28, 40)];
        self.backView.backgroundColor = RGB(47, 53, 113,1);
    }
    return _backView;
}
-(UILabel *)codeLab
{
    if (_codeLab == nil) {
        //描述
        _codeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (kScreenW-28)/3, 40)];
        _codeLab.font = [UIFont systemFontOfSize:12.0f];
        _codeLab.textColor = RGB(255, 255, 255,1.0);
        _codeLab.textAlignment = NSTextAlignmentCenter;
        //        _titleLab.backgroundColor = [UIColor redColor];
    }
    return _codeLab;
}
-(UILabel *)phoneLab
{
    if (_phoneLab == nil) {
        //描述
        _phoneLab = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW-28)/3, 0, (kScreenW-28)/3, 40)];
        _phoneLab.font = [UIFont systemFontOfSize:12.0f];
        _phoneLab.textColor = RGB(255, 255, 255,1.0);
        _phoneLab.textAlignment = NSTextAlignmentCenter;
        //        _titleLab.backgroundColor = [UIColor redColor];
    }
    return _phoneLab;
}
-(UILabel *)idLab
{
    if (_idLab == nil) {
        //描述
        _idLab = [[UILabel alloc] initWithFrame:CGRectMake((kScreenW-28)/3*2, 0, (kScreenW-28)/3, 40)];
        _idLab.font = [UIFont systemFontOfSize:12.0f];
        _idLab.textColor = RGB(255, 255, 255,1.0);
        _idLab.textAlignment = NSTextAlignmentCenter;
        //        _titleLab.backgroundColor = [UIColor redColor];
    }
    return _idLab;
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
