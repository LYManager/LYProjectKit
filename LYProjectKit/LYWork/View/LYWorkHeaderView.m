// LYWorkHeaderView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYWorkHeaderView.h"

@interface LYWorkHeaderView ()
/**< 背景*/
@property(nonatomic,strong)UIView * backBgView;
/**< 头像*/
@property(nonatomic,strong)UIImageView * headImageView;
/**< 名字*/
@property(nonatomic,strong)UILabel * nameLabel;
/**< 名字icon标识*/
@property(nonatomic,strong)UIImageView * iconImageView;
/**< 地址*/
@property(nonatomic,strong)UILabel * addressLabel;
/**< 信息*/
@property(nonatomic,strong)UIButton * messageBtn;



@end
static CGFloat const kMargin = 10.f;
static CGFloat const kTopViewHeight = 80.f;
static CGFloat const kMessageViewHeight = 20.f;
static CGFloat const kBottomBtnHeight = 50.f;
@implementation LYWorkHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void) configUI {
    
    [self addSubview:self.backBgView];
    
    [self.backBgView addSubview:self.headImageView];
    
    [self.backBgView addSubview:self.nameLabel];
    
    [self.backBgView addSubview:self.iconImageView];
    
    [self.backBgView addSubview:self.addressLabel];
    
    [self.backBgView addSubview:self.messageBtn];
    
    [self addSubview:self.messageView];
    
    [self addSubview:self.creagteNewOrderBtn];
    
    [self addSubview:self.friendBtn];
   
     [self.nameLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
    [self.addressLabel setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
    
     // 测试数据
    self.nameLabel.text = @"薛磊";
    self.addressLabel.text = @"中华大区-办公室";
    self.iconImageView.image = [UIImage imageNamed:@"形状2"];
    self.headImageView.image = [UIImage imageNamed:@"图层2"];
    [self.messageBtn setBackgroundImage:[UIImage imageNamed:@"wenhao"] forState:UIControlStateNormal];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.backBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-kMargin);
        make.height.mas_equalTo(kTopViewHeight);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kMargin);
        make.centerY.mas_equalTo(self.backBgView);
        make.top.mas_equalTo(self.backBgView).offset(kMargin + 5);
        make.width.mas_equalTo(self.headImageView.mas_height);
    }];
    self.headImageView.layer.cornerRadius = (kTopViewHeight - 2*kMargin - 10) / 2;

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headImageView.mas_right).offset(kMargin);
        make.top.mas_equalTo(self.headImageView);
        make.bottom.mas_equalTo(self.headImageView.mas_centerY);
    }];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nameLabel.mas_right).offset(kMargin / 2);
        make.centerY.mas_equalTo(self.nameLabel);
        make.width.height.mas_equalTo(self.nameLabel.mas_height).multipliedBy(0.6);
    }];
    
    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headImageView.mas_centerY);
        make.left.mas_equalTo(self.nameLabel);
        make.bottom.mas_equalTo(self.headImageView.mas_bottom);
    }];
    
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-kMargin);
        make.centerY.mas_equalTo(self.backBgView);
        make.width.height.mas_equalTo(self.backBgView.mas_height).multipliedBy(0.35);
    }];
    
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.backBgView);
        make.top.mas_equalTo(self.backBgView.mas_bottom).offset(kMargin);
        make.height.mas_equalTo(kMessageViewHeight);
    }];
    
    [self.creagteNewOrderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.messageView.mas_bottom).offset(kMargin);
        make.left.mas_equalTo(self.messageView);
        make.height.mas_equalTo(kBottomBtnHeight);
        make.right.mas_equalTo(self.friendBtn.mas_left).offset(-2*kMargin);
        make.width.mas_equalTo(self.friendBtn);
    }];
    
    [self.friendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.messageView);
        make.top.height.width.mas_equalTo(self.creagteNewOrderBtn);
    }];
    
}

+ (CGFloat)headerViewHeight{
    return kTopViewHeight + kMargin + kMessageViewHeight + kMargin + kBottomBtnHeight + kMargin;
}

#pragma mark🐒------lazy------🐒

- (UIView *)backBgView{
    if (!_backBgView) {
        _backBgView = [[UIView alloc]initWithFrame:CGRectZero];
        _backBgView.backgroundColor = [UIColor colorWithRed:220/255.0 green:227/255.0 blue:234/255.0 alpha:1];
    }
    return _backBgView;
}

- (UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        _headImageView.clipsToBounds = YES;
    }
    return _headImageView;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.textColor = [UIColor blackColor];
    }
    return _nameLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    }
    return _iconImageView;
}

- (UILabel *)addressLabel{
    if (!_addressLabel) {
        _addressLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _addressLabel.font = [UIFont systemFontOfSize:13];
        _addressLabel.textColor = [UIColor grayColor];
    }
    return _addressLabel;
}

- (UIButton *)messageBtn{
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _messageBtn;
}

- (LYMessageView *)messageView{
    if (!_messageView) {
        _messageView = [[LYMessageView alloc]initWithFrame:CGRectZero];
    }
    return _messageView;
}

- (UIButton *)creagteNewOrderBtn{
    if (!_creagteNewOrderBtn) {
        _creagteNewOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _creagteNewOrderBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_creagteNewOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _creagteNewOrderBtn.backgroundColor = [UIColor colorWithRed:44/255.0 green:88/255.0 blue:204/255.0 alpha:1];
        [_creagteNewOrderBtn setTitle:@"新建订单" forState:UIControlStateNormal];
        _creagteNewOrderBtn.layer.cornerRadius = 5;
    }
    return _creagteNewOrderBtn;
}

- (UIButton *)friendBtn{
    if (!_friendBtn) {
         _friendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
       _friendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
       [_friendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
         _friendBtn.backgroundColor = [UIColor colorWithRed:41/255.0 green:185/255.0 blue:169/255.0 alpha:1];
        [_friendBtn setTitle:@"合作伙伴" forState:UIControlStateNormal];
        _friendBtn.layer.cornerRadius = 4;
    }
    return _friendBtn;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
