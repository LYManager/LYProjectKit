//
//  UIView+WKCore.h
//  BiTeGou
//
//  Created by 我是Waker同学 on 2019/6/23.
//  Copyright © 2019 walker. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES)
- (NSData *)aes256_encrypt:(NSString *)key  ;
- (NSData *)aes256_decrypt:(NSString *)key ;
@end

NS_ASSUME_NONNULL_END
