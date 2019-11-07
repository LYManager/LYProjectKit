//
//  PayDetailViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/1.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "PayDetailViewController.h"

@interface PayDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *mineyLab;
@property (weak, nonatomic) IBOutlet UIImageView *codeImage;
@property (weak, nonatomic) IBOutlet UILabel *orderId;

@end

@implementation PayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)connectAction:(id)sender {
}
- (IBAction)cancelAction:(id)sender {
}
- (IBAction)payAction:(id)sender {
}
- (IBAction)complaintAction:(id)sender {
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
