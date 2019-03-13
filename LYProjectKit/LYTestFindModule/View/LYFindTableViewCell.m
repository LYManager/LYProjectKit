// LYFindTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/12. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYFindTableViewCell.h"

@interface LYFindTableViewCell ()
/**< name*/
@property(nonatomic,strong)UILabel * nameLabel;
/**< des*/
@property(nonatomic,strong)UILabel * desLabel;
@end

@implementation LYFindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)p_setModel
{
    self.nameLabel.text = @"名字";
    self.desLabel.text = @"这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述述这是描述这是描述这是描述这是描述述这是描述这是描述这是描述这是描述述这是描述这是描述这是描述这是描述";
}

- (void)configUI
{
    [self.contentView addSubview:self.nameLabel];
    
    [self.contentView addSubview:self.desLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.height.mas_equalTo(20);
    }];
    
    [self.desLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.nameLabel.mas_bottom).offset(5);
        make.left.right.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(-5);
    }];
}



- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
        _nameLabel.textColor = [UIColor blackColor];
//        _nameLabel.text = @"名字";
    }
    return _nameLabel;
}

- (UILabel *)desLabel
{
    if (!_desLabel) {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _desLabel.font = [UIFont systemFontOfSize:13];
//        _desLabel.text = @"这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述这是描述述这是描述这是描述这是描述这是描述述这是描述这是描述这是描述这是描述述这是描述这是描述这是描述这是描述";
        _desLabel.numberOfLines = 0;
        _desLabel.textColor = [UIColor grayColor];
    }
    return _desLabel;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
