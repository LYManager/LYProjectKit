// LYServiceItemView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYServiceItemView.h"

@interface LYServiceItemView ()
/**< btn*/
@property(nonatomic,strong)UIButton * itemBtn;
/**< itemLabel*/
@property(nonatomic,strong)UILabel * itemLabel;
@end

@implementation LYServiceItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configDataImageString:(NSString *)imageString title:(NSString *)title{
    [self.itemBtn setBackgroundImage:[UIImage imageNamed:imageString] forState:UIControlStateNormal];
    self.itemLabel.text = title;
}

- (void) configUI{
    [self addSubview:self.itemBtn];
    [self addSubview:self.itemLabel];
    [self.itemBtn addTarget:self action:@selector(itemBtnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void) itemBtnAction{
    !self.clickBack ? : self.clickBack(self.index);
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.itemBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(self.itemBtn.mas_width);
    }];
    
    [self.itemLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.itemBtn.mas_bottom).offset(10);
        make.bottom.left.right.mas_equalTo(0);
    }];
}

- (UIButton *)itemBtn{
    if (!_itemBtn) {
        _itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _itemBtn;
}

- (UILabel *)itemLabel{
    if (!_itemLabel) {
        _itemLabel = [[UILabel alloc]initWithFrame:CGRectZero];
        _itemLabel.font = [UIFont systemFontOfSize:12];
        _itemLabel.textColor = [UIColor blackColor];
        _itemLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _itemLabel;
}

@end
