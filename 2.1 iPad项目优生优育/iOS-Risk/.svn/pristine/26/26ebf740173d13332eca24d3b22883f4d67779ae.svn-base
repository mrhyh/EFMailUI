//
//  RSDataView.m
//  Risk
//
//  Created by ylgwhyh on 16/7/4.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSDataView.h"

@interface RSDataView ( ) {
    RSDataViewViewBlock rSDataViewViewBlock;
    KYMHLabel *titleLab1el;
}



@end

@implementation RSDataView {
    
    CGFloat spaceToLeft;
    CGFloat imageH;
    CGFloat imageW;
}

- (instancetype)initWithFrame:(CGRect)frame  dataModel: (RiskDataModel *)riskDataModel SelectBlock:(RSDataViewViewBlock)block {
    
    self = [super initWithFrame:frame];

    if(self )  {
        
        spaceToLeft = 20;
        imageW = 94;
        imageH = 73;
        
        rSDataViewViewBlock = block;
        
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:headView];
        
        headView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headViewClick)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [headView addGestureRecognizer:tapGesture];
        
        
        _topLineView = [UIView new];
        _topLineView.backgroundColor = EF_TextColor_TextColorDisable;
        
        _titleLabel = [KYMHLabel new];
        _titleLabel.textColor = EF_TextColor_TextColorPrimary;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = Font(middleFontSize);
        
        _leftImageView = [KYMHImageView new];
        _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
        _leftImageView.clipsToBounds = YES;
        
        _contentLabel = [KYMHLabel new];
        _contentLabel.textColor = EF_TextColor_TextColorSecondary;
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.numberOfLines = 0;
        _contentLabel.font = Font(middleFontSize);
        
        _statusLabel = [KYMHLabel new];
        _statusLabel.textColor = EF_TextColor_TextColorSecondary;
        _statusLabel.textAlignment = NSTextAlignmentRight;
        _statusLabel.font = Font(smallFontSize);
        
        NSArray *views = @[_topLineView, _titleLabel, _contentLabel, _statusLabel, _leftImageView];
        [headView sd_addSubviews:views];
        UIView *contentView = headView;
        
        _topLineView.sd_layout
        .topSpaceToView(contentView, 1)
        .rightSpaceToView(contentView, 0)
        .widthIs(frame.size.width)
        .heightIs(0.5);
        
        _titleLabel.sd_layout
        .topSpaceToView (contentView, 10)
        .leftSpaceToView(contentView, spaceToLeft+10)
        .rightSpaceToView(contentView, spaceToLeft)
        .heightIs(20);
        
        _leftImageView.sd_layout
        .topSpaceToView (_titleLabel, 10)
        .leftSpaceToView(contentView, spaceToLeft)
        .widthIs(imageW)
        .heightIs(imageH);
        
        _contentLabel.sd_layout
        .topEqualToView(_leftImageView)
        .leftSpaceToView(_leftImageView, 10)
        .rightSpaceToView(contentView, spaceToLeft)
        .heightIs(imageH-30);
        
        _statusLabel.sd_layout
        .topSpaceToView (_contentLabel, 10)
        .rightSpaceToView(contentView, spaceToLeft)
        .widthIs(frame.size.width-spaceToLeft-10)
        .heightIs(20);
        
    }
    return self;
    
}

- (void) setModel:(RiskDataModel *)model {
    
    _model = model;
    _titleLabel.text = model.titleString;
    _contentLabel.text = model.contentString;
    _statusLabel.text = [NSString stringWithFormat:@"%ld人阅读    大小: %ld k",(long)model.readNumberInteger, (long)model.memorySizeFloat];
    [_leftImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrlString] placeholderImage:[UIImage imageWithColor:[UIColor grayColor]]];
}

- (void) setTopLineView:(UIView *)topLineView {
    _topLineView = topLineView;
    
}

- (void)headViewClick {
    rSDataViewViewBlock(YES);
}

@end
