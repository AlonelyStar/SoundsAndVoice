//
//  MusicListCell.h
//  Music
//
//  Created by zhupeng on 15/10/28.
//  Copyright (c) 2015年 朱鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProgramSelection.h"
#import "Album.h"

@interface MusicListCell : UITableViewCell

@property (nonatomic, strong) ProgramSelection *programSelection;
@property (nonatomic, strong) Album *album;

@end
