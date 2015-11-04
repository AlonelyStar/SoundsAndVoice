//
//  BaseViewController.m
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "BaseViewController.h"
#import "PicsLikeControl.h"
#import "MusicTool.h"
#import "UIImage+CZ.h"
#import "MusicViewController.h"
#import "UIColor+AddColor.h"

@interface BaseViewController () <PicsLikeControlDelegate>

@property (nonatomic,assign) CGFloat picCWidth;
@property (nonatomic,assign) CGFloat picCX;
@property (nonatomic,assign) BOOL isChanged;
@property (nonatomic,strong) NSString *url;

@end

@implementation BaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"beijing8"]];
    
    self.topView = [[UIView alloc]initWithFrame:(CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64))];
    self.topView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"top"]];
    
    [self.view addSubview:self.topView];
    
    self.button = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.button.frame = CGRectMake(10, 30, 25, 25);
    [self.button setBackgroundImage:[UIImage imageNamed:@"back_nomal"] forState:(UIControlStateNormal)];
    [self.button addTarget:self action:@selector(back:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.button];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeImage:) name:@"音乐头像" object:nil];
    
    if ([MusicTool sharedMusicTool].isPlaying == NO) {
        self.image0 = [UIImage imageNamed:@"music88"];
    } else {
        self.image0 = [UIImage circleImageWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[MusicTool sharedMusicTool].coverSmallUrl]]] borderWidth:1 borderColor:[UIColor whiteColor]];
    }
    self.image1 = [UIImage imageNamed:@"main-library-button"];
    [self changePicControlWithImage0:self.image0];

    
    self.titleLabel = [[UILabel alloc]initWithFrame:(CGRectMake(self.view.bounds.size.width / 4, 30, self.view.bounds.size.width / 2, 25))];
    self.titleLabel.font = [UIFont systemFontOfSize:18];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.titleLabel];
    
    self.backgroundView = [[UIView alloc]initWithFrame:(CGRectMake(0, self.topView.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height - self.topView.bounds.size.height))];
    self.backgroundView.backgroundColor = [UIColor silverColor];
    [self.view addSubview:self.backgroundView];
    
    self.backgroundView.backgroundColor = [UIColor clearColor];
    
    self.picControl.delegate = self;
    
    
    
}
#pragma mark - 通知接收
- (void)changeImage:(NSString *)Dic{
    
    if ([MusicTool sharedMusicTool].isPlaying) {
        
        self.url = [Dic valueForKey:@"object"];
        self.image0 = [UIImage circleImageWithImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.url]]] borderWidth:1 borderColor:[UIColor whiteColor]];
        [MusicTool sharedMusicTool].coverSmallUrl = self.url;
        [self changePicControlWithImage0:self.image0];
    }
}
#pragma mark - 改变picControl
- (void)changePicControlWithImage0:(UIImage *)image0{
    
    [self.picControl removeFromSuperview];

    self.picCWidth = 44;
    self.picCX = self.view.frame.size.width / 2 - self.picCWidth / 2;
    NSArray *images = @[self.image1,image0];
    //
    self.picControl = [[PicsLikeControl alloc] initWithFrame:CGRectMake(self.picCX, self.view.frame.size.height - self.picCWidth - 10, self.picCWidth, self.picCWidth) multiImages:images];
    self.picControl.delegate = self;
    
    [self.view addSubview:self.picControl];

}


#pragma mark - 翻转动画
- (void)animationFlip {

    // 标记翻转状态
    self.isChanged = !self.isChanged;
    
    [UIView beginAnimations:@"doflip" context:nil];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:
     UIViewAnimationTransitionFlipFromLeft  forView:self.picControl cache:YES];

    [UIView commitAnimations];
        // 动画进行到一半，设置图片
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 / 2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^
                       {
                           UIImage *image0 = self.isChanged ? [UIImage imageNamed:@"1"] : self.image0;
                           [self changePicControlWithImage0:image0];
                           self.isChanged ? [[MusicTool sharedMusicTool] pause]:[[MusicTool sharedMusicTool] play];
                       });
    
}

- (void)controlTappedAtIndex:(int)index {
  
    if (index == 0) {

        [self animationFlip];
        if ([MusicTool sharedMusicTool].isPlaying) {
        }
    }
    if (index == 1) {

        [self.navigationController popToRootViewControllerAnimated:YES];
    }
   
}

- (void)makeRotateAnimal {
    [UIView animateWithDuration:1.0 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.picControl.transform = CGAffineTransformRotate(self.picControl.transform, M_PI_2);
    } completion:^(BOOL finished) {
        [self makeRotateAnimal];
    }];
    
}


- (void)back:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
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
