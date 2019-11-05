// LYGonghuiRecordTableViewCell.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYGonghuiRecordTableViewCell.h"
#import "LYGonghuiRecordModel.h"
#import "UIColor+Extention.h"
@interface LYGonghuiRecordTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *useTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *useDesLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;

@end

@implementation LYGonghuiRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configDataWithModel:(LYGonghuiRecordModel *)model{
    self.cardNameLabel.text = model.cardName;
    self.numLabel.text = model.cardCount > 0 ? [NSString stringWithFormat:@"+%ld",model.cardCount]:[NSString stringWithFormat:@"%ld",model.cardCount];
    self.numLabel.textColor = model.cardCount > 0 ? [UIColor redColor] : [UIColor ly_colorWithHexString:@"#10663B"];
    self.useTypeLabel.text = [self _getTypeString:model.type];
    self.useDesLabel.text = [self _getTypeDesString:model.type withUserID:model.userId];
    self.timeLabel.text = [self dateWithString:model.createDate Format:@"yyyy-MM-dd HH:mm"];
}

-(NSString *)_getTypeString:(NSInteger)type{
    if (type == 4) {
        return @"使用";
    }else if(type == 1){
        return @"赠送";
    }else if (type == 2){
        return @"获赠";
    }else{
        return @"拨卡";
    }
}
-(NSString *)_getTypeDesString:(NSInteger)type withUserID:(NSString *)userId{
    if (type == 4) {
        return @"";
    }else if(type == 1){
        return [NSString stringWithFormat:@"转出ID %@",userId];
    }else if (type == 2){
        return [NSString stringWithFormat:@"转入ID %@",userId];
    }else{
        return @"系统拨卡";
    }
}
//将时间戳转换为时间字符串
- (NSString*)dateWithString:(NSString*)str Format:(NSString*)format

{

    NSTimeInterval time = [str doubleValue]/1000;;

    /** [[NSDate date] timeIntervalSince1970]*1000;*/

    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象

    [dateFormatter setDateFormat:format];//设定时间格式,这里可以设置成自己需要的格式

    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;

}



@end
