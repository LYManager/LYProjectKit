//
//  MyBillViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 Sunshie. All rights reserved.
//

#import "MyBillViewController.h"
#import "MyBillableViewCell.h"
#import "SWOAuthCodeView.h"
#define ScreenScale6    (SCREEN_WIDTH/iPhone6ScreenWidth)

@interface MyBillViewController ()<UITableViewDelegate,UITableViewDataSource,SWOAuthCodeViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)SWOAuthCodeView *codeView;

@end
static NSString * const kAGCCellIdentifier = @"MyBillableViewCell";

@implementation MyBillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    
    self.navigationItem.title = @"我的账单";
   
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void) configTableView{
    self.tableView.rowHeight = 54;
    [self.tableView registerNib:[UINib nibWithNibName:kAGCCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kAGCCellIdentifier];
    self.tableView.backgroundColor = [UIColor colorWithRed:14/255.0 green:16/255.0 blue:24/255.0 alpha:1.0];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyBillableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAGCCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *view= [[UIView alloc]init];
//    view.backgroundColor = [UIColor colorWithRed:14/255.0 green:16/255.0 blue:24/255.0 alpha:1.0];
//    return view;
//}
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //创建view时，需要指定验证码的长度
    SWOAuthCodeView *oacView = [[SWOAuthCodeView alloc] initWithMaxLength:6];
    [self.view addSubview:oacView];
    /* -----设置可选的属性 start----- */
    oacView.delegate = self; //设置代理
    oacView.boxNormalBorderColor = [UIColor blueColor]; //方框的边框正常状态时的边框颜色
    oacView.boxHighlightBorderColor = [UIColor redColor]; //方框的边框输入状态时的边框颜色
    oacView.boxBorderWidth = 2; //方框的边框宽度
    oacView.boxCornerRadius = 6; //方框的圆角半径
    oacView.boxBGColor = [UIColor whiteColor];  //方框的背景色
    oacView.boxTextColor = [UIColor blackColor]; //方框内文字的颜色
    /* -----设置可选的属性 end----- */
    //显示键盘，可以输入验证码了
    [oacView beginEdit];

    //可选步骤：Masonry布局/设置frame
    [oacView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oacView.superview).offset(15);
        make.right.equalTo(oacView.superview).offset(-15);
        make.top.equalTo(oacView.superview).offset(150);
        make.height.mas_equalTo(44);
    }];
  
    
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
