// LYTradeModel.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTradeModel.h"

@implementation LYTradeModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"data" : [LYTradeModelData class]
    };
}
@end

@implementation LYTradeList

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"pageList" : [LYTradePageModel class]
    };
}

@end

@implementation LYTradeModelData

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"tradeList" : [LYTradeList class]
    };
}

@end
