// LYFindModel.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/3/12. 
// Copyright © 2019 Sunshie. All rights reserved. 
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
