//
//  MusicTool.h
//  Music
//
//  Created by zhupeng on 15/10/31.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <AVFoundation/AVFoundation.h>

@interface MusicTool : NSObject

singleton_interface(MusicTool)

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) AVPlayerItem *playerItem;
@property (nonatomic, strong) AVPlayer *player;

- (void)preparePlayWithMusic:(NSString *)url;


- (void)play;

- (void)pause;

@property (nonatomic,strong) NSString *coverSmallUrl;


@property (nonatomic, strong) NSString *currentURL;
@property (nonatomic, strong) NSTimer *timer1;
- (void)stopPlayerAction:(NSInteger)time;


@end
