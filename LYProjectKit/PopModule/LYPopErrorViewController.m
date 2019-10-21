// LYPopErrorViewController.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/10/21. 
// Copyright © 2019 赵良育. All rights reserved. 
// 

#import "LYPopErrorViewController.h"
#import "LYPopContentView.h"
@interface LYPopErrorViewController ()
@property (weak, nonatomic) IBOutlet LYPopContentView *contentView;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;
@end

@implementation LYPopErrorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}
- (void)viewWillAppear:(BOOL)animated{
    CABasicAnimation *theAnimation = [self fromValue:@(0.6) toValue:@1];
    [self.contentView.layer addAnimation:theAnimation forKey:@"animateTransform"];
}

/// 联系客服
/// @param sender sender
- (IBAction)contactCustomerServiceAction:(UIButton *)sender {
    
}


- (IBAction)cancelBtnAction:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void) dismiss {
    
}


- (CABasicAnimation *) fromValue:(NSNumber *)fromValue toValue:(NSNumber *)toValue{
    CABasicAnimation *theAnimation;
    theAnimation=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    theAnimation.duration=0.1;
    theAnimation.removedOnCompletion = YES;
    theAnimation.fromValue = fromValue;
    theAnimation.toValue = toValue;
    [self.contentView.layer addAnimation:theAnimation forKey:@"animateTransform"];
    return theAnimation;
}



- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    [self.commitBtn ly_gradint];
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
