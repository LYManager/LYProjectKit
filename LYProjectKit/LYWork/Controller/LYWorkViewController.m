// LYWorkViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYWorkViewController.h"
#import "LYWorkPresenter.h"
@interface LYWorkViewController ()
/**< presenter*/
@property(nonatomic,strong)LYWorkPresenter * presenter;
@end

@implementation LYWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.presenter bindVC:self];
  
}

#pragma mark🐒------lazy------🐒
- (LYWorkPresenter *)presenter{
    if (!_presenter) {
        _presenter = [[LYWorkPresenter alloc]init];
    }
    return _presenter;
}
@end
