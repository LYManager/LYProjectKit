// LYTradePageModel.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/6. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYTradePageModel.h"

@implementation LYTradePageModel
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper {
    return @{
        @"tradeId" : @"id",
    };
}
- (NSString *)mobile{
    return _mobile.length >= 7 ? [_mobile stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"] : _mobile;
}
- (NSString *)phoneNumber{
    return _mobile;
}
@end
