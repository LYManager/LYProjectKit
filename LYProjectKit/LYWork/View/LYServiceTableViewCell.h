// LYServiceTableViewCell.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LYServiceTableViewCellDelegate <NSObject>

- (void) clickItemIndex:(NSInteger)index;

@end

@interface LYServiceTableViewCell : UITableViewCell
/**< <#des#>*/
@property(nonatomic,weak)id<LYServiceTableViewCellDelegate> delegate;
/**< 高度*/
@property(nonatomic,assign,readonly,class)CGFloat serviceCellHeight;

- (void) configData;  // 测试方法，自己修改
@end

NS_ASSUME_NONNULL_END
