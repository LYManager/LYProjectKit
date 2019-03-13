// LYWebView.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/12. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 JS调用OC处理 代理
 */
@protocol JSCallOCHandlerDelegate <NSObject>

@end

/**
 OC调用JS回调 代理
 */
@protocol OCCallJSBackDelegate <NSObject>

@end



@interface LYWebView<WebView> : UIView
/**< webView*/
@property(nonatomic,strong)WebView webView;



@end

NS_ASSUME_NONNULL_END
