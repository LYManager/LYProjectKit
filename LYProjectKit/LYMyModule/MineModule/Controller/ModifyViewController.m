//
//  ModifyViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ModifyViewController.h"

@interface ModifyViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameText;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation ModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改昵称";
    self.nameText.text = self.nameStr;
    [self.submitBtn ly_gradint];
}
- (IBAction)submitAction:(id)sender {
    
    if (self.nameText.text.length == 0) {
        [self.view makeToast:@"昵称不能为空" duration:1 position:CSToastPositionCenter];
        return;
    }
    
//    NSString *str1 = [self.nameText.text stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSString *str1 = [self utf8ToUnicode:self.nameText.text];

    
    [LYNetwork POSTWithApiPath:resetNameUrl requestParams:@{
           @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",
           @"loginDTO":@{@"nickname":str1}
       } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {

        [self.view makeToast:@"昵称修改成功" duration:1 position:CSToastPositionCenter];
        

       }];
       
}
- (NSString *)URLEncodedString:(NSString *)string
{
    // CharactersToBeEscaped = @":/?&=;+!@#$()~',*";
    // CharactersToLeaveUnescaped = @"[].";

    NSString *unencodedString = string;
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)unencodedString,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));

    return encodedString;
}

- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
   
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
