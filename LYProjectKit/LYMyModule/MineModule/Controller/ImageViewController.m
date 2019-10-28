//
//  ImageViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/27.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "ImageViewController.h"
#
@interface ImageViewController ()
@property (nonatomic,strong)UIScrollView *scView;
@property (nonatomic,strong)UIImageView *showImg;

@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"攻略";
    self.showImg = [[UIImageView alloc]init];
    __weak  typeof(self)weakSelf= self;
    [self.showImg sd_setImageWithURL:[NSURL URLWithString:self.urlString] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        UIImageView *imgView = [[UIImageView alloc]initWithImage:image];
        imgView.frame = CGRectMake(0, 0, width, width * image.size.height / image.size.width /image.scale);
        imgView.contentMode = UIViewContentModeScaleAspectFit;
        weakSelf.tableView.tableHeaderView = imgView;
    }];
//    [imageView sizeToFit];
    self.tableView.tableFooterView = [UIView new];
    

    



}

- (void)dealloc{
    
}
//#pragma mark - scorllView
//-(UIScrollView *)scView{
//    if (!_scView) {
//        //获取导航栏和状态栏的高度
//        CGFloat barHeight = [self barHeight];
//        _scView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, UPScrrenWidth, UPScreenHeight - barHeight)];
//        CGFloat imgH = [self imgContentHeight];
//        _scView.contentSize = CGSizeMake(0,imgH);//设置滚动视图的大小
////        _scView.pagingEnabled = YES;//设置是否可以进行画面切换  分块显示
//        _scView.bounces = NO;
//        _scView.showsHorizontalScrollIndicator = NO;//隐藏水平滚动条
//        _scView.showsVerticalScrollIndicator = NO;//
//        [self.view addSubview:_scView];
//    }
//    return _scView;
//}
//#pragma mark - 显示图片的ImgView
//-(UIImageView *)showImg{
//    if (!_showImg) {
//        CGFloat imgH = [self imgContentHeight];
//        _showImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,UPScrrenWidth , imgH)];
//        //设置imageView的背景图
//        [_showImg setImage:BundleImg(@"Listen/操作说明.jpg")];
//        //给imageView设置区域
//        _showImg.contentMode = UIViewContentModeScaleAspectFill;
//        //超出边界的剪切
////        [_showImg setClipsToBounds:YES];
//        //把视图添加到当前的滚动视图中
//        [self.scView addSubview:_showImg];
//    }
//    return _showImg;
//}
//#pragma mark - 内容的高度
//-(CGFloat)imgContentHeight{
//    //获取图片高度
//    UIImage *img = BundleImg(@"Listen/操作说明.jpg");
//    CGFloat imgHeight = img.size.height;
//    CGFloat imgWidth = img.size.width;
//    CGFloat imgH = imgHeight * (UPScrrenWidth / imgWidth);
//    return imgH;
//}
//#pragma mark - 获取导航栏和状态栏的高度
//-(CGFloat)barHeight{
//    //获取导航栏和状态栏的高度
//    CGRect statusBarFrame = [[UIApplication sharedApplication] statusBarFrame];
//    CGRect navBarFrame = self.navigationController.navigationBar.frame;
//    CGFloat barHeight = statusBarFrame.size.height + navBarFrame.size.height;
//    return barHeight;
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
