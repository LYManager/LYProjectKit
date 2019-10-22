// LYShengTaiData.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYShengTaiData.h"

@implementation LYShengTaiData
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"data" : [LYShengTaiDataModel class]
    };
}
@end

@implementation LYShengTaiDataModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"taskList" : [LYTaskCardModel class]
    };
}

@end
