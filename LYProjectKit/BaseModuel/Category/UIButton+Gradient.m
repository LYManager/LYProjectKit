// UIButton+Gradient.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/18. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "UIButton+Gradient.h"
#import "UIColor+Extention.h"

@implementation UIButton (Gradient)
- (void)ly_gradint{
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
   gradientLayer.frame = self.bounds;
   gradientLayer.colors = @[(__bridge id)[UIColor ly_colorWithHexString:@"#0DC2A6"].CGColor,(__bridge id)[UIColor ly_colorWithHexString:@"#02A9ED"].CGColor];
   gradientLayer.startPoint = CGPointMake(0, 0);
   gradientLayer.endPoint = CGPointMake(1, 0);
   gradientLayer.locations = @[@0,@1];
    self.layer.cornerRadius = self.frame.size.height / 2;
    self.clipsToBounds = true;
//   [self.layer addSublayer:gradientLayer];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

- (void)ly_gradintLeftCircle{
    CAGradientLayer * gradientLayer = [CAGradientLayer layer];
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[(__bridge id)[UIColor ly_colorWithHexString:@"#0DC2A6"].CGColor,(__bridge id)[UIColor ly_colorWithHexString:@"#02A9ED"].CGColor];
    gradientLayer.startPoint = CGPointMake(0, 0);
    gradientLayer.endPoint = CGPointMake(1, 0);
    gradientLayer.locations = @[@0,@1];
    [self.layer addSublayer:gradientLayer];
//     [self.layer insertSublayer:gradientLayer atIndex:0];
    
    CGFloat radio = self.frame.size.height / 2;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect: self.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft cornerRadii:CGSizeMake(radio,radio)];
   CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
   maskLayer.frame = self.bounds;
   //赋值
   maskLayer.path = maskPath.CGPath;
   self.layer.mask = maskLayer;
    [self bringSubviewToFront:self.imageView];
    
}
@end
