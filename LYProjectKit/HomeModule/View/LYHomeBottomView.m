// LYHomeBottomView.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/21. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYHomeBottomView.h"

@implementation LYHomeBottomView

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
     UIView *v = [super hitTest:point withEvent:event];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:UIButton.class]) {
            CGPoint tempPoint = [view convertPoint:point fromView:self];
            if ([view pointInside:tempPoint withEvent:event]) {
                return view;
            }
        }
    }
    return v;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
