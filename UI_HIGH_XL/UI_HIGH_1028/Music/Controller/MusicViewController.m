//
//  MusicViewController.m
//  Music
//
//  Created by zhupeng on 15/10/31.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicViewController.h"
#import "TitleScrollView.h"
#import "MusicTool.h"
#import "TracksList.h"
#import "UIImageView+WebCache.h"
#import "NSString+CZ.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIColor+AddColor.h"

@interface MusicViewController ()

@property (nonatomic, strong) TitleScrollView *titleScrollView;


@property (nonatomic, strong) UIImageView *topImageView;
@property (nonatomic, strong) UIImageView *topMaskView;

@property (nonatomic, strong) UIImageView *smallImageView;
@property (nonatomic, strong) UIImageView *midImageView;
@property (nonatomic, strong) UIImageView *midImageView2;

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *playCounts;

@property (nonatomic, strong) UISlider *slider; // 播放进度
@property (nonatomic, strong) UISlider *sliderVoice; // 声音


@property (nonatomic, strong) UIButton *preButton;
@property (nonatomic, strong) UIButton *playButton;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) TracksList *tracksList;

@property (nonatomic, strong) UILabel *totalLabel;
@property (nonatomic, strong) UILabel *currentLabel;

@property (nonatomic, strong) CADisplayLink *link;

@property (nonatomic,assign) BOOL isTap;
@property (nonatomic,assign) BOOL hasVoice;

@property (nonatomic,strong) UIButton *voiceButton;

@end

