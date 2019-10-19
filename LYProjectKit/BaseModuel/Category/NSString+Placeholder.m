// NSString+Placeholder.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/19. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "NSString+Placeholder.h"
#import "UIColor+Extention.h"

@implementation NSString (Placeholder)
- (NSMutableAttributedString *)ly_attributePlaceholder{
    NSMutableAttributedString * attr = [[NSMutableAttributedString alloc]initWithString:self];
    [attr addAttributes:@{NSForegroundColorAttributeName:[UIColor ly_colorWithHexString:@"#5A85AC"]} range:NSMakeRange(0, self.length)];
    return attr;
}
@end
