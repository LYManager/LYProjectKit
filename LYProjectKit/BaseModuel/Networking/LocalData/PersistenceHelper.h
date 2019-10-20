//
//  PersistenceHelper.h
//  Coach
//
//  Created by lixiaowen on 16/4/13.
//  Copyright © 2016年 goxueche. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PersistenceHelper : NSObject {
    
}

+ (BOOL)setData:(id)obj forKey:(NSString *)key;
+ (id)dataForKey:(NSString *)key;
+ (void)removeForKey:(NSString *)key;

@end
