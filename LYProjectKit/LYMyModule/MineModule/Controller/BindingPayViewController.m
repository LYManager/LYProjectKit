//
//  BindingPayViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/11/6.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "BindingPayViewController.h"
#import <AVFoundation/AVFoundation.h>//相机调用

@interface BindingPayViewController ()<UIImagePickerControllerDelegate,UIActionSheetDelegate,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *accountLab;
@property (weak, nonatomic) IBOutlet UILabel *nikeLab;
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *nikeText;
@property (weak, nonatomic) IBOutlet UIImageView *payIMage;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;
@property (weak, nonatomic) IBOutlet UILabel *uploadLab;

@property (nonatomic, strong) NSData * imageData;


@end

@implementation BindingPayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([self.myStr isEqualToString:@"1"]) {
        self.title = @"绑定支付宝";
        self.accountLab.text = @"支付宝账户";
        self.nikeLab.text = @"支付宝昵称";
        self.accountText.placeholder = @"请输入支付宝收款账号";
        self.nikeText.placeholder = @"请输入支付宝昵称";
        self.uploadLab.text = @"上传支付宝收款码";

    }
    else
    {
        self.title = @"绑定微信";
        self.accountLab.text = @"微信账户";
        self.nikeLab.text = @"微信昵称";
        self.accountText.placeholder = @"请输入微信收款账号";
        self.nikeText.placeholder = @"请输入微信昵称";
        self.uploadLab.text = @"上传微信收款码";
    }
    [self.submitBtn ly_gradint];

    self.accountText.attributedPlaceholder = [self.accountText.placeholder ly_attributePlaceholder];
    self.nikeText.attributedPlaceholder = [self.nikeText.placeholder ly_attributePlaceholder];

  
    self.payIMage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture= [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction)];
    [self.payIMage addGestureRecognizer:tapGesture];
    self.navigationController.delegate = self;




}
-(void)tapAction
{
    [self creatActionSheet];
}
#pragma mark 创建底部弹框
-(void)creatActionSheet {
    /*
     先创建UIAlertController，preferredStyle：选择UIAlertControllerStyleActionSheet，这个就是相当于创建8.0版本之前的UIActionSheet；
     
     typedef NS_ENUM(NSInteger, UIAlertControllerStyle) {
     UIAlertControllerStyleActionSheet = 0,
     UIAlertControllerStyleAlert
     } NS_ENUM_AVAILABLE_IOS(8_0);
     */
    UIAlertController *actionSheet = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    /*
     typedef NS_ENUM(NSInteger, UIAlertActionStyle) {
     UIAlertActionStyleDefault = 0,
     UIAlertActionStyleCancel,         取消按钮
     UIAlertActionStyleDestructive     破坏性按钮，比如：“删除”，字体颜色是红色的
     } NS_ENUM_AVAILABLE_IOS(8_0);
     
     */
    // 创建action，这里action1只是方便编写，以后再编程的过程中还是以命名规范为主
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //相机
        NSString *mediaType = AVMediaTypeVideo;
        AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
        if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"无法使用相机" message:@"请在iPhone的\"设置-隐私-相机\"中允许访问相机" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            return;
        }
        
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePickerController animated:YES completion:^{
          
            
        }];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"从相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
      
        //相册
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc]init];
        imagePickerController.delegate = self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePickerController animated:YES completion:^{
            
            
        }];
    }];
   
    UIAlertAction *action4 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        NSLog(@"取消");
    }];
    [action1 setValue:RGB(10, 31, 55, 1) forKey:@"titleTextColor"];
    [action2 setValue:RGB(10, 31, 55, 1) forKey:@"titleTextColor"];
    [action4 setValue:RGB(4, 197, 252, 1) forKey:@"titleTextColor"];
    //把action添加到actionSheet里
    [actionSheet addAction:action1];
    [actionSheet addAction:action2];
    [actionSheet addAction:action4];
    
    //相当于之前的[actionSheet show];
    self.modalPresentationStyle = UIModalPresentationFullScreen;
    actionSheet.modalPresentationStyle= UIModalPresentationOverFullScreen;
    [self presentViewController:actionSheet animated:YES completion:nil];
}
#pragma mark - 调用uiactionsheet iOS7使用
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    NSInteger soureType = 0;
    //是否支持相机，模拟器没有相机
    switch (buttonIndex) {
        case 1://相册
            soureType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        default:
            break;
    }
    if (buttonIndex == 1) {
        soureType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    }
    //跳转到相机或相册页面
    UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
    imagePick.delegate = self;
    imagePick.allowsEditing = YES;
    imagePick.sourceType = soureType;
    [self presentViewController:imagePick animated:YES completion:nil];
}

