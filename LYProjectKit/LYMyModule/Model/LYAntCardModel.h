// LYAntCardModel.h 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/22. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYAntCardModel : NSObject
/**< card id*/
@property(nonatomic,assign)NSInteger cardId;
/**< card num*/
@property(nonatomic,assign)NSInteger cardCount;
/**< card name*/
@property(nonatomic,copy)NSString *  cardName;
@end

NS_ASSUME_NONNULL_END
