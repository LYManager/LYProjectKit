// LYWorkPresenter.m 
// LYProjectKit 
// 
// Created by 赵良育 on 2019/11/14. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYWorkPresenter.h"
#import "LYWorkHeaderView.h"
#import "LYServiceTableViewCell.h"
#import "LYWarningMessageCell.h"
@interface LYWorkPresenter ()<UITableViewDelegate,UITableViewDataSource,LYServiceTableViewCellDelegate>
/**< tableView*/
@property(nonatomic,strong)UITableView * tableView;
/**< target*/
@property(nonatomic,weak)UIViewController * targetVC;
/**< 更多*/
@property(nonatomic,strong)UIButton * moreBtn;
@end

@implementation LYWorkPresenter
- (void)bindVC:(UIViewController *)vc{
    _targetVC = vc;
    [self configUI];
}

- (void)loadRequest{
    // TODO: 数据请求，展示数据
}

#pragma mark🐒------  点击事件------🐒
// headerView
// 合作伙伴
- (void)friendBtnAction{
    NSLog(@"合作伙伴");
}
// 新建订单
- (void)createOrderBtnAction{
    NSLog(@"新建订单");
}
// 业务动态 更多
-(void) headerViewMoreBtnAction{
    NSLog(@"业务动态 更多");
}
// 业务功能
- (void)clickItemIndex:(NSInteger)index{
    NSLog(@"业务功能 ---- %ld",index);
}
// 预警信息更多
- (void) warningMessageMroeBtnAction{
     NSLog(@"预警信息更多");
}
// 预警信息 cell的点击
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"预警信息 cell  -- %ld",indexPath.row);
}


#pragma mark🐒------table-delegate-datasource------🐒
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1 : 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        LYServiceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LYServiceTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
        [cell configData];
        return cell;
    }else{
        LYWarningMessageCell * cell = [tableView dequeueReusableCellWithIdentifier:@"LYWarningMessageCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        [self didSelectRowAtIndexPath:indexPath];
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 30)];
    label.font = [UIFont boldSystemFontOfSize:14];
    label.textColor = [UIColor blackColor];
    label.text = section == 0 ? @"业务功能" : @"预警信息";
    if (section == 1) {
        [view addSubview:self.moreBtn];
        [self.moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_equalTo(0);
            make.right.mas_equalTo(-10);
            make.width.mas_equalTo(40);
        }];
    }
    [view addSubview:label];
    view.backgroundColor = [UIColor whiteColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (section == 0) {
        UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
        UIImageView * footerImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
        footerImageView.image = [UIImage imageNamed:@"认证卡"];
        [view addSubview:footerImageView];
        [footerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsMake(10, 10, 10, 10));
        }];
        return view;
    }else{
        return nil;
    }
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return section == 0 ? 80 : 0;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.f;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return  LYServiceTableViewCell.serviceCellHeight;
    }else{
        return 40;
    }
}

- (void) configUI{
    [self.targetVC.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    LYWorkHeaderView * headerView = [[LYWorkHeaderView alloc]init];
    headerView.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, LYWorkHeaderView.headerViewHeight);
    self.tableView.tableHeaderView = headerView;
    [headerView.friendBtn addTarget:self action:@selector(friendBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView.creagteNewOrderBtn addTarget:self action:@selector(createOrderBtnAction) forControlEvents:UIControlEventTouchUpInside];
    [headerView.messageView.moreBtn addTarget:self action:@selector(headerViewMoreBtnAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[LYServiceTableViewCell class] forCellReuseIdentifier:@"LYServiceTableViewCell"];
    [self.tableView registerClass:[LYWarningMessageCell class] forCellReuseIdentifier:@"LYWarningMessageCell"];
    
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [UIView new];
//    self.tableView.backgroundColor = [UIColor whiteColor];
}

#pragma mark🐒------lazy------🐒
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIButton *)moreBtn{
    if (!_moreBtn) {
        _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _moreBtn.titleLabel.font = [UIFont systemFontOfSize:13];
        [_moreBtn setTitle:@"更多" forState:UIControlStateNormal];
        [_moreBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_moreBtn addTarget:self action:@selector(warningMessageMroeBtnAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreBtn;
}
@end
