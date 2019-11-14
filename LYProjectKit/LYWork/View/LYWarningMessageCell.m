// LYWarningMessageCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYWarningMessageCell.h"
#import "LYMessageView.h"

@interface LYWarningMessageCell ()
/**< view*/
@property(nonatomic,strong)LYMessageView * messageView;
@end

@implementation LYWarningMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void) configUI{
    [self.contentView addSubview:self.messageView];
//    测试
    [self.messageView configDataLabelText:@"等级" message:@"测试粉丝滤镜烦死了登记方式来得及发送到了"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
    }];
}

- (LYMessageView *)messageView{
    if (!_messageView) {
        _messageView = [[LYMessageView alloc]init];
        _messageView.moreBtn.hidden = YES;
        [_messageView updateCon];
    }
    return _messageView;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
