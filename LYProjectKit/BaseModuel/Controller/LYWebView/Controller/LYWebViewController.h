// LYWebViewController.h 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/12. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 
/**
    类描述
 */


#import "LYBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,LYWebViewType) {
    LYWebViewType_WKWebView,
    LYWebViewType_UIWebView
};

@interface LYWebViewController : LYBaseViewController

/**< type*/
@property(nonatomic,assign,readonly)LYWebViewType webViewType;
/**< url*/
@property(nonatomic,copy)NSString *  urlString;

- (instancetype)initWithType:(LYWebViewType)webViewType;

@end

NS_ASSUME_NONNULL_END
