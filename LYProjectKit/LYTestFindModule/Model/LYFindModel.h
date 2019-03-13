// LYFindModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/12. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
/**
    类描述
 */


#import <Foundation/Foundation.h>

@protocol LYCellModelProtocol;

NS_ASSUME_NONNULL_BEGIN

@interface LYFindModel : NSObject<LYCellModelProtocol>
/**< name*/
@property(nonatomic,copy)NSString *  name;
/**< des*/
@property(nonatomic,copy)NSString *  des;
@end

NS_ASSUME_NONNULL_END
