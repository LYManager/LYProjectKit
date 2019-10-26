//
//  NodeArchitectureViewController.m
//  ProjectFramework
//
//  Created by 中链 on 2018/10/8.
//  Copyright © 2018年 李帅. All rights reserved.
//

#import "NodeArchitectureViewController.h"

#import "ImageTableViewCell.h"
#import "TextTableViewCell.h"

#import "TeamModel.h"

#define kScreenW [[UIScreen mainScreen] bounds].size.width
#define kScreenH [[UIScreen mainScreen] bounds].size.height
#define RGB(R, G, B, A)\
[UIColor colorWithRed:(R) / 255.0 green:(G) / 255.0 blue:(B) / 255.0 alpha:A]
#define kCellbackColor [UIColor colorWithRed:6/255.0 green:19/255.0 blue:51/255.0 alpha:0.48] // cell背景色

@interface NodeArchitectureViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL status[10]; //记录每个单元格的状态   默认no闭合
}
@property (nonatomic,strong)UIView *headView;  /*头部背景*/
@property (nonatomic,strong)UIImageView *headBackLineView;  /*上部阴影*///放置图片效果更好
@property (nonatomic,strong)UILabel *attributionLab;  /*归属节点*/
@property (nonatomic,strong)UILabel *attributionShowLab;  /*归属节点展示*/
@property (nonatomic,strong)UILabel *allAttributionLab;  /*总结点数*/
@property (nonatomic,strong)UILabel *allAttributionShowLab;  /*总节点展示*/

@property (nonatomic,strong)UITableView *baseTbleView;   /*列表tab*/
@property (nonatomic,strong)TeamModel *model;

@end

@implementation NodeArchitectureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   // [self setHeadUI];
    [self.view addSubview:self.baseTbleView];
