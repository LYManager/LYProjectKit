//
//  ReleaseBuyViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ReleaseBuyViewController.h"

@interface ReleaseBuyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *shuomingLab;
@property (nonatomic,strong)NSString *zongjiaStr;
@end

@implementation ReleaseBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"发布买单";
    [self.submitBtn ly_gradint];
  
    self.numberText.attributedPlaceholder = [self.numberText.placeholder ly_attributePlaceholder];
    self.priceLab.attributedPlaceholder = [self.priceLab.placeholder ly_attributePlaceholder];
    self.balanceLab.text = [NSString stringWithFormat:@"%@%.2f",@"我的AGC余额",self.model.data.agcAomount];
    self.referenceLab.text = [NSString stringWithFormat:@"%@%.2f%@",@"市场参考价1AGC≈",self.model.data.agcToRmb,@"CNY"];
    self.numberText.delegate =self;
    self.priceLab.delegate =self;
    
    NSString *str = [self.model.data.tradeShow stringByReplacingOccurrencesOfString:@"\\n\n" withString:@"\n"];
    self.shuomingLab.text = str;


    
    
    
    
}
-(void)textFieldDidChangeSelection:(UITextField *)textField
{
    if (self.numberText.text.length !=0 && self.priceLab.text.length !=0) {
        CGFloat zongjia = [self.numberText.text floatValue] *[self.priceLab.text floatValue];
        self.zongjiaLab.text = [NSString stringWithFormat:@"%.2fCNY",zongjia];
        self.zongjiaStr = [NSString stringWithFormat:@"%.2f",zongjia];
    }
    
}

- (IBAction)submitAction:(id)sender {
    
    
    
    if (self.numberText.text.length == 0) {
        [self.view makeToast:@"请输入买入数量" duration:1 position:CSToastPositionCenter];
        return;
    }
    if (self.priceLab.text.length == 0) {
        [self.view makeToast:@"请输入买入单价" duration:1 position:CSToastPositionCenter];
        return;
    }
    
    [self popTradePwdControllerType:TradePopType_Buy AGC:self.numberText.text CNY:self.zongjiaStr backBlock:^(NSString * _Nonnull pwd) {
        
        
        [LYNetwork POSTWithApiPath:buyURL requestParams:@{
             @"quantity":self.numberText.text,
             @"unitPrice":self.priceLab.text,
             @"keyWords":pwd?:@""
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"发布成功" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 !self.successCallback ? : self.successCallback();
                 [self.navigationController popViewControllerAnimated:YES];
                 

             });
         }];
    }];
    
    
    
     
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