#pragma mark - iOS7 iOS8 都要调用方法，拉取取消按钮调用该方法
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 保存图片到沙盒中
-(void)saveImage:(UIImage *)currentImage withName:(NSString *)imageName{
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 1); //返回的数据大小(1~0.0)
    //获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:imageName];
    
    //将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark -  压缩图片
- (UIImage *)imageWithImageSimple:(UIImage*)image scaledToSize:(CGSize)newSize{
    // Create a graphics image context
    UIGraphicsBeginImageContext(newSize);
    // Tell the old image to draw in this new context, with the desired
    // new size
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    // Get the new image from the context
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    // End the context
    UIGraphicsEndImageContext();
    // Return the new image.
    return newImage;
}

#pragma mark  裁剪图片
- (UIImage *)cutImage:(UIImage*)image withSize:(CGSize)size
{
    //压缩图片
    CGSize newSize;
    CGImageRef imageRef = nil;
    
    if ((image.size.width / image.size.height) < (size.width / size.height)) {
        newSize.width = image.size.width;
        newSize.height = image.size.width * size.height / size.width;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(0, fabs(image.size.height - newSize.height) / 2, newSize.width, newSize.height));
        
    } else {
        newSize.height = image.size.height;
        newSize.width = image.size.height * size.width /size.height;
        
        imageRef = CGImageCreateWithImageInRect([image CGImage], CGRectMake(fabs(image.size.width - newSize.width) / 2, 0, newSize.width, newSize.height));
        
    }
    return [UIImage imageWithCGImage:imageRef];
}

#pragma mark - iOS7 iOS8 都要调用方法，选择完成调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //保存图片到本地，上传图片到服务器需要使用
    [self saveImage:[self imageWithImageSimple:image scaledToSize:CGSizeMake(70, 70)] withName:@"avatar.jpeg"];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]stringByAppendingPathComponent:@"avatar.jpeg"];
    
    //存储路径
    NSLog(@"!!!!!!!!!!!!!!!!!!!!!!!!!!存储路径%@", fullPath);
    UIImage *saveImage = [[UIImage alloc]initWithContentsOfFile:fullPath];
    
    //1 //UIImage转换为NSData
    self.imageData = UIImageJPEGRepresentation(saveImage, 0.5);
//    NSString *imageStr = [self.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    self.payIMage.image = image;
    
    
 
    
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)submitAction:(id)sender {
    if ([self.myStr isEqualToString:@"1"]) {
        if (self.accountText.text.length == 0) {
            [self.view makeToast:@"请填写支付宝收款账户" duration:1 position:CSToastPositionCenter];
            return;
        }
        if (self.nikeText.text.length == 0) {
            [self.view makeToast:@"请填写支付宝昵称" duration:1 position:CSToastPositionCenter];
            return;
        }
        if (self.imageData == nil) {
            [self.view makeToast:@"请上传支付宝收款码" duration:1 position:CSToastPositionCenter];
            return;
        }
        //上传
         
         [LYNetwork POSTWithApiPath:bindAliURL requestParams:@{
             @"alipay":[self utf8ToUnicode:self.accountText.text],
             @"nickName":[self utf8ToUnicode:self.nikeText.text],
             @"imageData":self.imageData
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
             [self.view makeToast:@"绑定成功" duration:1 position:CSToastPositionCenter];
             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                 [self.navigationController popViewControllerAnimated:YES];

             });
         }];
        
        
        
    }
    else
    {
        if (self.accountText.text.length == 0) {
            [self.view makeToast:@"请填写微信收款账户" duration:1 position:CSToastPositionCenter];
            return;
        }
        if (self.nikeText.text.length == 0) {
            [self.view makeToast:@"请填写微信昵称" duration:1 position:CSToastPositionCenter];
            return;
        }
        if (self.imageData == nil) {
            [self.view makeToast:@"请上传微信收款码" duration:1 position:CSToastPositionCenter];
            return;
        }
        [LYNetwork POSTWithApiPath:bindWeiatURL requestParams:@{
             @"weichat":[self utf8ToUnicode:self.accountText.text],
             @"nickName":[self utf8ToUnicode:self.nikeText.text],
             @"imageData":self.imageData
         } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        
            [self.view makeToast:@"绑定成功" duration:1 position:CSToastPositionCenter];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];

            });
             
         }];
    }
    
    
    
    
    
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
