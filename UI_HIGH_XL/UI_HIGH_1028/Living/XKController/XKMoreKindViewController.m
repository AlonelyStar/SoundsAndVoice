//
//  XKMoreKindViewController.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/10/30.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKMoreKindViewController.h"
#import "AreaListModel.h"
#import "XKRankingListCell.h"
#import "NetHandler.h"
#import "MJRefresh.h"
#import "UIColor+AddColor.h"
#import "XKFenleiTableView.h"
#import "XKRankingListModel.h"
#import "MoreKindTopView.h"
#import "AreaNameCell.h"
#import "FullAreaView.h"
#import "XKBoardCastViewController.h"

@interface XKMoreKindViewController ()<UICollectionViewDelegate,UITableViewDelegate>

@property (nonatomic,strong)MoreKindTopView *topScrollView;

@property (nonatomic,strong)FullAreaView *FullView;

@property (nonatomic,strong)XKFenleiTableView *tableView;

@property (nonatomic,strong)NSMutableArray *areaArray;
@property (nonatomic,strong)NSMutableArray *radioArray;

@property (nonatomic,strong)NSString *URL;

@property (nonatomic,assign)BOOL isAppear;
@end

@implementation XKMoreKindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView.backgroundColor = [UIColor huiseColor];
    self.isAppear = NO;
    self.titleLabel.text = self.titleString;
    self.topScrollView = [[MoreKindTopView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 40)];
    [self.backgroundView addSubview:self.topScrollView];
    
    self.topScrollView.collectionView.delegate = self;
    
    self.tableView = [[XKFenleiTableView alloc]initWithFrame:CGRectMake(0, 40, kScreenWidth, self.backgroundView.bounds.size.height - 40) style:(UITableViewStylePlain)];
    self.tableView.delegate  = self;
    self.tableView.backgroundColor = [UIColor huiseColor];
    [self.backgroundView addSubview:self.tableView];
    
    NSArray *array = [self.url componentsSeparatedByString:@","];
    self.URL = array[2];
    
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(appearCollection:)];
    
    [self.topScrollView.changeView addGestureRecognizer:gesture];

    self.FullView = [[FullAreaView alloc]initWithFrame:CGRectMake(kScreenWidth, 40, kScreenWidth,self.backgroundView.bounds.size.height - 40 )];
    [self.backgroundView addSubview:self.FullView];
    self.FullView.collectionView.delegate = self;
    
    
    [self handle];
    [self setupRefresh];
    
    
    
    
    // Do any additional setup after loading the view.
}


-(void)handle{
    self.areaArray = [NSMutableArray array];
    NSArray *array = [self.url componentsSeparatedByString:@","];
    if (array != nil) {
        [NetHandler getDataWithUrl:array[1] completion:^(NSData *data) {
            if (data != nil) {
                NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                NSArray *arr = [dic objectForKey:@"result"];
                for (NSDictionary *dicc in arr) {
                    AreaListModel *model = [[AreaListModel alloc]init];
                    [model setValuesForKeysWithDictionary:dicc];
                    [self.areaArray addObject:model];
                }
                self.topScrollView.areaArray = self.areaArray;
                self.FullView.areaArray  = self.areaArray;
                
            }
        }];
      
    }
}

-(void)handle2{
    self.radioArray = [NSMutableArray array];
    [NetHandler getDataWithUrl:self.URL completion:^(NSData *data) {
        if (data != nil) {
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *array = [dic objectForKey:@"result"];
            if (array.count != 0) {
                for (NSDictionary *dicc in array) {
                    XKRankingListModel *model = [[XKRankingListModel alloc]init];
                    [model setValuesForKeysWithDictionary:dicc];
                    [self.radioArray addObject:model];
                }
                
                self.tableView.kindsArray = self.radioArray;
                [self.tableView headerEndRefreshing];

            }else{
                
                for (NSDictionary *dicc in array) {
                    XKRankingListModel *model = [[XKRankingListModel alloc]init];
                    [model setValuesForKeysWithDictionary:dicc];
                    [self.radioArray addObject:model];
                }
                
                self.tableView.kindsArray = self.radioArray;
                [self.tableView headerEndRefreshing];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"该台暂时木有节目哦~" delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
                [alert show];
                
                [self performSelector:@selector(disppear:) withObject:alert afterDelay:0.8];
                
            }
            
        }
    }];
  
}

- (void)disppear:(UIAlertView *)alert{
    [alert dismissWithClickedButtonIndex:0 animated:YES];
    
}

- (void)setupRefresh{
    [self.tableView addHeaderWithTarget:self action:@selector(handle2)];
    [self.tableView headerBeginRefreshing];
}





-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    AreaNameCell *cell = (AreaNameCell *)[collectionView cellForItemAtIndexPath:indexPath];
    
    self.topScrollView.indexPath = indexPath;
    self.FullView.indexPath = indexPath;
    [self.FullView.collectionView reloadData];
    [self.topScrollView.collectionView reloadData];
    
    NSString *url = [NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v1/getRadiosListByType?device=iPhone&pageNum=1&pageSize=30&provinceCode=%ld&radioType=2",cell.model.provinceCode];
    
    self.URL = url;
    [self setupRefresh];
    
    [UIView animateWithDuration:0.5 animations:^{
        if (indexPath.item < 3) {
            self.topScrollView.collectionView.contentOffset = CGPointMake(0, 0);
        }else if (indexPath.item > self.areaArray.count - 4){
            self.topScrollView.collectionView.contentOffset = CGPointMake((self.areaArray.count - 5) * (kScreenWidth/6 + 10), 0);
        }else{
            self.topScrollView.collectionView.contentOffset = CGPointMake((indexPath.item - 2) * (kScreenWidth/6 + 10), 0);
        }
        
    }];
    
    if (self.isAppear == YES) {
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:(UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
            self.topScrollView.changeView.transform = CGAffineTransformMakeRotation(M_PI * 2);
        } completion:^(BOOL finished) {
            
        }];
        //进行collectionView 的收起
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.FullView.frame;
            frame.origin.x += kScreenWidth;
            self.FullView.frame = frame;
        }];
        
        self.isAppear = NO;
    }
    
    
    
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 1;
}


- (void)appearCollection:(UITapGestureRecognizer *)gesture{
    if (self.isAppear == NO) {
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:(UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
            self.topScrollView.changeView.transform = CGAffineTransformMakeRotation(M_PI);
        } completion:^(BOOL finished) {
            
        }];
        
        //进行collectionView的展现
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.FullView.frame;
            frame.origin.x -= kScreenWidth;
            self.FullView.frame = frame;
        }];
    
        
        self.isAppear = YES;
    }else{
        [UIView animateKeyframesWithDuration:0.5 delay:0 options:(UIViewKeyframeAnimationOptionAllowUserInteraction) animations:^{
            self.topScrollView.changeView.transform = CGAffineTransformMakeRotation(M_PI * 2);
        } completion:^(BOOL finished) {
            
        }];
        //进行collectionView 的收起
        
        [UIView animateWithDuration:0.2 animations:^{
            CGRect frame = self.FullView.frame;
            frame.origin.x += kScreenWidth;
            self.FullView.frame = frame;
        }];
        
        
        
        
        
        
        self.isAppear = NO;
        
    }
    
    
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
