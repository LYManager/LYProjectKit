// LYSureSendCardView.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/31. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYSureSendCardView.h"
#import "LYAntCardModel.h"
@interface LYSureSendCardView ()
@property (weak, nonatomic) IBOutlet UILabel *cardNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation LYSureSendCardView
- (void)awakeFromNib{
    [super awakeFromNib];
    [self.commitBtn ly_gradint];
}

- (IBAction)commitAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commitActionSender:type:)]) {
        [self.delegate commitActionSender:sender type:LYSureSendCardViewAction_Commit];
    }
}

- (IBAction)cancelBtnAction:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(commitActionSender:type:)]) {
           [self.delegate commitActionSender:sender type:LYSureSendCardViewAction_Cancel];
       }
}

- (void)configDataWithCardName:(NSString *)cardName dataDict:(NSDictionary *)data
{
    self.cardNameLabel.text = cardName;
    self.numLabel.text =  data[@"num"];
    self.idLabel.text = data[@"userId"];
    self.userNameLabel.text = data[@"nickName"];
    self.phoneLabel.text = data[@"mobile"];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
