// LYMayiGongHuiViewController.m 
// LYProjectKit 
// 
// Created by Sunshie on 2019/10/19. 
// Copyright © 2019 Sunshie. All rights reserved. 
// 

#import "LYMayiGongHuiViewController.h"
#import "LYMayiGongHuiHeaderView.h"
#import "LYMayiGongHuiFooterView.h"

#import "LYAntGonghuiData.h"

@interface LYMayiGongHuiViewController ()<LYMayiGongHuiHeaderViewDelegate,UITableViewDelegate,UITableViewDataSource,LYMayiGongHuiFooterViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**< headerView*/
@property(nonatomic,strong)LYMayiGongHuiHeaderView * headerView;
/**< footer*/
@property(nonatomic,strong)LYMayiGongHuiFooterView * footerView;
/**< 数据*/
@property(nonatomic,strong)LYAntGonghuiData * data;
@end

@implementation LYMayiGongHuiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"蚂蚁工会";
    [self configTableView];
    
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 50, 40);
    [button setTitle:@"记录" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:13];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:button];
    [self loadRequest];
    // Do any additional setup after loading the view from its nib.
}

- (void)loadRequest{
    [LYNetwork POSTWithApiPath:antGonghuiURL requestParams:@{} handler:^(NSDictionary * _Nullable response, NSError * _Nullable error) {
        self.data = [LYAntGonghuiData modelWithDictionary:response];
        [self configDataWithModel:self.data.data];
    }];
}

- (void) recordAction{
    [self pushViewControllerWithClassName:@"LYGonghuiRecordViewController" params:nil];
}



- (void) configDataWithModel:(LYAntGonghuiDataModel *)model{
    self.headerView.hidden = NO;
    self.footerView.hidden = NO;
    [self.headerView configDataWithModel:model];
    [self.footerView configDataWithModel:model];
}
- (void)headerContackKefu{
    [self pushViewControllerWithClassName:@"ContactCustomerViewController" params:nil];
}
- (void)contactKefu{
    [self pushViewControllerWithClassName:@"ContactCustomerViewController" params:nil];
}

- (void) configTableView {
    [self configTableViewHeaderFooterView];
//    [self.tableView registerNib:[UINib nibWithNibName:kMineTableViewCellIdentifier bundle:NSBundle.mainBundle] forCellReuseIdentifier:kMineTableViewCellIdentifier];
}
- (void) configTableViewHeaderFooterView{
     LYMayiGongHuiHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"LYMayiGongHuiHeaderView" owner:self options:nil][0];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat width = UIScreen.mainScreen.bounds.size.width - 30;
        headerView.frame = CGRectMake(0, 0, width, width * 471  / 402);
        self.tableView.tableHeaderView = headerView;
    });
    self.headerView = headerView;
    self.headerView.hidden = YES;
    headerView.delegate = self;
    
    
    LYMayiGongHuiFooterView * footerView = [[NSBundle mainBundle]loadNibNamed:@"LYMayiGongHuiFooterView" owner:self options:nil][0];
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat width = UIScreen.mainScreen.bounds.size.width;
        footerView.frame = CGRectMake(0, 0, width, width * 808  / 397);
        self.tableView.tableHeaderView = headerView;
    });
    self.footerView = footerView;
    self.footerView.hidden = YES;
    self.footerView.delegate =self;
    self.tableView.tableFooterView = footerView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   
    return nil;
}

#pragma mark🐒------LYMayiGongHuiHeaderViewDelegate------🐒
- (void)useCardWithType:(CardType)cardType{
    if (cardType == CardType_RealCard) {
        LYAntCardModel * model = self.data.data.propsCardList.firstObject;
        if (model.cardId != 1) {
            model = self.data.data.propsCardList.lastObject;
        }
        if (model.cardCount > 0) {
//            去实名认证
            [self pushViewControllerWithClassName:@"LYRealNameAuthViewController" params:@{
                @"realNameCardModel":model
            }];
        }else{
//            联系客服弹框
             [self popErrorControllerIsSend:NO isRealNameCard:YES];
        }
    }else{
        LYAntCardModel * model = self.data.data.propsCardList.firstObject;
        if (model.cardId != 2) {
            model = self.data.data.propsCardList.lastObject;
        }
        if (model.cardCount > 0) {
            [self popToolsController:model callBack:nil];
        }else{
        //  联系客服弹框
              [self popErrorControllerIsSend:NO isRealNameCard:NO];
        }
         
    }
}

- (void)sendCaardWithType:(CardType)cardType{
    if (cardType == CardType_RealCard) {
        LYAntCardModel * model = self.data.data.propsCardList.firstObject;
        if (model.cardId != 1) {
            model = self.data.data.propsCardList.lastObject;
        }
        if (model.cardCount > 0) {
            [self popSendToolsController:model backBlock:^{
                [self loadRequest];
            }];
        }else{
        //  联系客服弹框
             [self popErrorControllerIsSend:YES isRealNameCard:YES];
        }
    }else{
        LYAntCardModel * model = self.data.data.propsCardList.firstObject;
        if (model.cardId != 2) {
            model = self.data.data.propsCardList.lastObject;
        }
        if (model.cardCount > 0) {
            [self popSendToolsController:model backBlock:^{
                [self loadRequest];
            }];
        }else{
        //  联系客服弹框
             [self popErrorControllerIsSend:YES isRealNameCard:NO];
        }
    }
}

//- (LYAntCardModel *)_getCardModelWithCardId:(NSInteger)cardId{
//    for (LYAntCardModel * model in self.data.data.propsCardList) {
//        if (model.cardId == cardId) {
//            return model;
//        }
//    }
//    return nil;
//}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
//    [self.headerView configUI];
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
