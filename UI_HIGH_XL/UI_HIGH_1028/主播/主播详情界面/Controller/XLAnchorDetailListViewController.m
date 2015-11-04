//
//  XLAnchorDetailListViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAnchorDetailListViewController.h"
#import "XLAnchorDetailTopCell.h"
#import "XLAlbumCell.h"
#import "XLVoiceCell.h"
#import "XLMoerAlbumCell.h"
#import "XLHeaderView.h"
#import "XLLookAllAlbumViewController.h"
#import "XLAlbumDetailViewController.h"
#import "NetHandler.h"
#import "XLDetailTop.h" // 头部Model
#import "XLPublishAlbum.h" // 发布的专辑Model
#import "XLPublishVoice.h" // 发布的声音Model
#import "XLAttentionViewController.h"
#import "XLAlbumIntroduceViewController.h"

#import "MusicViewController.h"

@interface XLAnchorDetailListViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) XLDetailTop *detailTop;
@property (nonatomic,strong) NSMutableArray *albumListArr;
@property (nonatomic,strong) NSMutableArray *voiceListArr;

@property (nonatomic,strong) NSString *albumNumber;
@property (nonatomic,strong) NSString *voiceNumber;

@end

@implementation XLAnchorDetailListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = YES;
    self.tableView = [[UITableView alloc] initWithFrame:(CGRectMake(0, -220, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height + 220)) style:(UITableViewStylePlain)];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view bringSubviewToFront:self.button];
    
    [self netHandleTop];
    [self netHandleAlbum];
    [self netHandleVoice];
    
    [self.view bringSubviewToFront:(UIView *)self.picControl];
}

#pragma mark - top网络解析
- (void)netHandleTop {
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/homePage?toUid=%ld&device=android",self.uid];

    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.detailTop = [[XLDetailTop alloc] init];
        [self.detailTop setValuesForKeysWithDictionary:rootDic];
        [self.tableView reloadData];
    }];
}
#pragma mark - 发布的专辑网络解析
- (void)netHandleAlbum {
    self.albumListArr = [NSMutableArray array];
     NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/album/%ld/1/2?device=android",self.uid];
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.albumNumber = [rootDic[@"totalCount"] stringValue];
        for (NSDictionary *dic in rootDic[@"list"]) {
            XLPublishAlbum *publishAlbum = [[XLPublishAlbum alloc] init];
            [publishAlbum setValuesForKeysWithDictionary:dic];
            
            [self.albumListArr addObject:publishAlbum];
        }
        [self.tableView reloadData];
    }];
}

#pragma mark - 发布的声音网络解析
- (void)netHandleVoice {
    self.voiceListArr = [NSMutableArray array];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://mobile.ximalaya.com/mobile/others/ca/track/%ld/1/30?device=android",self.uid];
    [NetHandler getDataWithUrl:urlStr completion:^(NSData *data) {
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        self.voiceNumber = [rootDic[@"totalCount"] stringValue];
        for (NSDictionary *dic in rootDic[@"list"]) {
            XLPublishVoice *publishVoice = [[XLPublishVoice alloc] init];
            [publishVoice setValuesForKeysWithDictionary:dic];
            [self.voiceListArr addObject:publishVoice];
        }
        [self.tableView reloadData];
    }];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }
    if (section == 1) {
        return self.albumListArr.count + 1;
    }
    if (section == 2) {
        return self.voiceListArr.count;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return 400 + 100;
    }
    if (indexPath.section == 1) {
        if (indexPath.row == self.albumListArr.count) {
            return 30;
        } else {
            return 90;
        }
    }
    if (indexPath.section == 2) {
        return 90;
    }
    return 0;
}

