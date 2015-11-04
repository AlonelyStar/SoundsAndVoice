//
//  MusicTool.m
//  Music
//
//  Created by zhupeng on 15/10/31.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import "MusicTool.h"
#import <MediaPlayer/MediaPlayer.h>
@interface MusicTool ()


@property (nonatomic, strong) NSTimer *timer;

@end

@implementation MusicTool

singleton_implementation(MusicTool)

- (void)preparePlayWithMusic:(NSString *)url {
    if (!self.player) {
        self.player = [[AVPlayer alloc]init];
    }
    self.playerItem = [[AVPlayerItem alloc]initWithURL:[NSURL URLWithString:url]];
    
    [self.player replaceCurrentItemWithPlayerItem:self.playerItem];
    
}

- (void)setCoverSmallUrl:(NSString *)coverSmallUrl {
    _coverSmallUrl = coverSmallUrl;
}

- (void)play {
    self.isPlaying = YES;

    [self.player play];
}

- (void)pause {
    self.isPlaying = NO;
    [self.player pause];
}

-(void)stopPlayerAction:(NSInteger)time{
    self.timer1 = [NSTimer scheduledTimerWithTimeInterval:time target:self selector:@selector(stopPlayer) userInfo:nil repeats:NO];
}

- (void)stopPlayer{
    [self.player pause];
}

@end
