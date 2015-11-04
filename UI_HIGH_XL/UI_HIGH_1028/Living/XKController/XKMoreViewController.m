//
//  XKMoreViewController.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKMoreViewController.h"
#import "NetHandler.h"
#import "MJRefresh.h"
#import "UIColor+AddColor.h"
#import "XKRankingListModel.h"
#import "XKRankingListCell.h"
#import "XKFenleiTableView.h"
#import "XKBoardCastViewController.h"

@interface XKMoreViewController ()<UITableViewDelegate>

@property (nonatomic,strong)NSMutableArray *Livingarray;

@property (nonatomic,strong)XKFenleiTableView *tableView;


@end

@implementation XKMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = self.titleString;
    self.topView.backgroundColor = [UIColor huiseColor];
    
    self.tableView = [[XKFenleiTableView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, self.backgroundView.bounds.size.height) style:(UITableViewStylePlain)];
    self.tableView.delegate = self;
    self.tableView.backgroundColor = [UIColor silverColor];

    [self.backgroundView addSubview:self.tableView];
    
    [self setupRefresh];
    
    
    // Do any additional setup after loading the view.
}

- (void)setupRefresh{
    [self.tableView addHeaderWithTarget:self action:@selector(handle)];
    
    [self.tableView headerBeginRefreshing];
}

- (void)handle{
    self.Livingarray = [NSMutableArray array];
    NSArray *array = [self.url componentsSeparatedByString:@","];
    if (array.count == 3) {
        [self.tableView addFooterWithTarget:self action:@selector(FooterBeginRefreshing)];
    }
    
    [NetHandler getDataWithUrl:array[1] completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = [dic objectForKey:@"result"];
            for (NSDictionary *dicc in arr) {
                XKRankingListModel *model = [[XKRankingListModel alloc]init];
                [model setValuesForKeysWithDictionary:dicc];
                [self.Livingarray addObject:model];
            }
            self.tableView.kindsArray = self.Livingarray;
            [self.tableView headerEndRefreshing];
        }
        
        
    }];
  
}

- (void)FooterBeginRefreshing{
    NSArray *array = [self.url componentsSeparatedByString:@","];
    [NetHandler getDataWithUrl:array[2] completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = [dic objectForKey:@"result"];
            for (NSDictionary *dicc in arr) {
                XKRankingListModel *model = [[XKRankingListModel alloc]init];
                [model setValuesForKeysWithDictionary:dicc];
                [self.Livingarray addObject:model];
            }
            self.tableView.kindsArray = self.Livingarray;
            [self.tableView footerEndRefreshing];
            [self.tableView removeFooter];
        }
        
        
    }];
    
    
}






-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.tableView.kindsArray !=nil) {
        XKBoardCastViewController *boardVC = [[XKBoardCastViewController alloc]init];
        boardVC.rankingModel = self.tableView.kindsArray[indexPath.row];
        [self presentViewController:boardVC animated:YES completion:nil];
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
