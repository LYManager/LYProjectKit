// LYGonghuiRecordTableViewCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>
@class LYGonghuiRecordModel;
NS_ASSUME_NONNULL_BEGIN

@interface LYGonghuiRecordTableViewCell : UITableViewCell
- (void) configDataWithModel:(LYGonghuiRecordModel *)model;
@end

NS_ASSUME_NONNULL_END
