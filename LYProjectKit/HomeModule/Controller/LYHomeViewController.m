// LYHomeViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/21. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYHomeViewController.h"
#import "LYMineViewController.h"
#import "LYShengTaiViewController.h"
@interface LYHomeViewController ()

@end

@implementation LYHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


/// 生态
/// @param sender s
- (IBAction)shengTaiAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"LYShengTaiViewController" params:nil];
    NSLog(@"生态");
}

/// 资讯
/// @param sender sender
- (IBAction)zixunAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"" params:nil];
}

/// 交易
/// @param sender sender
- (IBAction)jiaoyiAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"" params:nil];
}

/// 我的
/// @param sender sender
- (IBAction)mineAction:(UIButton *)sender {
    [self pushViewControllerWithClassName:@"LYMineViewController" params:nil];
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
