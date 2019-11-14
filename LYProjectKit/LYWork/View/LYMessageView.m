// LYMessageView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYMessageView.h"

@interface LYMessageView ()
/**< label*/
@property(nonatomic,strong)UILabel * label;
/**< message*/
@property(nonatomic,strong)UILabel * messageLabel;

@end

@implementation LYMessageView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}



- (void) configUI {
    [self addSubview:self.label];
    [self addSubview:self.messageLabel];
    [self addSubview:self.moreBtn];
    [self.label setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    [self.messageLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    // 测试数据
    self.label.text = @"业务动态";
    self.messageLabel.text = @"信息内容信息内容是否水电费水电费水电费水电费";
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(0);
        make.width.mas_equalTo(self.label.mas_height).multipliedBy(3);
    }];
    
    [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(0);
        make.width.mas_equalTo(40);
    }];
    
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.label.mas_right).offset(5);
        make.top.bottom.mas_equalTo(0);
        make.right.mas_equalTo(self.moreBtn.mas_left).offset(-5);
//        make.right.mas_equalTo(self).offset(-5).priority(250);
    }];
    

}

- (void)updateCon{
    [self.messageLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
    }];
    [self.label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(35);
    }];
}

- (void)configDataLabelText:(NSString *)labelText message:(NSString *)message{
    self.label.text = labelText;
    self.messageLabel.text = message;
}

#pragma mark🐒------lazy------🐒
- (UILabel *)label{
    if (!_label) {
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.backgroundColor = [UIColor colorWithRed:251/255.0 green:233/255.0 blue:235/255.0 alpha:1];
        _label.textColor = [UIColor colorWithRed:244/255.0 green:52/255.0 blue:91/255.0 alpha:1];
        _label.font = [UIFont systemFontOfSize:11];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

- (UILabel *)messageLabel{
    if (!_messageLabel) {
        _messageLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _messageLabel.font = [UIFont systemFontOfSize:12];
        _messageLabel.textColor = [UIColor darkGrayColor];
    }
    return _messageLabel;
}

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    return _moreBtn;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
