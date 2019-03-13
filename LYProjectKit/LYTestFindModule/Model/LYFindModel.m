// LYFindModel.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/12. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYFindModel.h"
#import "LYCellModelProtocol.h"
@implementation LYFindModel
- (NSString *)cellIdentifier
{
    return @"LYFindTableViewCell";
}
- (CGFloat)cellHeight
{
    return UITableViewAutomaticDimension;
}
@end
