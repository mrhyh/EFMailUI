//
//  RiskTypeFDARightCell.m
//  Risk
//
//  Created by ylgwhyh on 16/7/5.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RiskTypeFDARightCell.h"

@interface RiskTypeFDARightCell ()

@property (nonatomic, strong) KYMHImageView *leftImageView;
@property (nonatomic, strong) KYMHLabel *topLabel;
@property (nonatomic, strong) KYMHLabel *bottomLabel;


@end

@implementation RiskTypeFDARightCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) setup {
    
    _leftImageView = [KYMHImageView new];
    _leftImageView.contentMode = UIViewContentModeScaleAspectFill;
    _leftImageView.clipsToBounds = YES;
    
    _topLabel = [KYMHLabel new];
    _topLabel.font = Font(smallFontSize);
    _topLabel.textColor = EF_TextColor_TextColorPrimary;
    _topLabel.textAlignment = NSTextAlignmentLeft;
    
    _bottomLabel = [KYMHLabel new];
    _bottomLabel.font = Font(smallFontSize-2);
    _bottomLabel.textColor = EF_TextColor_TextColorSecondary;
    _bottomLabel.textAlignment = NSTextAlignmentLeft;
    
    _lineView = [UIView new];
    _lineView.backgroundColor = EF_TextColor_TextColorDisable;
    
    
    NSArray *views = @[_leftImageView, _topLabel, _bottomLabel, _lineView];
    
    [self.contentView sd_addSubviews:views];
    UIView *contentView = self.contentView;
    
    CGFloat spaceToLeft = 20;
    
    _leftImageView.sd_layout
    .topSpaceToView(contentView, 10)
    .leftSpaceToView(contentView, spaceToLeft)
    .widthIs(16)
    .heightIs(20);
    
    _topLabel.sd_layout
    .topEqualToView(_leftImageView)
    .leftSpaceToView(_leftImageView, 10)
    .widthIs(SCREEN_WIDTH/2-2*(spaceToLeft+10+16))
    .heightIs(20);
    
    _bottomLabel.sd_layout
    .topSpaceToView(_topLabel, 10)
    .leftEqualToView(_topLabel)
    .widthIs(SCREEN_WIDTH/2-2*(spaceToLeft+10+16))
    .heightIs(15);
    
    _lineView.sd_layout
    .topSpaceToView(_bottomLabel, 10)
    .leftSpaceToView(contentView, spaceToLeft)
    .heightIs(0.5)
    .widthIs(SCREEN_WIDTH/2-2*spaceToLeft);
    
}


- (void) setModel:(RiskTypeModel *)model {
    _model = model;
    
    _leftImageView.backgroundColor = [UIColor grayColor];
    _topLabel.text = model.name;
    _bottomLabel.text = model.idstr;
    
    //适配
    UIView *bottomView;
    bottomView = _lineView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}

@end
