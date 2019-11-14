// LYServiceTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYServiceTableViewCell.h"
#import "LYServiceItemView.h"

@interface LYServiceTableViewCell ()
/**< itemArray*/
@property(nonatomic,strong)NSMutableArray<LYServiceItemView *> * itemArray;

/**< 图片array*/
@property(nonatomic,strong)NSMutableArray * imageStringArray;
/**< 标题array*/
@property(nonatomic,strong)NSMutableArray * titleArray;
@end

@implementation LYServiceTableViewCell

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

- (void)configData{
    for (int i = 0 ; i < self.itemArray.count; i++) {
        LYServiceItemView * itemView = self.itemArray[i];
        [itemView configDataImageString:self.imageStringArray[i] title:self.titleArray[i]];
    }
}

/// 点击事件
/// @param index 第几个
- (void) clickItemIndex:(NSInteger)index{
    if ([self.delegate respondsToSelector:@selector(clickItemIndex:)]) {
        [self.delegate clickItemIndex:index];
    }
}

- (void) configUI {
    
    for (int i = 0; i< 8; i++) {
        LYServiceItemView * itemView = [[LYServiceItemView alloc]initWithFrame:CGRectZero];
        itemView.index = i;
        [self.contentView addSubview:itemView];
        __weak typeof(self)weakSelf = self;
        itemView.clickBack = ^(NSInteger index) {
            __strong typeof(weakSelf)strongSelf = weakSelf;
            [strongSelf clickItemIndex:index];
        };
        [self.itemArray addObject:itemView];
    }
}

+ (CGFloat)serviceCellHeight{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (width - 80) / 4;
    return 30 + (itemWidth + 20) * 2;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat itemWidth = (width - 80) / 4;
   for (int i = 0; i< self.itemArray.count; i++) {
       LYServiceItemView * itemView = self.itemArray[i];
       int hang = i / 4;
       int index = i % 4;
       CGFloat kMargin = index == 0 ? 10 : 20;
       [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.mas_equalTo(hang * (20 + itemWidth) + (hang + 1) * 10);
           make.left.mas_equalTo(index * (kMargin + itemWidth) + 10);
           make.width.mas_equalTo(itemWidth);
           make.height.mas_equalTo(itemWidth + 20);
       }];
    }
}

- (NSMutableArray<LYServiceItemView *> *)itemArray{
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
    }
    return _itemArray;
}

- (NSMutableArray *)imageStringArray{
    if (!_imageStringArray) {
        _imageStringArray = @[
            @"wx",@"wx",
            @"wx",@"wx",
            @"wx",@"wx",
            @"wx",@"wx"
        ].modelCopy;
    }
    return _imageStringArray;
}

- (NSMutableArray *)titleArray{
    if (!_titleArray) {
        _titleArray = @[
            @"订单列表",@"材料流转",
            @"工作申请",@"统计中心",
            @"资料中心",@"工作日历",
            @"贷款计算",@"更多"
        ].mutableCopy;
    }
    return _titleArray;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
