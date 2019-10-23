//
//  InvitationViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/18.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "InvitationViewController.h"

@interface InvitationViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *invitImage;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UILabel *codeLab;
@property (weak, nonatomic) IBOutlet UIImageView *backImage;

@end

@implementation InvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.title = @"邀请推广";
    [self loadRequest];
    self.nameLab.text = self.nameStr;
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:self.iconStr]];
    self.headImage.layer.cornerRadius = 24;
    self.headImage.layer.masksToBounds = YES;

    
    
    UIBarButtonItem *rigButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(exitBtnAction)];
    [rigButton setTintColor:[UIColor whiteColor]];
    [rigButton setImage:[UIImage imageNamed:@"fenxiang"]];

    
    self.navigationItem.rightBarButtonItem = rigButton;
//    NSString *imagePath=[[NSBundle mainBundle]pathForResource:@"invitback" ofType:@"jpg"];
//
//
//    self.backImage.image= [self DrawText:self.nameStr forImage:[UIImage imageWithContentsOfFile:imagePath]];
//    self.backImage.image = [self DrawText2:@"12312" forImage:self.backImage.image];
//
//
//    self.backImage.image = [self DrawText3:@"123123" forImage:self.backImage.image];
    
    
    
    
    
    
    
}
- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
    [LYNetwork POSTWithApiPath:inviteUrl requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@""
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
        self.codeLab.text = [NSString stringWithFormat:@"%@%@",@"推广码",[[response objectForKey:@"data"] objectForKey:@"inviteCode"]];
        
        self.invitImage.image=[self createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:[[response objectForKey:@"data"] objectForKey:@"inviteCodeUrl"]] withSize:150];
       
    }];
    
}
- (IBAction)nextAction:(id)sender {
}
- (IBAction)topAction:(id)sender {
}



-(void)exitBtnAction
{
//    UIImageWriteToSavedPhotosAlbum(self.backImage.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
    
    
       UIGraphicsBeginImageContext(self.view.bounds.size);     //currentView 当前的view  创建一个基于绘图的图形上下文并指定大小为当前视图的bounds
    self.view.opaque = NO;
         [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
         UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
         UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文
         UIImageWriteToSavedPhotosAlbum(viewImage, nil, nil, nil);//然后将该图片保存到图片图
   
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



-(UIImage *)addText:(UIImage *)image text:(NSString *)string
{
    //上下文的大小
    int w = image.size.width;
    int h = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
    //创建上下文
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, kCGImageAlphaPremultipliedFirst);
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), image.CGImage);//将img绘至context上下文中
    CGContextSetRGBFillColor(context, 0.0, 1.0, 1.0, 1);//设置颜色
    char* text = (char *)[string cStringUsingEncoding:NSUTF8StringEncoding];
    CGContextSelectFont(context, "Helvetica", 80, kCGEncodingMacRoman);//设置字体的大小
    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
    CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
    CGContextShowTextAtPoint(context, 940, 2166, text, strlen(text));//设置字体绘制的位置
    //Create image ref from the context
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
}

-(UIImage *)DrawText:(NSString *)text forImage:(UIImage *)image{
    
    CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context,kCGPathStroke);
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:70.f], NSForegroundColorAttributeName:[UIColor blackColor]};
    
    //计算出文字的宽度 设置控件限制的最大size为图片的size
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    // 画文字 让文字处于居中模式
    [text drawAtPoint:CGPointMake(950,1250) withAttributes:attributes];
    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
-(UIImage *)DrawText2:(NSString *)text forImage:(UIImage *)image{
    
    CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
    
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    
    [image drawAtPoint:CGPointMake(0,0)];
    
    // 获得一个位图图形上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextDrawPath(context,kCGPathStroke);
    
    NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:70.f], NSForegroundColorAttributeName:[UIColor blackColor]};
    
    //计算出文字的宽度 设置控件限制的最大size为图片的size
    CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    // 画文字 让文字处于居中模式
    [text drawAtPoint:CGPointMake(870,1720) withAttributes:attributes];
    // 返回绘制的新图形
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
     -(UIImage *)DrawText3:(NSString *)text forImage:(UIImage *)image{
         
         CGSize size = CGSizeMake(image.size.width,image.size.height ); // 画布大小
         
         UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
         
         [image drawAtPoint:CGPointMake(0,0)];
         
         // 获得一个位图图形上下文
         CGContextRef context = UIGraphicsGetCurrentContext();
         
         CGContextDrawPath(context,kCGPathStroke);
         
         NSDictionary *attributes = @{ NSFontAttributeName:[UIFont systemFontOfSize:70.f], NSForegroundColorAttributeName:[UIColor blackColor]};
         
         //计算出文字的宽度 设置控件限制的最大size为图片的size
         CGSize textSize = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
         
         // 画文字 让文字处于居中模式
         [text drawAtPoint:CGPointMake(1480,2740) withAttributes:attributes];
         // 返回绘制的新图形
         UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
         
         UIGraphicsEndImageContext();
         
         return newImage;
         
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
