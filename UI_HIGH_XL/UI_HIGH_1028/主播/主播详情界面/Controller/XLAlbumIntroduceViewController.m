//
//  XLAlbumIntroduceViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/31.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAlbumIntroduceViewController.h"
#import "XLDetailTop.h"
#import "UIColor+AddColor.h"
#import "UIImageView+WebCache.h"
@interface XLAlbumIntroduceViewController ()

@property (nonatomic,strong) UILabel *nicknameLabel;
@property (nonatomic,strong) UILabel *personalSignatureLabel;
@property (nonatomic,strong) UIImageView *iconImageView;

@end

@implementation XLAlbumIntroduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.view.backgroundColor = [UIColor silverColor];
    
    CGFloat iconX = 40;
    CGFloat iconY = 60;
    CGFloat iconWidth = [UIScreen mainScreen].bounds.size.width - 2 * iconX;
    CGFloat iconHeight = iconWidth;
    self.iconImageView = [[UIImageView alloc] initWithFrame:(CGRectMake(iconX, iconY, iconWidth, iconHeight))];
    [self.view addSubview:self.iconImageView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(iconX - 10, iconY + iconHeight + 20, 40, 20))];
    nameLabel.text = @"昵称";
    [self.view addSubview:nameLabel];
    
    self.nicknameLabel = [[UILabel alloc] initWithFrame:(CGRectMake(nameLabel.frame.origin.x + nameLabel.bounds.size.width + 10, nameLabel.frame.origin.y, iconWidth - 20, 20))];
    [self.view addSubview:self.nicknameLabel];
    
    UILabel *desLabel = [[UILabel alloc] initWithFrame:(CGRectMake( iconX - 10, nameLabel.frame.origin.y + nameLabel.bounds.size.height + 20, 40, 20))];
    desLabel.text = @"简介";
    [self.view addSubview:desLabel];
    
    self.personalSignatureLabel = [[UILabel alloc] initWithFrame:(CGRectMake(desLabel.frame.origin.x + desLabel.bounds.size.width + 10, desLabel.frame.origin.y, iconWidth - 20, iconHeight / 2))];
    self.personalSignatureLabel.numberOfLines = 0;
    [self.view addSubview:self.personalSignatureLabel];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:self.albumIntroduce.mobileLargeLogo] placeholderImage:nil];
    
    self.nicknameLabel.text = self.albumIntroduce.nickname;
    
    self.personalSignatureLabel.text = self.albumIntroduce.personalSignature;
    [self.personalSignatureLabel sizeToFit];
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
