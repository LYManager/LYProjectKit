//
//  ReleaseBuyViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/5.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ReleaseBuyViewController.h"

@interface ReleaseBuyViewController ()

@end

@implementation ReleaseBuyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.title = @"发布买单";
    [self.submitBtn ly_gradint];
  
    self.numberText.attributedPlaceholder = [self.numberText.placeholder ly_attributePlaceholder];
    self.priceLab.attributedPlaceholder = [self.priceLab.placeholder ly_attributePlaceholder];
    self.balanceLab.text = [NSString stringWithFormat:@"%@%f",@"我的AGC余额",self.model.data.agcAomount];

    
    
    
    
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
     [LYNetwork POSTWithApiPath:buyURL requestParams:@{
         @"quantity":self.numberText.text,
         @"unitPrice":self.priceLab.text,
         @"keyWords":@"123456"
     } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
    
         [self.view makeToast:@"发布成功" duration:1 position:CSToastPositionCenter];
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             [self.navigationController popViewControllerAnimated:YES];

         });
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