@implementation MusicViewController
- (void)dealloc {
    [self.titleScrollView.timer invalidate];
    self.titleScrollView.timer = nil;
    [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (CADisplayLink *)link {
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(update)];
    }
    return _link;
}
#pragma mark-- 更新进度条
- (void)update {
    if ([MusicTool sharedMusicTool].isPlaying && self.tracksArray.count != 0) {
        self.slider.value = [MusicTool sharedMusicTool].player.currentItem.currentTime.value / [MusicTool sharedMusicTool].player.currentItem.currentTime.timescale;
        self.currentLabel.text = [NSString getMinuteSecondWithSecond:self.slider.value];
        CGFloat angle = M_PI_4 / 60;
        self.smallImageView.transform = CGAffineTransformRotate(self.smallImageView.transform, angle);
    }
    if (self.slider.value >= ((TracksList *)self.tracksArray[self.currentIndex]).duration) {
        [self nextAction:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor silverColor];
    

    self.voiceButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.voiceButton.frame = (CGRectMake(30, self.view.bounds.size.height / 7, 10, 10));
    [self.voiceButton setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"iconfont-shengyin"]]];
    [self.view addSubview:self.voiceButton];
  
    
    self.sliderVoice = [[UISlider alloc]initWithFrame:(CGRectMake(50,self.voiceButton.frame.origin.y - 10, self.view.bounds.size.width - 90, 30))];
    //设置slider的属性
    [self.sliderVoice setThumbImage:[UIImage imageNamed:@"baiyuanquan"] forState:(UIControlStateNormal)];
    [self.sliderVoice addTarget:self action:@selector(sliderVoiceAction:) forControlEvents:(UIControlEventValueChanged)];
    self.sliderVoice.minimumValue = 0;
    self.sliderVoice.maximumValue = 3;
    self.sliderVoice.value = 1.5;
    self.sliderVoice.minimumTrackTintColor = [UIColor whiteColor];
    self.sliderVoice.maximumTrackTintColor = [UIColor silverColor];
    [self.view addSubview:self.sliderVoice];
    
    self.tracksList = self.tracksArray[self.currentIndex];
    
    self.topImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height * 3 / 4 + 5))];
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:self.tracksList.coverLarge]];
    [self.view addSubview:self.topImageView];
    
    self.topMaskView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    self.topMaskView.image = [UIImage imageNamed:@"MaskPic.jpg"];
    self.topMaskView.alpha = 0.9;
    [self.view addSubview:self.topMaskView];
    
    self.topMaskView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.topMaskView addGestureRecognizer:tap2];
    
    self.midImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(self.topImageView.bounds.size.width / 5.5, self.topImageView.bounds.size.height / 4, self.topImageView.bounds.size.width * 3 / 5, self.topImageView.bounds.size.width * 3 / 5))];
    self.midImageView.layer.cornerRadius = self.midImageView.bounds.size.width / 2;
    self.midImageView.layer.masksToBounds = YES;
    self.midImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.midImageView addGestureRecognizer:tap];
    self.midImageView.image = [UIImage imageNamed:@"changpian"];
    [self.view addSubview:self.midImageView];
    
    self.midImageView2 = [[UIImageView alloc]initWithFrame:(CGRectMake(40, 40, self.midImageView.bounds.size.width - 80, self.midImageView.bounds.size.height - 80))];
    self.midImageView2.layer.cornerRadius = self.midImageView2.bounds.size.width / 2;
    self.midImageView2.layer.masksToBounds = YES;
    self.midImageView2.userInteractionEnabled = YES;
    [self.midImageView2 sd_setImageWithURL:[NSURL URLWithString:self.tracksList.coverMiddle]];
    [self.midImageView addSubview:self.midImageView2];
    
    UIButton *collectButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    collectButton.frame = CGRectMake(self.view.bounds.size.width / 5, self.view.bounds.size.height * 3 / 5, self.view.bounds.size.width / 6, self.view.bounds.size.width / 6);
    [collectButton setBackgroundImage:[UIImage imageNamed:@"iconfont-unie64c"] forState:(UIControlStateNormal)];
    [collectButton addTarget:self action:@selector(collectionAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:collectButton];
    
    UILabel *collectLabel = [[UILabel alloc]initWithFrame:(CGRectMake(collectButton.frame.origin.x, collectButton.frame.origin.y + collectButton.bounds.size.height, collectButton.bounds.size.width, 20))];
    collectLabel.text = @"collect";
    collectLabel.font = [UIFont fontWithName:@"Zapfino" size:18];
    [collectLabel sizeToFit];
    collectLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:collectLabel];
    
    UIButton *shareButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    shareButton.frame = CGRectMake(self.view.bounds.size.width * 3 / 5, self.view.bounds.size.height * 3 / 5, self.view.bounds.size.width / 6, self.view.bounds.size.width / 6);
    [shareButton setBackgroundImage:[UIImage imageNamed:@"iconfont-32pxxinlang"] forState:(UIControlStateNormal)];
    [shareButton addTarget:self action:@selector(shareAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:shareButton];
    
    UILabel *shareLabel = [[UILabel alloc]initWithFrame:(CGRectMake(shareButton.frame.origin.x, shareButton.frame.origin.y + shareButton.bounds.size.height, shareButton.bounds.size.width, 20))];
    shareLabel.text = @"share";
    shareLabel.font = [UIFont fontWithName:@"Zapfino" size:18];
    [shareLabel sizeToFit];
    shareLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:shareLabel];

    self.slider = [[UISlider alloc]initWithFrame:(CGRectMake(40, self.view.bounds.size.height * 3 / 4 + 5, self.view.bounds.size.width - 80, 20))];
    //设置slider的属性
    self.slider.minimumTrackTintColor = [UIColor redColor];
    [self.slider setThumbImage:[UIImage imageNamed:@"iconfont-yuandian"]forState:(UIControlStateNormal)];
    
    [self.slider addTarget:self action:@selector(sliderAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.slider addTarget:self action:@selector(sliderStopAction:) forControlEvents:(UIControlEventTouchDown)];
    [self.slider addTarget:self action:@selector(sliderReplayAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.slider addTarget:self action:@selector(sliderReplayAction:) forControlEvents:(UIControlEventTouchUpOutside)];
    self.slider.maximumValue = self.tracksList.duration;
    [self.view addSubview:self.slider];
    
    
    self.preButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.preButton.frame = CGRectMake(self.view.bounds.size.width / 6, self.slider.frame.origin.y + 30, self.view.bounds.size.width / 10, self.view.bounds.size.width / 10);
    [self.preButton setBackgroundImage:[UIImage imageNamed:@"iconfont-shangyishou"] forState:(UIControlStateNormal)];
    [self.preButton setBackgroundImage:[UIImage imageNamed:@"iconfont-shangyishou-2"] forState:(UIControlStateHighlighted)];
    [self.preButton addTarget:self action:@selector(preAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.preButton];
    
    self.playButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.playButton.frame = CGRectMake(self.view.bounds.size.width / 2 - self.preButton.bounds.size.width / 2 - 3, self.preButton.frame.origin.y - 3, self.preButton.bounds.size.width + 6, self.preButton.bounds.size.width + 6);
    [self.playButton addTarget:self action:@selector(playAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.playButton];
    
    
    
    
    self.currentLabel = [[UILabel alloc]initWithFrame:(CGRectMake(0, self.slider.frame.origin.y, 40, 20))];
    self.currentLabel.text = @"00:00";
    self.currentLabel.textAlignment = NSTextAlignmentCenter;
    self.currentLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.currentLabel];
    
    self.totalLabel = [[UILabel alloc]initWithFrame:(CGRectMake(self.slider.frame.origin.x + self.slider.bounds.size.width, self.slider.frame.origin.y, 40, 20))];
    self.totalLabel.text = [NSString getMinuteSecondWithSecond:self.tracksList.duration];
    self.totalLabel.textAlignment = NSTextAlignmentCenter;
    self.totalLabel.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.totalLabel];
    
    
    self.nextButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    self.nextButton.frame = CGRectMake(self.view.bounds.size.width * 5 / 6 - self.preButton.bounds.size.width, self.preButton.frame.origin.y, self.preButton.bounds.size.width, self.preButton.bounds.size.width);
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"iconfont-xiayishou-2"] forState:(UIControlStateNormal)];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"iconfont-xiayishou"] forState:(UIControlStateHighlighted)];
    [self.nextButton addTarget:self action:@selector(nextAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:self.nextButton];
    
    
    
    self.smallImageView = [[UIImageView alloc]initWithFrame:(CGRectMake(20, self.playButton.frame.origin.y + self.playButton.bounds.size.height + 10, self.view.bounds.size.width / 4 - 30, self.view.bounds.size.width / 4 - 30))];
    self.smallImageView.layer.cornerRadius = self.smallImageView.bounds.size.width / 2;
    self.smallImageView.layer.masksToBounds = YES;
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:self.tracksList.coverSmall]];
    [self.view addSubview:self.smallImageView];
    
    self.nameLabel = [[UILabel alloc]initWithFrame:(CGRectMake(self.smallImageView.frame.origin.x + self.smallImageView.bounds.size.width + 20, self.smallImageView.frame.origin.y, self.view.bounds.size.width - self.smallImageView.bounds.size.width - self.smallImageView.frame.origin.x - 30, self.smallImageView.bounds.size.width / 2))];
    self.nameLabel.text = [NSString stringWithFormat:@"专辑名:  %@", self.tracksList.albumTitle];
    if (self.tracksList.albumTitle.length == 0) {
        self.nameLabel.text = [NSString stringWithFormat:@"电台: %@", self.tracksList.nickname];
    }
    self.nameLabel.font = [UIFont systemFontOfSize:15];
    self.nameLabel.numberOfLines = 0;
    [self.nameLabel sizeToFit];
    self.nameLabel.textColor = [UIColor shenhuiseColor];
    [self.view addSubview:self.nameLabel];
    
    self.playCounts = [[UILabel alloc]initWithFrame:(CGRectMake(self.smallImageView.frame.origin.x + self.smallImageView.bounds.size.width + 20, self.smallImageView.frame.origin.y + self.nameLabel.bounds.size.height + 5, self.view.bounds.size.width - self.smallImageView.bounds.size.width - self.smallImageView.frame.origin.x - 20, self.smallImageView.bounds.size.width / 2))];
    self.playCounts.text = [NSString stringWithFormat:@"播放次数:  %ld", self.tracksList.playtimes];
    self.playCounts.font = [UIFont systemFontOfSize:13];
    [self.playCounts sizeToFit];
    self.playCounts.textColor = [UIColor shenhuiseColor];
    [self.view addSubview:self.playCounts];
    
    
    UIButton *backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [backButton setBackgroundImage:[UIImage imageNamed:@"iconfont-down"] forState:(UIControlStateNormal)];
    backButton.frame = CGRectMake(20, 30, 25, 25);
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backButton];
   

    
    self.titleScrollView = [[TitleScrollView alloc]initWithFrame:(CGRectMake([UIScreen mainScreen].bounds.size.width / 4, 30, self.view.bounds.size.width / 2, 30))];
    self.titleScrollView.contentOffset = CGPointZero;
    self.titleScrollView.contentSize = CGSizeMake(200, 30);
    self.titleScrollView.layer.cornerRadius = 8;
    self.titleScrollView.titleStr = self.tracksList.title;
    [self.view addSubview:self.titleScrollView];


    if (self.tracksArray.count != 0) {
        [[MusicTool sharedMusicTool] preparePlayWithMusic:self.tracksList.playUrl64];
        [[MusicTool sharedMusicTool] play];
    }
    
    if ([MusicTool sharedMusicTool].isPlaying) {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_nomal2"] forState:(UIControlStateNormal)];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_click2"] forState:(UIControlStateHighlighted)];
