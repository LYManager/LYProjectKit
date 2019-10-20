// LYShengTaiShopCardCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYShengTaiBaseTableViewCell.h"
#import "LYShengTaiCardType.h"
NS_ASSUME_NONNULL_BEGIN



@interface LYShengTaiShopCardCell : LYShengTaiBaseTableViewCell
- (void) configData:(id)data type:(LYShengTaiShopCardType)cardType;
@end

NS_ASSUME_NONNULL_END
