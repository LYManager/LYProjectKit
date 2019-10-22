// LYFindModel.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/12. 
// Copyright © 2019 Sunshie. All rights reserved. 
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
