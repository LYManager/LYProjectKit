//
//  TopUpViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "TopUpViewController.h"

@interface TopUpViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *coinLab;
@property (weak, nonatomic) IBOutlet UILabel *rmbLab;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UILabel *urlLab;
@property (weak, nonatomic) IBOutlet UIButton *fuzhiBtn;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (nonatomic,strong)NSString *urlStr;


@end

@implementation TopUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"充值";
    self.nameLab.text = self.assModel.name;
    self.coinLab.text = self.assModel.agcAmount;
    self.rmbLab.text = [NSString stringWithFormat:@"%@%@%@",@"≈",self.assModel.agcToRmb,@"CNY"];
    [self.codeImage sd_setImageWithURL:[NSURL URLWithString:self.assModel.iconUrl]];
    self.urlLab.text = self.assModel.userAddress;
    self.urlStr = self.assModel.userAddress;

    NSString *strUrl = [self.recon stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];

    self.detailLab.text = strUrl;


}
- (IBAction)fuzhiAction:(id)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
          pab.string = self.urlStr;
          if (pab == nil) {
              [self.view makeToast:@"复制失败" duration:1 position:CSToastPositionCenter];

          } else {
              [self.view makeToast:@"已复制" duration:1 position:CSToastPositionCenter];

          }
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
