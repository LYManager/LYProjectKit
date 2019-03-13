// LYWebViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/12. 
// Copyright © 2019 赵良育. All rights reserved. 
// 
// <#Class des#>
#import "LYWebViewController.h"

@interface LYWebViewController ()

@end

@implementation LYWebViewController

- (instancetype)init
{
    return [self initWithType:LYWebViewType_UIWebView];
}

- (instancetype)initWithType:(LYWebViewType)webViewType
{
    if (self = [super init]) {
        _webViewType = webViewType;
    }
    return self;
}

//- (void)loadView{
//    
//}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

#pragma mark - Life

#pragma mark - Public Methods

#pragma mark - Notification

#pragma mark - Delegate

#pragma mark - Private Methods

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
