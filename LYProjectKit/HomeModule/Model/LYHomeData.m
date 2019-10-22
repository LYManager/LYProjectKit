// LYHomeData.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYHomeData.h"

@implementation LYHomeData
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
//        @"rubbishList" : [LYRubbishModel class],
        @"data":[LYHomeDataModel class]
    };
}
@end

@implementation LYHomeDataModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"rubbishList" : [LYRubbishModel class]
    };
}

@end
