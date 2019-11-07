// LYTransactionHeaderView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/29. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
#import "LYTradeModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface LYTransactionHeaderView : UIView
- (void) configDataWithModel:(LYTradeModel *)model;
@end

NS_ASSUME_NONNULL_END
