// LYShengTaiShopCardCell.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYShengTaiBaseTableViewCell.h"
#import "LYShengTaiCardType.h"
@class LYTaskCardModel;
NS_ASSUME_NONNULL_BEGIN

@protocol LYShengTaiShopCardCellDelegate <NSObject>

- (void) buyBtnActionCell:(LYShengTaiBaseTableViewCell *)cell;

@end

@interface LYShengTaiShopCardCell : LYShengTaiBaseTableViewCell
/**< d*/
@property(nonatomic,weak)id<LYShengTaiShopCardCellDelegate> delegate;
- (void) configData:(LYTaskCardModel *)data type:(LYShengTaiShopCardType)cardType;
@end

NS_ASSUME_NONNULL_END
