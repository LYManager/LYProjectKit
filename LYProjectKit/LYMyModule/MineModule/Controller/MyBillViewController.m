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
#import "BillModel.h"
#define ScreenScale6    (SCREEN_WIDTH/iPhone6ScreenWidth)

@interface MyBillViewController ()<UITableViewDelegate,UITableViewDataSource,SWOAuthCodeViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)SWOAuthCodeView *codeView;
@property (nonatomic,strong)NSMutableArray *dataArr;

@property (nonatomic,assign)NSInteger currage;


@end
static NSString * const kAGCCellIdentifier = @"MyBillableViewCell";

@implementation MyBillViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [NSMutableArray array];
    [self configTableView];
    
    self.navigationItem.title = @"我的账单";
    [self addRefresh];
    
    
    // Do any additional setup after loading the view from its nib.
}
- (void)addRefresh
{
    @weakify(self)
      self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
          [self loadRequest:NO];
      }];
      [self.tableView.mj_header beginRefreshing];
      self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
          [self loadRequest:YES];
      }];

}
- (void)loadRequest:(BOOL)more{
    
    if (!more) {
        [self.dataArr removeAllObjects];
    }
    if (more) {
        _currage++;
    }else{
        _currage =1;
    }
    [LYNetwork POSTWithApiPath:billURL requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@"",
        @"pageSize":@"10",
        @"pageNum":[NSString stringWithFormat:@"%ld",(long)self.currage]
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
        NSString *page = [NSString stringWithFormat:@"%@",[response[@"data"]objectForKey:@"pages"]];
        if (self.currage < [page integerValue]) {
            [self.tableView.mj_footer resetNoMoreData];
        }
        else
        {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        }
        NSArray *arr = [response[@"data"]objectForKey:@"pageList"];
        for (int i = 0; i<arr.count; i++) {
            BillModel *model = [BillModel modelWithDictionary:arr[i]];
            [self.dataArr addObject:model];
        }
        
        
        [self.tableView reloadData];
    }];
    
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
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    MyBillableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAGCCellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    BillModel *model = self.dataArr[indexPath.row];
    cell.nameLab.text = model.content;
    cell.timeLab.text = [self dateWithString:model.createDate];
    [tableView  setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    NSString *coinStr;
    if ([model.coinType isEqualToString:@"1"]) {
        coinStr = @"AGC";
    }
    if ([model.coinType isEqualToString:@"2"]) {
        coinStr = @"贡献值";
    }
    if ([model.coinType isEqualToString:@"3"]) {
        coinStr = @"USDT";
    }
    if ([model.coinType isEqualToString:@"4"]) {
        coinStr = @"活跃度";
    }
    cell.titShowLab.text = [NSString stringWithFormat:@"%@%@",model.coinAmount,coinStr];
    if ([cell.titShowLab.text containsString:@"-"]) {
        cell.titShowLab.textColor = RGB(0, 153, 84, 1.0);
    }
    else
    {
        cell.titShowLab.textColor = RGB(239, 22, 17, 1.0);
        cell.titShowLab.text = [NSString stringWithFormat:@"%@%@",@"+",model.coinAmount];

    }
    
    
    
    
    
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
//    //创建view时，需要指定验证码的长度
//    SWOAuthCodeView *oacView = [[SWOAuthCodeView alloc] initWithMaxLength:6];
//    [self.view addSubview:oacView];
//    /* -----设置可选的属性 start----- */
//    oacView.delegate = self; //设置代理
//    oacView.boxNormalBorderColor = [UIColor blueColor]; //方框的边框正常状态时的边框颜色
//    oacView.boxHighlightBorderColor = [UIColor redColor]; //方框的边框输入状态时的边框颜色
//    oacView.boxBorderWidth = 2; //方框的边框宽度
//    oacView.boxCornerRadius = 6; //方框的圆角半径
//    oacView.boxBGColor = [UIColor whiteColor];  //方框的背景色
//    oacView.boxTextColor = [UIColor blackColor]; //方框内文字的颜色
//    /* -----设置可选的属性 end----- */
//    //显示键盘，可以输入验证码了
//    [oacView beginEdit];
//
//    //可选步骤：Masonry布局/设置frame
//    [oacView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(oacView.superview).offset(15);
//        make.right.equalTo(oacView.superview).offset(-15);
//        make.top.equalTo(oacView.superview).offset(150);
//        make.height.mas_equalTo(44);
//    }];
//  
    
}

- (void)headerRefreshFinish
{
    
};
- (void)footerRefreshFinish
{
    
}
;


//将时间戳转换为时间字符串
-(NSString*)dateWithString:(NSString*)str

{

    NSTimeInterval time = [str doubleValue]/1000;;

    /** [[NSDate date] timeIntervalSince1970]*1000;*/

    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:time];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];//实例化一个NSDateFormatter对象

    [dateFormatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];//设定时间格式,这里可以设置成自己需要的格式

    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];

    return currentDateStr;

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
