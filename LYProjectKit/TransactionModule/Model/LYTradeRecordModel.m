// LYTradeRecordModel.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTradeRecordModel.h"

@implementation LYTradeRecordModel
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"data" : [LYTradeRecordModelData class]
    };
}
@end

@implementation LYTradeRecordModelData
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"pageList" : [LYTradeRecordPageModel class]
    };
}


@end
