//
//  PersistenceHelper.m
//  Coach
//
//  Created by lixiaowen on 16/4/13.
//  Copyright © 2016年 goxueche. All rights reserved.
//

#import "PersistenceHelper.h"

@implementation PersistenceHelper

+ (BOOL)setData:(id)obj forKey:(NSString *)key {
    if (obj && (obj != [NSNull null]) && key) {
        NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
        [persistentDefaults setValue:obj forKey:key];
        return [persistentDefaults synchronize];
    }
    return NO;
}

+ (id)dataForKey:(NSString *)key {
    if (key) {
        NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
        return [persistentDefaults objectForKey:key];
    }
    return nil;
}

+ (void)removeForKey:(NSString *)key {
    if (key) {
        NSUserDefaults *persistentDefaults = [NSUserDefaults standardUserDefaults];
        [persistentDefaults removeObjectForKey:key];
        [persistentDefaults synchronize];
    }
}

@end
