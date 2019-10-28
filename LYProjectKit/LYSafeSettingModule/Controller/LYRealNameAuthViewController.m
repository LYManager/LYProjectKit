// LYRealNameAuthViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYRealNameAuthViewController.h"

@interface LYRealNameAuthViewController ()
@property (weak, nonatomic) IBOutlet UITextField *realNameTF;
@property (weak, nonatomic) IBOutlet UITextField *cardTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTF;
@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@end

@implementation LYRealNameAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTextFieldPlaceholder];
    
    [self.commitBtn ly_gradint];
    
    self.navigationItem.title = @"实名认证";
    
    // Do any additional setup after loading the view from its nib.
}

- (void) configTextFieldPlaceholder{
    self.realNameTF.attributedPlaceholder = [self.realNameTF.placeholder ly_attributePlaceholder];
    self.cardTF.attributedPlaceholder = [self.cardTF.placeholder ly_attributePlaceholder];
    self.phoneNumberTF.attributedPlaceholder = [self.phoneNumberTF.placeholder ly_attributePlaceholder];
}

#pragma mark🐒------提交------🐒
- (IBAction)commitAction:(UIButton *)sender {
    
    if (self.realNameTF.text.length == 0) {
           [self.view makeToast:@"姓名不能为空" duration:2 position:CSToastPositionCenter];
           return;
       }
    if (self.phoneNumberTF.text.length !=11) {
        [self.view makeToast:@"手机号输入不正确" duration:2 position:CSToastPositionCenter];
        return;
    }
    if (self.cardTF.text.length ==0) {
        [self.view makeToast:@"身份证号不能为空" duration:2 position:CSToastPositionCenter];
        return;
    }
   
    
//    提交参数
    LYAntCardModel * model = self.params[@"realNameCardModel"];
    [self popToolsController:model isRealCheck:YES callBack:^(NSString * _Nonnull pwd) {
       [self loadRequestWithPwd:pwd];
    }];
}
//提交数据
- (void) loadRequestWithPwd:(NSString *)pwd{
    [LYNetwork POSTWithApiPath:idCardValiURL requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?: @"",
        @"keyWords":pwd,
        @"userCardDto":@{
                @"mobile":self.phoneNumberTF.text ?:@"",
                @"userCardNum":self.cardTF.text ?:@"",
                @"userName": self.realNameTF.text ? :@""
                    // [self utf8ToUnicode:self.realNameTF.text] ?:@""
        }
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self.view makeToast:@"认证成功" duration:1 position:CSToastPositionCenter];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    }];
}


 -(NSString *)utf8ToUnicode:(NSString *)string{

    NSUInteger length = [string length];
    NSMutableString *str = [NSMutableString stringWithCapacity:0];
    for (int i = 0;i < length; i++){
    NSMutableString *s = [NSMutableString stringWithCapacity:0];
    unichar _char = [string characterAtIndex:i];
    // 判断是否为英文和数字
    if (_char <= '9' && _char >='0'){
    [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
    }else if(_char >='a' && _char <= 'z'){
    [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
    }else if(_char >='A' && _char <= 'Z')
    {
    [s appendFormat:@"%@",[string substringWithRange:NSMakeRange(i,1)]];
    }else{
    // 中文和字符
    [s appendFormat:@"\\u%x",[string characterAtIndex:i]];
    // 不足位数补0 否则解码不成功
    if(s.length == 4) {
    [s insertString:@"00" atIndex:2];
    } else if (s.length == 5) {
    [s insertString:@"0" atIndex:2];
    }
    }
    [str appendFormat:@"%@", s];
    }
//    [str stringByReplacingOccurrencesOfString:@"\\\\" withString:@"\\"];

    return str;

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
