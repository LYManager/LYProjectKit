// LYTradeRecordPageModel.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTradeRecordPageModel.h"

@implementation LYTradeRecordPageModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"recordId" : @"id",
    };
}
@end

