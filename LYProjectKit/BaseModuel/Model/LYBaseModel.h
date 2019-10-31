// LYBaseModel.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYBaseModel : NSObject
/**< code*/
@property(nonatomic,assign)NSInteger code;
/**< message*/
@property(nonatomic,copy)NSString *  message;
/**< time*/
@property(nonatomic,copy)NSString * systemTime;
@end

NS_ASSUME_NONNULL_END
