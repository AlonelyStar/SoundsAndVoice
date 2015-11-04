//
//  NewsTopCell.m
//  LOL盒子
//
//  Created by lanou on 15/10/20.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "NewsTopCell.h"
#import "UIImageView+WebCache.h"
@interface NewsTopCell() <UIScrollViewDelegate>

@property (nonatomic,strong) UIPageControl *pageControl;

@end

#define height 180
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

@implementation NewsTopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.scrollView = [[UIScrollView alloc] initWithFrame:(CGRectMake(0, 0, ScreenWidth, height))];
        self.scrollView.delegate = self;
        [self.contentView addSubview:self.scrollView];
        
        self.scrollView.contentSize = CGSizeMake(8 * ScreenWidth, height);
        self.scrollView.backgroundColor = [UIColor whiteColor];
        self.scrollView.contentOffset = CGPointMake(ScreenWidth, 0);
        self.scrollView.pagingEnabled = YES;
     
        self.pageControl = [[UIPageControl alloc] initWithFrame:(CGRectMake(ScreenWidth / 2 - 40, height - 20, 80, 20))];
        self.pageControl.numberOfPages = 7;
        self.pageControl.currentPage = 0;
        [self.contentView addSubview:self.pageControl];
        [self.pageControl addTarget:self action:@selector(pageChanged:) forControlEvents:(UIControlEventValueChanged)];
        [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(autoPlay:) userInfo:@"传递给Timer的信息" repeats:YES];
    }
    
    return self;
}

- (void)pageChanged:(UIPageControl *)pag {
    NSInteger currentPage = pag.currentPage;
    [self.scrollView setContentOffset:(CGPointMake((currentPage + 1)*ScreenWidth, 0)) animated:YES];
}

#pragma mark - 定时器自动执行方法autoPlay:
- (void)autoPlay:(NSTimer *)timer {
  

    CGFloat width = _scrollView.frame.size.width;
    CGPoint offSet = _scrollView.contentOffset;

    if (offSet.x + width == width * 8) {
        // 切换到第一张图片
        [_scrollView setContentOffset:CGPointZero animated:NO]; // 注意切换时不做动画

        // 切换后,然后偏移width
        [_scrollView setContentOffset:CGPointMake(width, offSet.y) animated:YES];

    } else {
        [_scrollView setContentOffset:CGPointMake(offSet.x + width, offSet.y) animated:YES];
    }
  
    offSet = _scrollView.contentOffset;
    // 2.计算当前显示的页面
    NSInteger page = offSet.x / width;
    _pageControl.currentPage = page;

}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

    CGFloat width = scrollView.frame.size.width;

    CGPoint offSet = scrollView.contentOffset;

    NSInteger page = offSet.x / width;
    // 如果为第一张图片,因为第一张图为衔接图,与最后一张图相同,pageControl设0.为最后页面
    if (page == 0) {

        _pageControl.currentPage = _pageControl.numberOfPages - 1;
    }else {
        _pageControl.currentPage = page - 1;
    }
}

- (void)setHeaderlineArray:(NSArray *)headerlineArray {
    _headerlineArray = headerlineArray;
    for (int i = 0,j = 0; i < 8; i++) {
        if (i == 0) {
            j = 6;
        } else {
            j = i - 1;
        }
        UIImageView *imageV = [[UIImageView alloc] initWithFrame:(CGRectMake(i*ScreenWidth, 0, ScreenWidth, height))];
        [imageV sd_setImageWithURL:[NSURL URLWithString:headerlineArray[j]] placeholderImage:nil];
        [self.scrollView addSubview:imageV];
    }
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x > 7 * scrollView.bounds.size.width) {
        self.scrollView.contentOffset = CGPointMake(0, 0);
    }
    if (scrollView.contentOffset.x < 0) {
        self.scrollView.contentOffset = CGPointMake(7 * scrollView.bounds.size.width, 0);
    }
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
