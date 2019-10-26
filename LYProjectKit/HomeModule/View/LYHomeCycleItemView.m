// LYHomeCycleItemView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/23. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYHomeCycleItemView.h"
//#import "LYRubbishModel.h"
@interface LYHomeCycleItemView ()


/**< itemImageView*/
@property(nonatomic,strong)UIImageView * itemImageView;
/**< titleLabel*/
@property(nonatomic,strong)UILabel * titleLabel;
@property (nonatomic, strong) UIActivityIndicatorView * activityIndicator;
/**< model*/
//@property(nonatomic,strong)LYRubbishModel * model;
@end

@implementation LYHomeCycleItemView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
//           UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//           [self addGestureRecognizer:tap];
    }
    return self;
}

//- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
//    UIView *view = [super hitTest:point withEvent:event];
//     CGPoint buttonPoint = [self.imageView convertPoint:point fromView:self];
//    if ([self.imageView pointInside:buttonPoint withEvent:event]) {
//      return self.imageView;
//    }
//    return view;
//}

- (void)configDataWithModel:(LYRubbishModel *)rubbishModel{
    self.model = rubbishModel;
    [self.activityIndicator startAnimating];
    __weak typeof(self)weakSelf = self;
    [self.itemImageView sd_setImageWithURL:[NSURL URLWithString:rubbishModel.rubbishUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
         [weakSelf.activityIndicator stopAnimating];
    }];
    self.titleLabel.text = rubbishModel.rubbishName;
}

//- (void)tapAction:(UITapGestureRecognizer *)tap{
//    CGPoint touchPoint = [tap locationInView:self];
////    if ([self.imageView.layer.presentationLayer hitTest:touchPoint]) {
//        NSLog(@"%@",self.model.rubbishName);
//    
////    }
//}

- (void) configUI {
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_item_bg_icon"]];
    self.imageView = imageView;
    imageView.userInteractionEnabled = YES;
    [self addSubview:imageView];
    
//    
    
    UIImageView * itemImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    self.itemImageView = itemImageView;
    itemImageView.userInteractionEnabled = YES;
    [self addSubview:itemImageView];
    
    UILabel * titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:11];
    titleLabel.text = @"香蕉皮";
    self.titleLabel = titleLabel;
    [self.itemImageView addSubview:titleLabel];

    [self.itemImageView addSubview:self.activityIndicator];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(-25);
        make.bottom.mas_equalTo(self).offset(20);
        make.height.mas_equalTo(self.imageView.mas_width).multipliedBy(0.91);
        make.width.mas_equalTo(90);
//        make.width.mas_equalTo(138);
//        make.height.mas_equalTo(make.width).multipliedBy(0.91);
    }];
    
    [self.itemImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imageView);
        make.bottom.mas_equalTo(self.imageView.mas_top);
//        make.left.mas_equalTo(0);
    }];
    [self.activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(10);
    }];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    NSLog(@"%@",self.model.rubbishName);
//
//}

- (UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _activityIndicator.frame = CGRectMake(20, 20, 50, 50);
    }
    return _activityIndicator;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
