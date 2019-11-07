// LYTransactionSaleTableViewCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYTradePageModel.h"
NS_ASSUME_NONNULL_BEGIN

@protocol LYTransactionSaleTableViewCellDelegate <NSObject>
- (void) unSaleAction:(LYTradePageModel *)model;
@end

@interface LYTransactionSaleTableViewCell : UITableViewCell
/**< <#des#>*/
@property(nonatomic,weak)id<LYTransactionSaleTableViewCellDelegate> delegate;
- (void) configDataWithModel:(LYTradePageModel *)model;
- (void) configBtnEnable:(BOOL)enable;
@end

NS_ASSUME_NONNULL_END
