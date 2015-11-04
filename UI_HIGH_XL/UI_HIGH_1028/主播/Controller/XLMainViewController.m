//
//  XLMainViewController.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/11/4.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLMainViewController.h"
#import "SphereMenu.h"
#import "XLViewController.h"
#import "MainMusicViewController.h"
#import "XKLivingViewController.h"

@interface XLMainViewController ()<SphereMenuDelegate>

@property (nonatomic,assign) CGFloat picCWidth;
@property (nonatomic,assign) CGFloat picCX;



@end

@implementation XLMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.button.hidden = YES;
    
    [self addbottom];
}


- (void)addbottom {

    UIImage *startImage = [UIImage imageNamed:@"center.jpg"];
    UIImage *image1 = [UIImage imageNamed:@"zhiboPT"];
    UIImage *image2 = [UIImage imageNamed:@"yinyuePT"];
    UIImage *image3 = [UIImage imageNamed:@"zhuboPT"];
    UIImage *image4 = [UIImage imageNamed:@"wodePT"];
    NSArray *images = @[image1, image2, image3,image4];
    SphereMenu *sphereMenu = [[SphereMenu alloc] initWithStartPoint:CGPointMake([UIScreen mainScreen].bounds.size.width/ 2 , [UIScreen mainScreen].bounds.size.height / 2)
                                                         startImage:startImage
                                                      submenuImages:images];
    sphereMenu.delegate = self;
    [self.view addSubview:sphereMenu];
    
}

- (void)sphereDidSelected:(int)index
{
   
    switch (index) {
        case 0:
        {
            XKLivingViewController *livingVC = [[XKLivingViewController alloc]init];
            [self.navigationController pushViewController:livingVC animated:YES];
        }
            break;
        case 1:
        {
            MainMusicViewController *mainMusicVC = [[MainMusicViewController alloc]init];
            [self.navigationController pushViewController:mainMusicVC animated:YES];
        }
            break;
            
        case 2:
        {
            XLViewController *xlVC = [[XLViewController alloc] init];
            [self.navigationController pushViewController:xlVC animated:YES];
        }
            break;
            
        case 3:
        {
            
        }
            break;
            
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
