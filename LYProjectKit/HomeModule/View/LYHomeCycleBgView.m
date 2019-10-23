// LYHomeCycleBgView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/23. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYHomeCycleBgView.h"
#import "LYHomeCycleItemView.h"
@implementation LYHomeCycleBgView
- (void)awakeFromNib{
    [super awakeFromNib];
//    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    [self addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
        CGPoint touchPoint = [tap locationInView:self];
        for (UIView *marqueeView in self.subviews) {
            if ([marqueeView isKindOfClass:LYHomeCycleItemView.class]) {
                CALayer *layer = [marqueeView.layer.presentationLayer hitTest:touchPoint];
                if (layer) {
                    
                    // [marqueeView.delegate activityMarqueeViewClick:marqueeView];
                    break;
                }
            }
        }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [event.allTouches anyObject];
    if (@available(iOS 9.1, *)) {
        CGPoint locationPointWindow = [touch preciseLocationInView:self];
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIImageView class]]) {
                for (UIView * child in view.subviews) {
                     NSLog(@"===== %@",NSStringFromCGRect(child.layer.presentationLayer.frame));
//                    CALayer * layer = [child.layer.presentationLayer hitTest:locationPointWindow];
//                    if (layer) {
//                        LYHomeCycleItemView * click = (LYHomeCycleItemView *)child;
//                        NSLog(@"===== %@",click.model.rubbishName);
//                    }
                }
            }
        }
        NSLog(@"TouchLocationWindow:(%.1f,%.1f)",locationPointWindow.x,locationPointWindow.y);
    } else {
        
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
