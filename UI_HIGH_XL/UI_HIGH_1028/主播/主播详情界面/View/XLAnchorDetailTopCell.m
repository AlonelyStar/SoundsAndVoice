//
//  XLAnchorDetailTopCell.m
//  UI_HIGH_1028
//
//  Created by lanou on 15/10/29.
//  Copyright (c) 2015年 xxl. All rights reserved.
//

#import "XLAnchorDetailTopCell.h"
#import "XLDetailTop.h"
#import "UIImageView+WebCache.h"
#import "NSString+XL.h"
#import "UIColor+AddColor.h"

@interface XLAnchorDetailTopCell()

@property (strong, nonatomic) IBOutlet UIImageView *backgroudImageV;


@property (strong, nonatomic) IBOutlet UILabel *followingsLabel;

@property (strong, nonatomic) IBOutlet UILabel *followersLabel;

@property (strong, nonatomic) IBOutlet UILabel *favoritesLabel;

@property (strong, nonatomic) IBOutlet UILabel *nicknameLabel;

@property (strong, nonatomic) IBOutlet UILabel *personalSignatureLabel;



@property (nonatomic,assign) BOOL isTap;

@property (strong, nonatomic) IBOutlet UIImageView *daVImageView;

@end


@implementation XLAnchorDetailTopCell


- (void)setDetailTop:(XLDetailTop *)detailTop {
    _detailTop = detailTop;
    
    if (detailTop.isVerified) {
        self.daVImageView.image = [UIImage imageNamed:@"daV"];
    }
    
    [self.backgroudImageV sd_setImageWithURL:[NSURL URLWithString:detailTop.backgroundLogo] placeholderImage:nil];
    self.backgroudImageV.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    [self.backgroudImageV addGestureRecognizer:tap];
    
    [self.circleImageV sd_setImageWithURL:[NSURL URLWithString:detailTop.mobileSmallLogo] placeholderImage:nil];
    self.circleImageV.layer.cornerRadius = 40;
    self.circleImageV.layer.masksToBounds = YES;
    self.circleImageV.userInteractionEnabled = YES;
    
    self.followersLabel.text = [NSString getGreaterTenThousandWithNumber:detailTop.followers];
    self.followingsLabel.text = [NSString getGreaterTenThousandWithNumber:detailTop.followings];
    self.favoritesLabel.text = [NSString getGreaterTenThousandWithNumber:detailTop.favorites];
    
    self.nicknameLabel.text = detailTop.nickname;
    self.nicknameLabel.textColor = [UIColor whiteColor];
    self.personalSignatureLabel.text = detailTop.personalSignature;
    self.personalSignatureLabel.textColor = [UIColor shenhuiseColor];
    self.personalSignatureLabel.textAlignment = NSTextAlignmentCenter;
   
    self.attentionBtn.tag = 2000;
    self.funsBtn.tag = 2001;
    self.praiseBtn.tag = 2002;
    
    
    
}

- (void)tapClick:(UITapGestureRecognizer *)tap {

    [self rotationAnimation];
}

- (void)rotationAnimation {
    self.isTap = !self.isTap;
    
    [UIView animateWithDuration:0.4 delay:0 options:(UIViewAnimationOptionCurveLinear) animations:^{
        self.circleImageV.transform = CGAffineTransformRotate(self.circleImageV.transform, M_PI);
        if (self.isTap) {
            self.circleImageV.frame = CGRectMake(self.circleImageV.frame.origin.x, 0, self.circleImageV.bounds.size.width, self.circleImageV.bounds.size.height);
            
        } else {
            self.circleImageV.frame = CGRectMake(self.circleImageV.frame.origin.x, 215, self.circleImageV.bounds.size.width, self.circleImageV.bounds.size.height);
        }
    } completion:^(BOOL finished) {
        if (finished && !CGAffineTransformEqualToTransform(self.circleImageV.transform, CGAffineTransformIdentity)) {
        }
    }];
    
    [UIView animateWithDuration:0.25 animations:^{
    
        if (CGAffineTransformIsIdentity(self.nicknameLabel.transform)) {
            self.nicknameLabel.transform = CGAffineTransformTranslate(self.nicknameLabel.transform, 0, -100);
            self.daVImageView.transform = CGAffineTransformTranslate(self.daVImageView.transform, 0, -100);
            self.personalSignatureLabel.transform = CGAffineTransformTranslate(self.personalSignatureLabel.transform, 0, - 60);
            self.personalSignatureLabel.numberOfLines = 0;
            [self.personalSignatureLabel sizeToFit];
            self.jiantouImageView.transform = CGAffineTransformRotate(self.jiantouImageView.transform, M_PI);
            
        }else {
            self.nicknameLabel.transform = CGAffineTransformIdentity;
            self.daVImageView.transform = CGAffineTransformIdentity;
            self.personalSignatureLabel.transform = CGAffineTransformIdentity;
            self.personalSignatureLabel.numberOfLines = 1;
            self.jiantouImageView.transform = CGAffineTransformIdentity;
        }
    }];
    
}


- (void)awakeFromNib {
    // Initialization code
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
