//
//  NSDictionary+TypeSafe.m
//  Coach
//
//  Created by 我是Waker同学 on 2019/3/19.
//  Copyright © 2019 walker. All rights reserved.
//

#import "NSDictionary+TypeSafe.h"

@implementation NSDictionary (MLSNSDictionaryTypeSafeAdditions)

- (id)objectForKey:(id)aKey ofClass:(Class)aClass
{
    id value = [self objectForKey:aKey];
    
    if (![value isKindOfClass:aClass]) {
        value = nil;
    }
    
    return value;
}

- (NSString *)kgstringForKey:(id)aKey
{
    id value = [self objectForKey:aKey];
    if([value isKindOfClass:[NSNumber class]]) {
        return  [((NSNumber *)value) stringValue];
    } else {
        return [self objectForKey:aKey ofClass:[NSString class]];
    }
}

- (NSArray *)kgarrayForKey:(id)aKey
{
    return [self objectForKey:aKey ofClass:[NSArray class]];
}

- (NSDictionary *)kgdictionaryForKey:(id)aKey
{
    return [self objectForKey:aKey ofClass:[NSDictionary class]];
}

- (NSInteger)kgintegerForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(integerValue)]) {
        return [object integerValue];
    } else {
        return 0;
    }
}

- (float)kgfloatForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(floatValue)]) {
        return [object floatValue];
    } else {
        return 0;
    }
}

- (BOOL)kgboolForKey:(id)aKey
{
    id object = [self objectForKey:aKey];
    if ([object respondsToSelector:@selector(boolValue)]) {
        return [object boolValue];
    } else if ([object respondsToSelector:@selector(integerValue)]) {
        return ([object integerValue] != 0);
    } else {
        return 0;
    }
}


@end
