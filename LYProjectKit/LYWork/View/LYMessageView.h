// LYMessageView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYMessageView : UIView
/**< 更多*/
@property(nonatomic,strong)UIButton * moreBtn;

/// 配置数据
/// @param labelText 标签
/// @param message w信息
- (void)configDataLabelText:(NSString *)labelText message:(NSString *)message;

- (void) updateCon;
@end

NS_ASSUME_NONNULL_END
