// LYTabBarData.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/3/9. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#ifndef LYTabBarData_h
#define LYTabBarData_h /*为了下边方便设置*/ @"selected"

// TabBar标题多语言keys
 NSString *LYTabBarItemTitleKeys[] = {
    [0]   = @"ly_home_tab_item_title_key",
    [1]   = @"ly_category_tab_item_title_key",
    [2]   = @"ly_find_tab_item_title_key",
    [3]   = @"ly_mine_tab_item_title_key"
};
// TabBar默认图标names
 NSString *LYTabBarItemImageNames[] = {
    [0]   = @"ly_tab_bar_item_one",
    [1]   = @"ly_tab_bar_item_two",
    [2]   = @"ly_tab_bar_item_three",
    [3]   = @"ly_tab_bar_item_four",
};

NS_INLINE NSString * select_image_name(NSInteger index){
    NSString * defaultImageName = LYTabBarItemImageNames[index];
    return [NSString stringWithFormat:@"%@_%@",defaultImageName,LYTabBarData_h];
}

NS_INLINE NSArray<Class> *controllerArray(){
    return  @[
              NSClassFromString(@"LYHomePageViewController"),
              NSClassFromString(@"LYFindViewController"),
              NSClassFromString(@"LYHomePageViewController"),
              NSClassFromString(@"LYHomePageViewController")
              ];
}


#endif /* LYTabBarData_h */
