// LYCellModelProtocol.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/12. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
/// 有关于TableViewCell的模型数据，都需要遵循这个协议
@protocol LYCellModelProtocol <NSObject>

/**
 获取cell重用标识

 @return 标识
 */
- (NSString *)cellIdentifier;

/**
 获取cell高度

 @return 高度
 */
- (CGFloat)cellHeight;
@end

NS_ASSUME_NONNULL_END
