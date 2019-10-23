//
//  InvitFriendViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/22.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "InvitFriendViewController.h"
#define RGB(R, G, B, A)\
[UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:A]
#define kCellbackColor [UIColor colorWithRed:6/255.0 green:19/255.0 blue:51/255.0 alpha:0.48] // cell背景色
#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
@interface InvitFriendViewController ()

@property (nonatomic,strong)UIImageView *backImage;
@property (nonatomic,strong)UIImageView *codeImage;
@property (nonatomic,strong)UIImageView *headImage;
@property (nonatomic,strong)UILabel *nameLab;
@property (nonatomic,strong)UILabel *invitLab;

@property (nonatomic,strong)UIButton *onBtn;
@property (nonatomic,strong)UIButton *nextBtn;
@end

@implementation InvitFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.backImage];
    [self.backImage addSubview:self.codeImage];
    [self.backImage addSubview:self.headImage];
    [self.backImage addSubview:self.nameLab];
    [self.backImage addSubview:self.invitLab];


    self.title = @"邀请推广";
    [self loadRequest];
    self.nameLab.text = self.nameStr;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.iconStr]];
    
    
    UIBarButtonItem *rigButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(exitBtnAction)];
    [rigButton setTintColor:[UIColor whiteColor]];
    [rigButton setImage:[UIImage imageNamed:@"fenxiang"]];
    
    self.navigationItem.rightBarButtonItem = rigButton;
}
- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
    [LYNetwork POSTWithApiPath:inviteUrl requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@""
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
        self.invitLab.text = [NSString stringWithFormat:@"%@%@",@"推广码:",[[response objectForKey:@"data"] objectForKey:@"inviteCode"]];
        
        self.codeImage.image=[self createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:[[response objectForKey:@"data"] objectForKey:@"inviteCodeUrl"]] withSize:150];
       
    }];
    
}

-(void)exitBtnAction
{
    
  
    UIGraphicsBeginImageContext(self.backImage.bounds.size);     //currentView 当前的view  创建一个基于绘图的图形上下文并指定大小为当前视图的bounds
    self.backImage.opaque = NO;
    [self.backImage.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
    UIImageWriteToSavedPhotosAlbum(viewImage, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    
}
- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = @"成功";
    if (!error) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存成功" preferredStyle:UIAlertControllerStyleAlert];
        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }];
        
//        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"保存失败，请开启相册权限" preferredStyle:UIAlertControllerStyleAlert];
        
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }];
        
//        [alertController addAction:cancelAction];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    NSLog(@"message is %@",message);
}
- (CIImage *)creatQRcodeWithUrlstring:(NSString *)urlString{
    
    // 1.实例化二维码滤镜
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 2.恢复滤镜的默认属性 (因为滤镜有可能保存上一次的属性)
    [filter setDefaults];
    // 3.将字符串转换成NSdata
    NSData *data  = [urlString dataUsingEncoding:NSUTF8StringEncoding];
    // 4.通过KVO设置滤镜, 传入data, 将来滤镜就知道要通过传入的数据生成二维码
    [filter setValue:data forKey:@"inputMessage"];
    // 5.生成二维码
    CIImage *outputImage = [filter outputImage];
    return outputImage;
}
- (UIImage *)createNonInterpolatedUIImageFormCIImage:(CIImage *)image withSize:(CGFloat) size
{
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent), size/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}




-(UIImageView *)backImage
{
    if (_backImage == nil) {
        _backImage = [[UIImageView alloc] initWithFrame:CGRectMake(40, 20, kScreenW-80, kScreenH-170)];
        _backImage.image = [UIImage imageNamed:@"1.jpg"];
    }
    return _backImage;
}
-(UIImageView *)codeImage
{
    if (_codeImage == nil) {
        _codeImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-100-100, kScreenH-80-340, 80, 80)];
        _codeImage.image = [UIImage imageNamed:@"code.jpg"];
        
    }
    return _codeImage;
}
-(UIImageView *)headImage
{
    if (_headImage == nil) {
        _headImage = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-50-100, kScreenH-320, 30, 30)];
        _headImage.image = [UIImage imageNamed:@"code.jpg"];
        _headImage.layer.cornerRadius = 15;
    }
    return _headImage;
}
-(UILabel *)nameLab
{
    if (_nameLab == nil) {
        //描述
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-150-100, kScreenH-280, 130, 13)];
        _nameLab.font = [UIFont systemFontOfSize:12.0f];
        _nameLab.textColor = RGB(255, 255, 255,1.0);
        _nameLab.textAlignment = NSTextAlignmentRight;
//        _nameLab.backgroundColor = [UIColor redColor];
    }
    return _nameLab;
}

-(UILabel *)invitLab
{
    if (_invitLab == nil) {
        //描述
        _invitLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-150-100, kScreenH-280+23, 130, 13)];
        _invitLab.font = [UIFont systemFontOfSize:12.0f];
        _invitLab.textColor = RGB(255, 255, 255,1.0);
        _invitLab.textAlignment = NSTextAlignmentRight;
//        _invitLab.backgroundColor = [UIColor redColor];
    }
    return _invitLab;
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
