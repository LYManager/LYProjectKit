// LYGonghuiRecordModel.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYGonghuiRecordModel.h"

@implementation LYGonghuiRecordModel

@end

@implementation LYGOnghuiRecordData
+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    return @{
        @"data" : [LYGonghuiRecordModel class]
    };
}
@end
