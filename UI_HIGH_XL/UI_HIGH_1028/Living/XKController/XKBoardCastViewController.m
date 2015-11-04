//
//  XKBoardCastViewController.m
//  LivingSounds
//
//  Created by 谢科的Mac on 15/11/2.
//  Copyright (c) 2015年 谢科. All rights reserved.
//

#import "XKBoardCastViewController.h"
#import "RadioPlayerURLModel.h"
#import "UIColor+AddColor.h"
#import "XKRankingListModel.h"
#import "BoradCastModel.h"
#import "AnnouncerModel.h"
#import "NetHandler.h"
#import "UIImageView+WebCache.h"
#import "BroadCastBottomView.h"
#import "SmallIconView.h"
#import "RadioPlayerURLModel.h"
#import "MusicTool.h"

@interface XKBoardCastViewController ()


@property (nonatomic,strong)UILabel *proNameLabel;

@property (nonatomic,strong)UILabel *zhuboLabel;

@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)BoradCastModel *boradModel;

@property (nonatomic,strong)UIImageView *bacImageView;

@property (nonatomic,strong)BroadCastBottomView *broadCastBottomView;

@property (nonatomic,strong)CADisplayLink *link;






@end

@implementation XKBoardCastViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.button setBackgroundImage:[UIImage imageNamed:@"downjiantou"] forState:(UIControlStateNormal)];
    [self.button setBackgroundImage:[UIImage imageNamed:@"downjiantou1"] forState:(UIControlStateHighlighted)];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"menglongbeijing.jpg"]];
    self.bacImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenWidth + 64)];
    self.topView.backgroundColor = nil;
    self.backgroundView.backgroundColor = nil;
    self.titleLabel.text = self.rankingModel.rname;
    self.titleLabel.textColor = [UIColor silverColor];
    [self setProView];
    
    [self.broadCastBottomView.slider addTarget:self action:@selector(sliderAction:) forControlEvents:(UIControlEventValueChanged)];
    [self.broadCastBottomView.slider addTarget:self action:@selector(sliderAction2:) forControlEvents:(UIControlEventTouchUpInside)];
    if ([MusicTool sharedMusicTool].currentURL == nil || [MusicTool sharedMusicTool].currentURL != self.rankingModel.RPURL.radio_24_aac) {
        [[MusicTool sharedMusicTool]preparePlayWithMusic:self.rankingModel.RPURL.radio_24_aac];
        [[MusicTool sharedMusicTool]play];
        [MusicTool sharedMusicTool].currentURL = self.rankingModel.RPURL.radio_24_aac;
    }
    
    [self handle];


    
     //Do any additional setup after loading the view.
}



- (void)handle{
     [NetHandler getDataWithUrl:[NSString stringWithFormat:@"http://live.ximalaya.com/live-web/v1/getProgramDetail?device=iPhone&programScheduleId=%ld&radioId=%ld",self.rankingModel.programScheduleId,self.rankingModel.radioId] completion:^(NSData *data) {
         if (data != nil) {
             NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
             NSDictionary *diction = [dic objectForKey:@"result"];
             self.boradModel = [[BoradCastModel alloc]init];
             [self.boradModel setValuesForKeysWithDictionary:diction];
             [self fuzhi];
             
         }
     }];
    
}
- (void)fuzhi{
    NSString *string = @"主播:";
    if (self.boradModel.announcerList.count == 0) {
        self.zhuboLabel.text = @"主播: 暂无";
    }else{
        for (int i = 0; i < self.boradModel.announcerList.count; i++) {
            AnnouncerModel *model = self.boradModel.announcerList[i];
            NSString *string1 = [NSString stringWithFormat:@" %@",model.announcerName];
            string = [NSString stringWithFormat:@"%@%@",string,string1];
        }
        self.zhuboLabel.text = string;
    }
    if (self.boradModel.startTime != nil && self.boradModel.startTime != nil) {
        NSString *timestring = [NSString stringWithFormat:@"%@ - %@",self.boradModel.startTime,self.boradModel.endTime];
        self.timeLabel.text = timestring;
    }else{
        self.timeLabel.text = @"00:00 - 24:00";
    }
    [self.bacImageView sd_setImageWithURL:[NSURL URLWithString:self.boradModel.playBackgroundPic]];
    
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeTime:)];
    self.link.frameInterval = 2;
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
    
    
}