//        [self.playButton setNBg:@"playbtn" hBg:@"pausebtn"];
    }else {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_nomal2"] forState:(UIControlStateNormal)];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_click2"] forState:(UIControlStateHighlighted)];
    }
    
    
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
}

- (void)collectionAction:(UIButton *)button {
    NSLog(@"收藏");
}
- (void)shareAction:(UIButton *)button {
    NSLog(@"分享");
}


- (void)sliderAction:(UISlider *)slider {
    CMTime newTime = [MusicTool sharedMusicTool].player.currentItem.currentTime;
    newTime.value = slider.value * newTime.timescale;
    
    [[MusicTool sharedMusicTool].player seekToTime:newTime];
    
}


- (void)tapAction:(UITapGestureRecognizer *)tap {
    self.isTap = !self.isTap;
    if (self.isTap) {
        [self.view bringSubviewToFront:self.sliderVoice];
        [self.view bringSubviewToFront:self.voiceButton];
    } else {
        [self.view sendSubviewToBack:self.sliderVoice];
        [self.view sendSubviewToBack:self.voiceButton];
    }
}

#pragma mark - XL改变声音
- (void)sliderVoiceAction:(UISlider *)slider {
    [MusicTool sharedMusicTool].player.volume = slider.value;
}

- (void)sliderStopAction:(UISlider *)slider {
    //点下
    [[MusicTool sharedMusicTool] pause];
}
- (void)sliderReplayAction:(UISlider *)slider {
    //松手
    [[MusicTool sharedMusicTool] play];
}

