// LYAVOSCloudManager.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/28. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYAVOSCloudManager.h"
#import <AVOSCloud.h>

static NSString * const kAppId = @"lSKy6cV4UGpBNoSAeoVJmwGF-gzGzoHsz";
static NSString * const kAppKey = @"hYVKTmQ7XheQdwUIawAHb1Ux";
static NSString * const kServerUrl = @"https://xcmopqpe.lc-cn-n1-shared.com";

@implementation LYAVOSCloudManager
+ (instancetype)shareInstance{
    static LYAVOSCloudManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[LYAVOSCloudManager alloc]init];
    });
    return manager;
}


- (void)registerCloud{
    [AVOSCloud setApplicationId:kAppId clientKey:kAppKey serverURLString:kServerUrl];
    //开启调试日志
    [AVOSCloud setAllLogsEnabled:YES];
    
    AVQuery *query = [AVQuery queryWithClassName:@"Share"];
   [query getObjectInBackgroundWithId:@"5b8cd174d50eee0039370335" block:^(AVObject *object, NSError *error) {
       //        [MBProgressHUD hideHUDForView:view animated:YES];

       // object 就是 id 为 56f8aab879bc44005920635e 的 Todo 对象实例
       NSString *location = [object objectForKey:@"showStr"];


       NSLog(@"%@",location);

   }];
}


@end