//    self.baseTbleView.tableHeaderView = self.headView;
    self.view.backgroundColor = [UIColor colorWithRed:16/255.0 green:18/255.0 blue:27/255.0 alpha:1.0];
    self.title = @"我的团队";
    [self loadRequest];
    
}
- (void)loadRequest{
    
    NSLog(@"用户id ===  %@",[LYUserInfoManager shareInstance].userInfo.userId);
    
    [LYNetwork POSTWithApiPath:teamURL requestParams:@{
        @"userId":[LYUserInfoManager shareInstance].userInfo.userId ?:@""
    } handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        self.model = [TeamModel modelWithDictionary:response[@"data"]];
        [self.baseTbleView reloadData];
    }];
    
}
-(UITableView *)baseTbleView
{
    if (_baseTbleView== nil) {
        
        self.baseTbleView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,kScreenW,kScreenH) style:UITableViewStylePlain];
        self.baseTbleView.backgroundColor = RGB(6, 19, 51,0.24);
        self.baseTbleView.dataSource = self;
        self.baseTbleView.delegate = self;
        [self.baseTbleView registerClass:[TextTableViewCell class] forCellReuseIdentifier:@"finCell"];
        [self.baseTbleView registerClass:[ImageTableViewCell class] forCellReuseIdentifier:@"imageCell"];

        //self.baseTbleView.separatorStyle = NO;
        self.baseTbleView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return  _baseTbleView;
}
#pragma mark - Table view data source
//组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
//组中行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    BOOL closeAge = status[section];
    //关闭显示为0行
    if (closeAge == NO) {
        return 0;
    }
    if (section == 0) {
        return 1;
    }else if (section == 1)
    {
        return 0;
    }
    else if (section == 2)
    {
        return 0;
    }else if (section == 3)
    {
        return self.model.notActiveChilds.count +1;
    }else
    {
         return self.model.childsList.count +1;
    }
    
    
}
//cell内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * str = [NSString stringWithFormat:@"%ld%ldcell", (long)indexPath.row,(long)indexPath.section];
    if (indexPath.section==0) {
        ImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[ImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.ruleImage sd_setImageWithURL:[NSURL URLWithString:self.model.contCoinRule]];
        return cell;
    }
    else if (indexPath.section == 1)
    {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.codeLab.text = @"编号";
        cell.phoneLab.text = @"手机号";
        cell.idLab.text = @"ID";
        return cell;
    }
    else if (indexPath.section == 2)
    {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.codeLab.text = @"编号";
        cell.phoneLab.text = @"手机号";
        cell.idLab.text = @"ID";
        return cell;
    }
    else if (indexPath.section == 3)
    {
           TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
           if (cell == nil) {
               cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
           }
           tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
           cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.codeLab.text = @"编号";
            cell.phoneLab.text = @"手机号";
            cell.idLab.text = @"ID";
        }
        else
        {
          
            cell.codeLab.text = [NSString stringWithFormat:@"%ld",indexPath.row];
            cell.phoneLab.text = [self.model.notActiveChilds[indexPath.row-1]objectForKey:@"mobile"];
            cell.idLab.text = [NSString stringWithFormat:@"%@",[self.model.notActiveChilds[indexPath.row-1]objectForKey:@"userId"]];
        }
        return cell;
    }
    else
    {
        TextTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
        if (cell == nil) {
            cell = [[TextTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:str];
        }
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
       if (indexPath.row == 0) {
            cell.codeLab.text = @"编号";
            cell.phoneLab.text = @"手机号";
            cell.idLab.text = @"ID";
        }
        else
        {
            cell.codeLab.text = [NSString stringWithFormat:@"%ld",indexPath.row];
            cell.phoneLab.text = [self.model.childsList[indexPath.row-1]objectForKey:@"mobile"];
            cell.idLab.text = [NSString stringWithFormat:@"%@",[self.model.childsList[indexPath.row-1]objectForKey:@"userId"]];
        }
        return cell;
    }
}
//自定义section的header view
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    
    if (section == 0) {

        UIControl *titileView = [[UIControl alloc] initWithFrame:CGRectZero];
        titileView.backgroundColor = kCellbackColor;
        titileView.tag = section;
        //设置  头视图的标题什么的
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, kScreenW/2, 40)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.text = @"我的贡献值";
        [titleLable sizeToFit];
        
        [titileView addSubview:titleLable];
        UILabel *titleshowLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-174, 0,134, 40)];
        titleshowLable.backgroundColor = [UIColor clearColor];
        titleshowLable.textColor = [UIColor whiteColor];
        titleshowLable.font = [UIFont systemFontOfSize:14];
        titleshowLable.text = [NSString stringWithFormat:@"%ld",(long)self.model.contAmount];
        titleshowLable.textAlignment = NSTextAlignmentRight;
        [titileView addSubview:titleshowLable];

        UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-30, 17.5, 10, 5)];
        lastImageView.backgroundColor = [UIColor clearColor];
        lastImageView.image = [UIImage imageNamed:@"x"];
        [titileView addSubview:lastImageView];
        [titileView addTarget:self action:@selector(sectionAction:) forControlEvents:UIControlEventTouchUpInside];
        
        return titileView;
    }
    else if (section == 1)
    {
        UIControl *titileView = [[UIControl alloc] initWithFrame:CGRectZero];
         titileView.backgroundColor = kCellbackColor;
         titileView.tag = section;
         //设置  头视图的标题什么的
         UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, kScreenW/2, 40)];
         titleLable.backgroundColor = [UIColor clearColor];
         titleLable.textColor = [UIColor whiteColor];
         titleLable.font = [UIFont systemFontOfSize:14];
         titleLable.text = @"团队总人数";
         [titleLable sizeToFit];
         [titileView addSubview:titleLable];
         
         UILabel *titleshowLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-154, 0,134, 40)];
         titleshowLable.backgroundColor = [UIColor clearColor];
         titleshowLable.textColor = [UIColor whiteColor];
         titleshowLable.font = [UIFont systemFontOfSize:14];
        titleshowLable.text = [NSString stringWithFormat:@"%ld",(long)self.model.teamNums];
         titleshowLable.textAlignment = NSTextAlignmentRight;

        // [titleshowLable sizeToFit];
         
         [titileView addSubview:titleshowLable];
         
         
         [titileView addTarget:self action:@selector(section2Action:) forControlEvents:UIControlEventTouchUpInside];
         
         return titileView;
    }
    else if (section == 2)
    {
        UIControl *titileView = [[UIControl alloc] initWithFrame:CGRectZero];
         titileView.backgroundColor = kCellbackColor;
         titileView.tag = section;
         //设置  头视图的标题什么的
         UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, kScreenW/2, 40)];
         titleLable.backgroundColor = [UIColor clearColor];
         titleLable.textColor = [UIColor whiteColor];
         titleLable.font = [UIFont systemFontOfSize:14];
         titleLable.text = @"团队活跃度";
         [titleLable sizeToFit];
         [titileView addSubview:titleLable];
         
         UILabel *titleshowLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-154, 0,134, 40)];
         titleshowLable.backgroundColor = [UIColor clearColor];
         titleshowLable.textColor = [UIColor whiteColor];
         titleshowLable.font = [UIFont systemFontOfSize:14];
        titleshowLable.text = self.tameStr;
         titleshowLable.textAlignment = NSTextAlignmentRight;

        // [titleshowLable sizeToFit];
         
         [titileView addSubview:titleshowLable];
         
         
         [titileView addTarget:self action:@selector(section2Action:) forControlEvents:UIControlEventTouchUpInside];
         
         return titileView;
    }
    else if (section == 3)
    {
        UIControl *titileView = [[UIControl alloc] initWithFrame:CGRectZero];
               titileView.backgroundColor = kCellbackColor;
               titileView.tag = section;
               //设置  头视图的标题什么的
               UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, kScreenW/2, 40)];
               titleLable.backgroundColor = [UIColor clearColor];
               titleLable.textColor = [UIColor whiteColor];
               titleLable.font = [UIFont systemFontOfSize:14];
               titleLable.text = @"直推未加入会员";
               [titleLable sizeToFit];
               [titileView addSubview:titleLable];
               
               UILabel *titleshowLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-174, 0,134, 40)];
               titleshowLable.backgroundColor = [UIColor clearColor];
               titleshowLable.textColor = [UIColor whiteColor];
               titleshowLable.font = [UIFont systemFontOfSize:14];
        titleshowLable.text = [NSString stringWithFormat:@"%ld",(long)self.model.notActiveNums];
               titleshowLable.textAlignment = NSTextAlignmentRight;

              // [titleshowLable sizeToFit];
               
               [titileView addSubview:titleshowLable];
               
               UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-30, 17.5, 10, 5)];
               lastImageView.backgroundColor = [UIColor clearColor];
               lastImageView.image = [UIImage imageNamed:@"x"];
               [titileView addSubview:lastImageView];
               [titileView addTarget:self action:@selector(section4Action:) forControlEvents:UIControlEventTouchUpInside];
               
               return titileView;
    }
    else {

        UIControl *titileView = [[UIControl alloc] initWithFrame:CGRectZero];
        titileView.backgroundColor = kCellbackColor;
        titileView.tag = section;
        //设置  头视图的标题什么的
        UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectMake(14, 14, kScreenW/2, 40)];
        titleLable.backgroundColor = [UIColor clearColor];
        titleLable.textColor = [UIColor whiteColor];
        titleLable.font = [UIFont systemFontOfSize:14];
        titleLable.text = @"直推已加入会员";
        [titleLable sizeToFit];
        [titileView addSubview:titleLable];
        
        UILabel *titleshowLable = [[UILabel alloc] initWithFrame:CGRectMake(kScreenW-174, 0,134, 40)];
        titleshowLable.backgroundColor = [UIColor clearColor];
        titleshowLable.textColor = [UIColor whiteColor];
        titleshowLable.font = [UIFont systemFontOfSize:14];
        titleshowLable.text = [NSString stringWithFormat:@"%ld",(long)self.model.activedNums];
        titleshowLable.textAlignment = NSTextAlignmentRight;

       // [titleshowLable sizeToFit];
        
        [titileView addSubview:titleshowLable];
        
        UIImageView *lastImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenW-30, 17.5, 10, 5)];
        lastImageView.backgroundColor = [UIColor clearColor];
        lastImageView.image = [UIImage imageNamed:@"x"];
        [titileView addSubview:lastImageView];
        [titileView addTarget:self action:@selector(section5Action:) forControlEvents:UIControlEventTouchUpInside];
        
        return titileView;
    }
    
    
    
    
}
//点击section的header view的方法实现，保存当前section的闭合状态
- (void)sectionAction:(UIControl *)control{
    
    NSInteger section = 0;
    
    status[0] = !status[0];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.baseTbleView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade]; //刷新制定单元格
    
}
- (void)section2Action:(UIControl *)control{
    
    NSInteger section = 1;
    
    status[1] = !status[1];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.baseTbleView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade]; //刷新制定单元格
    
}
- (void)section4Action:(UIControl *)control{
    
    NSInteger section = 3;
    
    status[3] = !status[3];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.baseTbleView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade]; //刷新制定单元格
    
}
- (void)section5Action:(UIControl *)control{
    
    NSInteger section = 4;
    
    status[4] = !status[4];
    
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:section];
    [self.baseTbleView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade]; //刷新制定单元格
    
}
//section的header view的高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 40;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section ==0) {
        return 340;
    }
    else
    {
       return 48;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
