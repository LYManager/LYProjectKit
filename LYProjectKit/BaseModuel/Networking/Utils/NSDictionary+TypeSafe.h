//
//  NSDictionary+TypeSafe.h
//  Coach
//
//  Created by 我是Waker同学 on 2019/3/19.
//  Copyright © 2019 walker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (MLSNSDictionaryTypeSafeAdditions)


- (id)objectForKey:(id)aKey ofClass:(Class)aClass;

- (NSString *)kgstringForKey:(id)aKey;
- (NSArray *)kgarrayForKey:(id)aKey;
- (NSDictionary *)kgdictionaryForKey:(id)aKey;
- (NSInteger)kgintegerForKey:(id)aKey; // 值为数字、字符串都可以
- (float)kgfloatForKey:(id)aKey; // 值为数字、字符串都可以
- (BOOL)kgboolForKey:(id)aKey; // 值为布尔、数字、字符串都可以

@end
