// LYTestWebViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/8/8. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYTestWebViewController.h"
#import <WebViewJavascriptBridge.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import <NSObject+YYModel.h>
@interface LYTestWebViewController ()<UIWebViewDelegate>
/**< webView*/
@property(nonatomic,strong)UIWebView * webView;
/**< <#des#>*/
@property(nonatomic,strong)WebViewJavascriptBridge * bridge;
@end

@implementation LYTestWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSData *jsonData = [@"{\"mst\":\"test\"}" dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    
    
   
    self.webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://shop.tianxiamengzhu.com?type=ios"]]];
    
    [WebViewJavascriptBridge enableLogging];
   
    // Do any additional setup after loading the view.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    JSContext *ctx = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    ctx[@"console"][@"log"] = ^(JSValue * msg) {
    
        NSData *jsonData = [[msg.toString stringByReplacingOccurrencesOfString:@"'" withString:@"\""] dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                            options:NSJSONReadingMutableContainers
                                                              error:&err];
//        NSLog(@"%@",msg.toString);
        NSLog(@"H5  log : %@", dic);
    };
    
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
