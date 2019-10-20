// LYPopContentView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/20. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYPopContentView.h"

@implementation LYPopContentView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}
@end