- (void)setProView{
    [self.view insertSubview:self.bacImageView belowSubview:self.topView];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    
    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    
    UIVisualEffectView *effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    effectview.frame = CGRectMake(0, 0, self.backgroundView.frame.size.width, self.view.frame.size.height);
    [self.bacImageView addSubview:effectview];

    self.proNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, kScreenHeight / 6, kScreenWidth - 20, 20)];
    self.proNameLabel.textAlignment = NSTextAlignmentCenter;
    self.proNameLabel.font = [UIFont systemFontOfSize:20];
    self.proNameLabel.textColor = [UIColor silverColor];
    [self.backgroundView addSubview:self.proNameLabel];
    self.proNameLabel.text = self.rankingModel.programName;
    
    self.zhuboLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.proNameLabel.frame.origin.y + self.proNameLabel.bounds.size.height + 10, kScreenWidth - 20, 15)];
    self.zhuboLabel.textAlignment = NSTextAlignmentCenter;
    self.zhuboLabel.alpha = 0.5;
    self.zhuboLabel.textColor = [UIColor huiseColor];
    self.zhuboLabel.font = [UIFont systemFontOfSize:15];
    [self.backgroundView addSubview:self.zhuboLabel];
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.zhuboLabel.frame.origin.y + self.zhuboLabel.bounds.size.height + 10, kScreenWidth - 20, 15)];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.alpha = 0.5;
    self.timeLabel.textColor = [UIColor huiseColor];
    self.timeLabel.font = [UIFont systemFontOfSize:15];
    [self.backgroundView addSubview:self.timeLabel];

    self.broadCastBottomView = [[BroadCastBottomView alloc]initWithFrame:CGRectMake(0, kScreenWidth, kScreenWidth, self.backgroundView.bounds.size.height - kScreenWidth )];
    [self.backgroundView addSubview:self.broadCastBottomView];
    self.broadCastBottomView.startButton.hidden = YES;
    [self.broadCastBottomView.startButton addTarget:self action:@selector(startOrPause:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.broadCastBottomView.pauseButton addTarget:self action:@selector(startOrPause:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.broadCastBottomView.timeIconView.iconButton addTarget:self action:@selector(stopAfterTime:) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    
    
    
}

- (void)startOrPause:(UIButton *)button{
    if (self.broadCastBottomView.startButton.hidden) {
        self.broadCastBottomView.pauseButton.hidden = YES;
        self.broadCastBottomView.startButton.hidden = NO;
        [[MusicTool sharedMusicTool]pause];
    }else{
        self.broadCastBottomView.startButton.hidden = YES;
        self.broadCastBottomView.pauseButton.hidden = NO;
        [[MusicTool sharedMusicTool]preparePlayWithMusic:self.rankingModel.RPURL.radio_24_aac];
        [[MusicTool sharedMusicTool]play];
        
    }
}

- (void)sliderAction:(UISlider *)slider{
   
    [self.link invalidate];
    self.link = nil;
 
}

- (void)sliderAction2:(UISlider *)slider{
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeTime:)];
    self.link.frameInterval = 2;
    [self.link addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)changeTime:(CADisplayLink *)link{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *s_temp=[formater stringFromDate:date];
    if (self.boradModel.startTime != nil && self.boradModel.startTime != nil){
        self.broadCastBottomView.startTimeLabel.text = s_temp;
        self.broadCastBottomView.endTimeLabel.text = self.boradModel.endTime;
        [self changeSliderValue];
     
    }else{
        self.broadCastBottomView.startTimeLabel.text = @"00:00";
        self.broadCastBottomView.endTimeLabel.text = @"00:00";
        self.broadCastBottomView.slider.value = 0;
    }
    if (self.boradModel.endTime != nil) {
        NSString *string = [NSString stringWithFormat:@"%@:00",self.boradModel.endTime];
        if ([s_temp isEqualToString:string]) {
            [self.link invalidate];
            self.link = nil;
            [self handle];
        }
    }
    
    
    
}

- (void)changeSliderValue{
    NSDateFormatter *formater = [[NSDateFormatter alloc] init];
    [formater setDateFormat:@"HH:mm:ss"];
    NSDate *date = [NSDate date];
    NSString *s_temp=[formater stringFromDate:date];
    
    NSArray *arr1 = [self.boradModel.startTime componentsSeparatedByString:@":"];
    NSInteger startHour = [arr1[0] integerValue];
    NSInteger startmin = [arr1[1] integerValue];
    NSInteger startnumber = startHour* 60 * 60 + startmin * 60;
    
    NSArray *arr2 = [self.boradModel.endTime componentsSeparatedByString:@":"];
    NSInteger endHour = [arr2[0] integerValue];
    NSInteger endmin = [arr2[1] integerValue];
    NSInteger endnumber = 0;
    if (endHour < startHour){
        endnumber = (endHour + 24) * 60 * 60 + endmin * 60;
    }else{
        endnumber = endHour* 60 * 60 + endmin * 60;
    }
    
    NSInteger duration = endnumber - startnumber;
    
    self.broadCastBottomView.slider.maximumValue = duration;
    self.broadCastBottomView.slider.minimumValue = 0;
    
    NSArray *arr3 = [s_temp componentsSeparatedByString:@":"];
    NSInteger currentHour = [arr3[0] integerValue];
    NSInteger currentmin = [arr3[1] integerValue];
    NSInteger currentseconds = [arr3[2] integerValue];
    NSInteger currentnumber = 0;
    if (currentHour < startHour) {
        currentnumber = (currentHour + 24) * 60 * 60 + currentmin * 60 + currentseconds;
    }else if (currentHour == 0){
        currentnumber = 24 * 60 * 60 + currentmin * 60 + currentseconds;
    }else{
        currentnumber = currentHour * 60 * 60 + currentmin * 60 + currentseconds;
    }
    NSInteger cunum = currentnumber - startnumber;
    [self.broadCastBottomView.slider setValue:cunum animated:YES];
}

#pragma mark--定时
- (void)stopAfterTime:(UIButton *)button{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"定时" message:nil preferredStyle:(UIAlertControllerStyleActionSheet)];
    
    UIAlertAction *passTimeStop = [UIAlertAction actionWithTitle:@"取消定时关闭" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        if ([MusicTool sharedMusicTool].timer1 != nil) {
            [[MusicTool sharedMusicTool].timer1 invalidate];
            [MusicTool sharedMusicTool].timer1 = nil;
        }
        
    }];
    [alertVC addAction:passTimeStop];
    
    UIAlertAction *ten = [UIAlertAction actionWithTitle:@"10分钟" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self settime:10];
    }];
    
    [alertVC addAction:ten];
    UIAlertAction *twenty = [UIAlertAction actionWithTitle:@"20分钟" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self settime:20];
        
    }];
    [alertVC addAction:twenty];
    
    UIAlertAction *thirty = [UIAlertAction actionWithTitle:@"30分钟" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self settime:30];
        
    }];
    [alertVC addAction:thirty];
    
    UIAlertAction *sixty = [UIAlertAction actionWithTitle:@"60分钟" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self settime:60];
        
    }];
    [alertVC addAction:sixty];
    
    UIAlertAction *ninety = [UIAlertAction actionWithTitle:@"90分钟" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self settime:90];
    }];
    [alertVC addAction:ninety];
    
    UIAlertAction *longest = [UIAlertAction actionWithTitle:@"120分钟" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
        [self settime:120];
    }];
    [alertVC addAction:longest];
    
    UIAlertAction *last = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
    }];
    [alertVC addAction:last];
    alertVC.view.alpha = 0.8;
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
 
    
}

- (void)settime:(NSInteger)number{
    if ([MusicTool sharedMusicTool].timer1 != nil) {
        [[MusicTool sharedMusicTool].timer1 invalidate];
        [MusicTool sharedMusicTool].timer1 = nil;
    }
    NSInteger time = number * 60;
    [[MusicTool sharedMusicTool] stopPlayerAction:time];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)backAction:(UIButton *)button {
    [self dismissViewControllerAnimated:YES completion:nil];
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
