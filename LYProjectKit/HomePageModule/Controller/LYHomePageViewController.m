// LYHomePageViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
// <#Class des#>
#import "LYHomePageViewController.h"
#import "LYAlert.h"
#import <MGJRouter.h>
#import "UIButton+Gradient.h"
@interface LYHomePageViewController ()

@end

@implementation LYHomePageViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    [LYNetwork POSTWithApiPath:getMobileCodeURL requestParams:@{@"loginDTO":@{
                                                                      @"mobile":@"16675178115"
       }} handler:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
           
       }];
    
//    [LYNetwork POSTWithApiPath:registerURL requestParams:@{@"loginDTO":@{
//                                                                   @"inviteCode":@"",
//                                                                   @"mobile":@"16675178115",
//                                                                   @"mobileCode":@"",
//                                                                   @"password":@"123456",
//                                                                   @"transPassword":@""
//    }} handler:^(NSDictionary * _Nonnull response, NSError * _Nonnull error) {
//        
//    }];
    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [LYProgressHUD ly_dismissHUD];
//    });
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [button ly_gradint];
    [self.view addSubview:button];


}

- (void)buttonAction
{

}



#pragma mark - Life
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [MGJRouter openURL:@"shengTaiVC" withUserInfo:
            @{
              @"navigationVC":self.navigationController
              }
            completion:^(id result) {
                NSLog(@"%@",result);
    }];
//    LYHomePageViewController *vc = [LYHomePageViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}
#pragma mark - Public Methods

#pragma mark - Notification

#pragma mark - Delegate

#pragma mark - Private Methods
- (void)back
{
    
}
#pragma mark - Lazy

#pragma mark - dealloc
- (void) dealloc
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
