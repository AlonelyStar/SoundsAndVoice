//
//  XKLivingViewController.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKLivingViewController.h"
#import "UIColor+AddColor.h"
#import "XKLivingSoundsTableView.h"
#import "NetHandler.h"
#import "UIScrollView+MJRefresh.h"
#import "XKRecommedModel.h"
#import "XKRankingListModel.h"
#import "XKMoreViewController.h"
#import "XKMoreKindViewController.h"
#import "RecommedSoundsCell.h"
#import "XKRankingListCell.h"
#import "RadioPlayerURLModel.h"
#import "XKBoardCastViewController.h"

@interface XKLivingViewController ()<UICollectionViewDelegate,UITableViewDelegate>

@property (nonatomic,strong)XKLivingSoundsTableView *XKLivingTableView;

@property (nonatomic,strong)NSMutableArray *recommendArray;

@property (nonatomic,strong)NSMutableArray *topArray;

@property (nonatomic,strong)UITapGestureRecognizer *tapGesture;

@end

@implementation XKLivingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;
    self.topView.backgroundColor = [UIColor huiseColor];
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    self.titleLabel.text = @"直播";
    
    self.XKLivingTableView = [[XKLivingSoundsTableView alloc]initWithFrame:CGRectMake(0, 0, self.backgroundView.bounds.size.width, self.backgroundView.bounds.size.height) style:(UITableViewStylePlain)];
    
    __weak __block typeof (self)WeakSelf = self;
    self.XKLivingTableView.block = ^(NSString *url){
        if (url != nil) {
        if ([url containsString:@"110000"]) {
            [WeakSelf turnMore1:url];
        }else{
            [WeakSelf turnMore:url];
        }
        }
    };
    
    self.XKLivingTableView.block1 = ^(XKRankingListModel *model){
        XKBoardCastViewController *boardVC = [[XKBoardCastViewController alloc]init];
        boardVC.rankingModel = model;
        [WeakSelf presentViewController:boardVC animated:YES completion:nil];
    };
    
    [self.backgroundView addSubview:self.XKLivingTableView];
    
    self.XKLivingTableView.delegate = self;
    
    
    [self setupRefresh];
    
    

    
    
    // Do any additional setup after loading the view.
}


- (void)turnMore:(NSString *)url{
    XKMoreViewController *moreVC =[[XKMoreViewController alloc]init];
    NSArray *arr = [url componentsSeparatedByString:@","];
    moreVC.titleString = arr[0];
    moreVC.url = url;
    [self.navigationController pushViewController:moreVC animated:YES];
    

}

- (void)turnMore1:(NSString *)url{
    XKMoreKindViewController *moreVC =[[XKMoreKindViewController alloc]init];
    NSArray *arr = [url componentsSeparatedByString:@","];
    moreVC.titleString = arr[0];
    moreVC.url = url;
    [self.navigationController pushViewController:moreVC animated:YES];
    
    
}





- (void)handle{
    self.recommendArray = [NSMutableArray array];
    self.topArray = [NSMutableArray array];
    
    [NetHandler getDataWithUrl:@"http://live.ximalaya.com/live-web/v1/getHomePageRadiosList?device=iPhone%20HTTP" completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSDictionary *dicc = [dic objectForKey:@"result"];
            NSArray *arr1 = [dicc objectForKey:@"recommandRadioList"];
            NSArray *arr2 = [dicc objectForKey:@"topRadioList"];
            for (NSDictionary *dic1 in arr1) {
                XKRankingListModel *model = [[XKRankingListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic1];
                [self.recommendArray addObject:model];
            }
            for (NSDictionary *dic2 in arr2) {
                XKRankingListModel *model = [[XKRankingListModel alloc]init];
                [model setValuesForKeysWithDictionary:dic2];
                [self.topArray addObject:model];
            }
            
            self.XKLivingTableView.recommedArray = self.recommendArray;
            
            self.XKLivingTableView.rankingArray = self.topArray;
            
            [self.XKLivingTableView reloadData];
            
            [self.XKLivingTableView headerEndRefreshing];
   
        }
        
        
    }];
    
}

- (void)setupRefresh{
    
    [self.XKLivingTableView addHeaderWithTarget:self action:@selector(handle)];
    
    [self.XKLivingTableView headerBeginRefreshing];
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 2) {
        XKBoardCastViewController *boardVC = [[XKBoardCastViewController alloc]init];
        boardVC.rankingModel = self.XKLivingTableView.rankingArray[indexPath.row];
        
        [self presentViewController:boardVC animated:YES completion:nil];
        
        
        
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//tableview 的delegate 方法

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0;
    }else if(section == 1)
    {
        return 10;
    }else{
        return 40;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.section) {
        case 0:
            return kScreenWidth/4- 12.5+ 50;
            break;
            
        case 1:
            return kScreenWidth/3 + 80;
            break;
            
        case 2:
            return kScreenWidth/5 + 30;
            break;
        default:
            break;
    }
    return 0;
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 0)];
        return view;
    }else if (section == 1){
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 10)];
        view.backgroundColor = [UIColor huiseColor];
        return view;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
        view.backgroundColor = [UIColor huiseColor];
        self.XKLivingTableView.moreView = [[UIView alloc]initWithFrame:CGRectMake(0, 10, kScreenWidth, 30)];
        self.XKLivingTableView.moreView.backgroundColor = [UIColor whiteColor];
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 20, 20)];
        image.image = [UIImage imageNamed:@"sanjiao"];
        
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(image.frame.origin.x + image.bounds.size.width + 5, 5, 100, 20)];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.text = @"排行榜";
        
        self.XKLivingTableView.moreButton.frame = CGRectMake(kScreenWidth - 50, 5, 40, 20);
        [self.XKLivingTableView.moreButton setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        [self.XKLivingTableView.moreButton setTitle:@"更多〉" forState:(UIControlStateNormal)];
        self.XKLivingTableView.moreButton.titleLabel.font = [UIFont systemFontOfSize:13];
        self.XKLivingTableView.moreButton.alpha = 0.5;
        self.XKLivingTableView.moreButton.tag = 1004;
   
        [self.XKLivingTableView.moreView addSubview:image];
        [self.XKLivingTableView.moreView addSubview:titleLabel];
        [self.XKLivingTableView.moreView addSubview:self.XKLivingTableView.moreButton];
        [view addSubview:self.XKLivingTableView.moreView];
        
        
        return view;
    }
    return nil;
    
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
