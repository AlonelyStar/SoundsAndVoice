//
//  IntroductionViewController.m
//  Music
//
//  Created by zhupeng on 15/10/30.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "IntroductionViewController.h"
#import "TagsCollectionViewCell.h"
#import "SoundAlbumViewController.h"

@interface IntroductionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UILabel *introTitleLabel;
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) NSArray *albumArr;

@end

@implementation IntroductionViewController

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.albumArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TagsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell20" forIndexPath:indexPath];
//    self.albumArr = [self.albumDetail.tags componentsSeparatedByString:@","];
    cell.titleLabel.text = self.albumArr[indexPath.item];
    cell.titleLabel.textColor = [UIColor grayColor];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SoundAlbumViewController *soundAlbumVC = [[SoundAlbumViewController alloc]init];
    soundAlbumVC.albumSting = self.albumArr[indexPath.item];
    [self.navigationController pushViewController:soundAlbumVC animated:YES];
    
    NSLog(@"选择");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.backgroundView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel.text = @"简介";
    
    self.label = [[UILabel alloc]initWithFrame:(CGRectMake(20, 40, 60, 30))];
    self.label.text = @"标签:";
    self.label.textColor = [UIColor grayColor];
    [self.backgroundView addSubview:self.label];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
//    flowLayout.minimumLineSpacing = 2;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.itemSize = CGSizeMake(self.backgroundView.bounds.size.width / 7, 30);
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:(CGRectMake(self.label.frame.origin.x + self.label.bounds.size.width, self.label.frame.origin.y, self.backgroundView.bounds.size.width - self.label.frame.origin.x - self.label.bounds.size.width - 20, 100)) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[TagsCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell20"];
    [self.backgroundView addSubview:self.collectionView];
    
    self.introTitleLabel = [[UILabel alloc]initWithFrame:(CGRectMake(20, 150, 60, 30))];
    self.introTitleLabel.text = @"简介:";
    self.introTitleLabel.textColor = [UIColor grayColor];
    [self.backgroundView addSubview:self.introTitleLabel];
    
    self.introLabel = [[UILabel alloc]initWithFrame:(CGRectMake(20, 190, self.backgroundView.bounds.size.width - 40, 30))];
    self.introLabel.numberOfLines = 0;
    self.introLabel.text = self.albumDetail.intro;
    [self.introLabel sizeToFit];
    [self.backgroundView addSubview:self.introLabel];
    
    self.albumArr = [self.albumDetail.tags componentsSeparatedByString:@","];

    
    // Do any additional setup after loading the view.
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