//上一首
- (void)preAction:(UIButton *)button {
    
    self.currentIndex -= 1;
    if (self.currentIndex < 0) {
        self.currentIndex = self.tracksArray.count - 1;
    }
    
    [[MusicTool sharedMusicTool] preparePlayWithMusic:((TracksList *)self.tracksArray[self.currentIndex]).playUrl64];
    if ([MusicTool sharedMusicTool].isPlaying) {
        [[MusicTool sharedMusicTool] play];
    }
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:((TracksList *)self.tracksArray[self.currentIndex]).coverLarge]];
    [self.midImageView2 sd_setImageWithURL:[NSURL URLWithString:((TracksList *)self.tracksArray[self.currentIndex]).coverMiddle]];
    self.titleScrollView.titleStr = ((TracksList *)self.tracksArray[self.currentIndex]).title;
    self.totalLabel.text = [NSString getMinuteSecondWithSecond:((TracksList *)self.tracksArray[self.currentIndex]).duration];
    
    
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:((TracksList *)self.tracksArray[self.currentIndex]).coverSmall]];
    self.nameLabel.text = ((TracksList *)self.tracksArray[self.currentIndex]).nickname;

    self.smallImageView.transform = CGAffineTransformIdentity;
}
//播放
- (void)playAction:(UIButton *)button {
    if ([MusicTool sharedMusicTool].isPlaying == NO) {
        [[MusicTool sharedMusicTool] play];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_nomal2"] forState:(UIControlStateNormal)];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_pausebtn_click2"] forState:(UIControlStateHighlighted)];
        [MusicTool sharedMusicTool].isPlaying = YES;
    }else {
        [[MusicTool sharedMusicTool] pause];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_nomal2"] forState:(UIControlStateNormal)];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"playbar_playbtn_click2"] forState:(UIControlStateHighlighted)];

        
        [MusicTool sharedMusicTool].isPlaying = NO;
    }
}

//下一首
- (void)nextAction:(UIButton *)button {
    self.currentIndex += 1;
    if (self.currentIndex > self.tracksArray.count - 1) {
        self.currentIndex = 0;
    }
    [[MusicTool sharedMusicTool] preparePlayWithMusic:((TracksList *)self.tracksArray[self.currentIndex]).playUrl64];
    if ([MusicTool sharedMusicTool].isPlaying) {
        [[MusicTool sharedMusicTool] play];
    }
    [self.topImageView sd_setImageWithURL:[NSURL URLWithString:((TracksList *)self.tracksArray[self.currentIndex]).coverLarge]];
    [self.midImageView2 sd_setImageWithURL:[NSURL URLWithString:((TracksList *)self.tracksArray[self.currentIndex]).coverMiddle]];
    self.titleScrollView.titleStr = ((TracksList *)self.tracksArray[self.currentIndex]).title;
    [self.smallImageView sd_setImageWithURL:[NSURL URLWithString:((TracksList *)self.tracksArray[self.currentIndex]).coverSmall]];
    self.nameLabel.text = ((TracksList *)self.tracksArray[self.currentIndex]).nickname;
    
    self.smallImageView.transform = CGAffineTransformIdentity;
}


- (void)backAction:(UIButton *)button {

//    self.iconUrlStrBlock(self.tracksList.coverMiddle);
    [[NSNotificationCenter defaultCenter] postNotificationName:@"音乐头像" object:self.tracksList.coverSmall];
    [self dismissViewControllerAnimated:YES completion:nil];

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
