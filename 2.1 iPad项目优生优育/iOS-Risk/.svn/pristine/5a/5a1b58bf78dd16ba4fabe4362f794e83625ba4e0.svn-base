//
//  SecondSmallToolCell.m
//  Risk
//
//  Created by Cherie Jeong on 16/7/7.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "SecondSmallToolCell.h"

@interface SecondSmallToolCell ()

@property (nonatomic,strong) KYMHImageView * imageView;
@property (nonatomic,strong) KYMHLabel * nameLB;

@end

@implementation SecondSmallToolCell

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
    
    _nameLB = [[KYMHLabel alloc]init];
    _nameLB.backgroundColor = [UIColor clearColor];
    _nameLB.textColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackNormal];
    _nameLB.font = Font(smallFontSize);
    _nameLB.textAlignment = NSTextAlignmentLeft;
    
    NSArray * views = @[_imageView,_nameLB];
    UIView * contentView = self.contentView;
    [contentView sd_addSubviews:views];
    
    _nameLB.sd_layout
    .leftEqualToView(contentView)
    .rightEqualToView(contentView)
    .bottomSpaceToView(contentView,10)
    .heightIs(30);
    
    _imageView.sd_layout
    .topSpaceToView(contentView,15)
    .bottomSpaceToView(_nameLB,10)
    .centerXEqualToView(contentView)
    .widthEqualToHeight();
    
    
}

- (void)set {
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:Img(@"")];
    _nameLB.text = [NSString stringWithFormat:@"小工具%ld",(long)self.indexPath.row+1];
}

@end
