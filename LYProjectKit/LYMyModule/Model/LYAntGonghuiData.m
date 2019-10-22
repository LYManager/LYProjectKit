// LYAntGonghuiData.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYAntGonghuiData.h"

@implementation LYAntGonghuiData
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"data" : [LYAntGonghuiDataModel class]
    };
}
@end

@implementation LYAntGonghuiDataModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"propsCardList" : [LYAntCardModel class]
    };
}
@end