#pragma mark - 设置区头
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [[UIView alloc] initWithFrame:CGRectZero];
    }
    if (section == 1) {
        XLHeaderView *headerView = [[XLHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        headerView.titleLabel.text = @"发布的专辑";
        headerView.countLabel.text = [NSString stringWithFormat:@"(%@)",self.albumNumber];
        return headerView;
    }
    if (section == 2) {
        
        XLHeaderView *headerView = [[XLHeaderView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 20)];
        headerView.titleLabel.text = @"发布的声音";
        headerView.countLabel.text = [NSString stringWithFormat:@"(%@)",self.voiceNumber];
        return headerView;
    }
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"  ";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        XLAnchorDetailTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"topCell"];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XLAnchorDetailTopCell" owner:nil options:nil] lastObject];
        }
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCirCleImgV:)];
        [cell.circleImageV addGestureRecognizer:tap];
        [cell.attentionBtn addTarget:self action:@selector(threeTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.funsBtn addTarget:self action:@selector(threeTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
        [cell.praiseBtn addTarget:self action:@selector(threeTopButton:) forControlEvents:(UIControlEventTouchUpInside)];
        cell.detailTop = self.detailTop;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
    }
    if (indexPath.section == 1) {
        if (indexPath.row == self.albumListArr.count) {
            XLMoerAlbumCell *moreCell = [tableView dequeueReusableCellWithIdentifier:@"moreCell"];
            if (moreCell == nil) {
                moreCell = [[XLMoerAlbumCell alloc] initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:@"moreCell"];
            }
            [moreCell.moreAlbumBtn addTarget:self action:@selector(turnToMoreAlbumVC:) forControlEvents:(UIControlEventTouchUpInside)];
            return moreCell;
        } else {
            static NSString *identifier1 = @"albumCell";
            XLAlbumCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
            if (cell == nil) {
                cell = [[[NSBundle mainBundle] loadNibNamed:@"XLAlbumCell" owner:nil options:nil] lastObject];
            }
            if (self.albumListArr.count != 0) {
                cell.pulishAlbum = self.albumListArr[indexPath.row];
            }
            return cell;
        }
        
    }
    if (indexPath.section == 2) {
        
        static NSString *identifier2 = @"voiceCell";
        XLVoiceCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        if (cell == nil) {
            cell = [[[NSBundle mainBundle] loadNibNamed:@"XLVoiceCell" owner:nil options:nil] lastObject];
        }
        if (self.voiceListArr.count != 0) {
            cell.pulishVoice = self.voiceListArr[indexPath.row];
        }
        return cell;
    }
    
    return 0;
}


#pragma mark - tableView点击cell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        XLAlbumDetailViewController *albumDVC = [[XLAlbumDetailViewController alloc] init];
        albumDVC.uid = self.uid;
        XLPublishAlbum *album = self.albumListArr[indexPath.row];
        albumDVC.albumId = album.albumId;
    
        [self.navigationController pushViewController:albumDVC animated:YES];
    }
    if (indexPath.section == 2) { // 点击播放
        MusicViewController *musicVC = [[MusicViewController alloc] init];
        musicVC.tracksArray = self.voiceListArr;
        musicVC.currentIndex = indexPath.row;
        [self presentViewController:musicVC animated:YES completion:nil];
    }
}

#pragma mark - 点击头像
- (void)tapCirCleImgV:(UITapGestureRecognizer *)tap {

    XLAlbumIntroduceViewController *albumVC = [[XLAlbumIntroduceViewController alloc] init];
    albumVC.albumIntroduce = self.detailTop;
    [self.navigationController pushViewController:albumVC animated:YES];
    
}

#pragma mark - 查看全部(更多)专辑
- (void)turnToMoreAlbumVC:(UIButton *)button {
    XLLookAllAlbumViewController *lookAllAlbumVC = [[XLLookAllAlbumViewController alloc] init];
    lookAllAlbumVC.uid = self.uid;
    [self.navigationController pushViewController:lookAllAlbumVC animated:YES];
}

#pragma mark - 关注_粉丝_赞过的人点击事件
- (void)threeTopButton:(UIButton *)button {
    NSInteger typeTag = button.tag - 2000;
    XLAttentionViewController *attentionVC = [[XLAttentionViewController alloc] init];
    attentionVC.uid = self.uid;
    if (typeTag == 0) {
        attentionVC.type = @"following";
    } else if (typeTag == 1) {
        attentionVC.type = @"follower";
    } else {
        attentionVC.type = @"favorite";
    }
    [self.navigationController pushViewController:attentionVC animated:YES];
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
