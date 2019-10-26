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

    
    
    self.codeImage.image = [self createNonInterpolatedUIImageFormCIImage:[self creatQRcodeWithUrlstring:self.assModel.userAddress] withSize:150];
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
