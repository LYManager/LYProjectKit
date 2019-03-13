// UITabBar+Repair_iOS_12_1_bug.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "UITabBar+Repair_iOS_12_1_bug.h"
#import <objc/runtime.h>

static CGFloat const kIPhoneXTabbarButtonErrorHeight = 33;
static CGFloat const kIPhoneXTabbarButtonHeight = 48;

//CG_INLINE BOOL
//LYOverrideImplementation(Class targetClass, SEL targetSelector) {
//    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
//    if (!originMethod) {
//        return NO;
//    }
//    IMP originIMP = method_getImplementation(originMethod);
//    id(^impleBlock)(Class orginClass,SEL orginSelector) =(id) ^(Class cls,SEL sel) {
//        return ^(UIView *selfObject,CGRect firstArgv){
//            if ([selfObject isKindOfClass:cls]) {
//                // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
//                if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
//                    return;
//                }
//            }
//            //兼容IphoneX
//            if (firstArgv.size.height == kIPhoneXTabbarButtonErrorHeight) {
//                firstArgv.size.height = kIPhoneXTabbarButtonHeight;
//            }
//            void (*originSelectorIMP)(id, SEL, CGRect);
//            originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
//            originSelectorIMP(selfObject, sel, firstArgv);
//        };
//    };
//    method_setImplementation(originMethod, imp_implementationWithBlock(impleBlock(targetClass,targetSelector)));
//    return YES;
//}
CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(Class originClass, SEL originCMD, IMP originIMP)) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    if (!originMethod) {
        return NO;
    }
    IMP originIMP = method_getImplementation(originMethod);
    method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originIMP)));
    return YES;
}

@implementation UITabBar (Repair_iOS_12_1_bug)
+ (void)load {

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (@available(iOS 12.1, *)) {
            OverrideImplementation(NSClassFromString(@"UITabBarButton"), @selector(setFrame:), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP originIMP) {
                return ^(UIView *selfObject, CGRect firstArgv) {

                    if ([selfObject isKindOfClass:originClass]) {
                        // 如果发现即将要设置一个 size 为空的 frame，则屏蔽掉本次设置
                        if (!CGRectIsEmpty(selfObject.frame) && CGRectIsEmpty(firstArgv)) {
                            return;
                        }
                    }
                    //兼容IphoneX
                    if (firstArgv.size.height == kIPhoneXTabbarButtonErrorHeight) {
                        firstArgv.size.height = kIPhoneXTabbarButtonHeight;
                    }
                    void (*originSelectorIMP)(id, SEL, CGRect);
                    originSelectorIMP = (void (*)(id, SEL, CGRect))originIMP;
                    originSelectorIMP(selfObject, originCMD, firstArgv);
                };
            });
        }
    });
}
@end
