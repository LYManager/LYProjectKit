//
//  AcceptanceViewController.m
//  LYProjectKit
//
//  Created by 李帅 on 2019/10/19.
//  Copyright © 2019 赵良育. All rights reserved.
//

#import "AcceptanceViewController.h"
#import "AcceptanceTableViewCell.h"
#import "AcceptanceDetailViewController.h"
@interface AcceptanceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableview;

@end
static NSString * const kAGCCellIdentifier = @"AcceptanceTableViewCell";

@implementation AcceptanceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configTableView];
    
    self.navigationItem.title = @"承兑商";
   
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void) configTableView{
    self.tableview.rowHeight = 108;
    [self.tableview registerNib:[UINib nibWithNibName:kAGCCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kAGCCellIdentifier];
    
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    AcceptanceTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kAGCCellIdentifier forIndexPath:indexPath];
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
    
    NSLog(@"%ld",indexPath.row);
    if (indexPath.section == 0) {
        AcceptanceDetailViewController *accdetailVC = [[AcceptanceDetailViewController alloc]init];
        [self.navigationController pushViewController:accdetailVC animated:YES];
    }
    
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
