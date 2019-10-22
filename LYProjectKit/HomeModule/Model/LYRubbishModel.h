// LYRubbishModel.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYRubbishModel : NSObject
/**< id*/
@property(nonatomic,assign)NSInteger rubbishId;
/**< name*/
@property(nonatomic,copy)NSString *  rubbishName;
/**< type*/
@property(nonatomic,assign)NSInteger rubbishType;
/**< icon url*/
@property(nonatomic,copy)NSString *  rubbishUrl;
@end

NS_ASSUME_NONNULL_END
