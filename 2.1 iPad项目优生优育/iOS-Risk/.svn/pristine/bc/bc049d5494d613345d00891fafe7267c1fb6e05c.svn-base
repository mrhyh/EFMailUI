//
//  SecondCollectionViewCell.m
//  Risk
//
//  Created by Cherie Jeong on 16/7/6.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "SecondCollectionViewCell.h"

@interface SecondCollectionViewCell ()

@property (nonatomic,strong) KYMHImageView * imageView;
@property (nonatomic,strong) KYMHLabel * titleLB;
@property (nonatomic,strong) KYMHLabel * numberOfReadLB;
@property (nonatomic,strong) KYMHLabel * sizeLB;
@property (nonatomic,strong) KYMHImageView * rightImageView;
@property (nonatomic,strong) UIView * line;

@end

@implementation SecondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUp];
        
        [self set];
    }
    return self;
}

- (void)setUp {
    
    _imageView = [[KYMHImageView alloc]init];
    _imageView.backgroundColor = [UIColor redColor];
    
    _titleLB = [[KYMHLabel alloc]init];
    _titleLB.backgroundColor = [UIColor clearColor];
    _titleLB.textColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackNormal];
    _titleLB.font = Font(smallFontSize);
    _titleLB.textAlignment = NSTextAlignmentLeft;
    
    _numberOfReadLB = [[KYMHLabel alloc]init];
    _numberOfReadLB.backgroundColor = [UIColor clearColor];
    _numberOfReadLB.textColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackHint];
    _numberOfReadLB.font = Font(10);
    _numberOfReadLB.textAlignment = NSTextAlignmentLeft;
    
    _sizeLB = [[KYMHLabel alloc]init];
    _sizeLB.backgroundColor = [UIColor clearColor];
    _sizeLB.textColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackHint];
    _sizeLB.font = Font(10);
    _sizeLB.textAlignment = NSTextAlignmentLeft;
    
    _rightImageView = [[KYMHImageView alloc]init];
    _rightImageView.backgroundColor = [UIColor clearColor];
    
    _line = [[UIView alloc]init];
    _line.backgroundColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackHint];
    
    
    NSArray * views = @[_imageView,_titleLB,_numberOfReadLB,_sizeLB,_rightImageView,_line];
    UIView * contentView = self.contentView;
    [contentView sd_addSubviews:views];
    
    _imageView.sd_layout
    .leftSpaceToView(contentView,25)
    .topSpaceToView(contentView,10)
    .bottomSpaceToView(contentView,10)
    .widthEqualToHeight();
    
    _rightImageView.sd_layout
    .rightSpaceToView(contentView,10)
    .centerYEqualToView(contentView)
    .heightIs(16)
    .widthIs(10);
    
    _numberOfReadLB.sd_layout
    .leftSpaceToView(_imageView,10)
    .bottomEqualToView(_imageView)
    .heightIs(10);
    [_numberOfReadLB setSingleLineAutoResizeWithMaxWidth:150];
    
    _sizeLB.sd_layout
    .leftSpaceToView(_numberOfReadLB,10)
    .topEqualToView(_numberOfReadLB)
    .heightIs(10);
    [_sizeLB setSingleLineAutoResizeWithMaxWidth:150];
    
    _titleLB.sd_layout
    .leftSpaceToView(_imageView,10)
    .topSpaceToView(contentView,7.5)
    .rightSpaceToView(_rightImageView,5)
    .bottomSpaceToView(_numberOfReadLB,5);
    [_titleLB setMaxNumberOfLinesToShow:2];
    
    _line.sd_layout
    .leftSpaceToView(contentView,10)
    .bottomEqualToView(contentView)
    .widthIs(SCREEN_WIDTH/3-10)
    .heightIs(0.5);
    
}

- (void)set {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:Img(@"")];
    [_rightImageView setImage:Img(@"ic_arrow_right_1")];
    _titleLB.text = @"国内航空公司对孕妇的保护措施国内航空公司对孕妇的保护措施";
    _numberOfReadLB.text = @"666人阅读";
    _sizeLB.text = @"大小：123Kb";
    
}

@end
