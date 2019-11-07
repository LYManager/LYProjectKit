// LYTransactionSaleTableViewCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYTradePageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYTransactionSaleTableViewCell : UITableViewCell
- (void) configDataWithModel:(LYTradePageModel *)model;
@end

NS_ASSUME_NONNULL_END
