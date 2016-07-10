//
//  RSVAArchivesCell.m
//  Risk
//
//  Created by ylgwhyh on 16/7/6.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSVAArchivesCell.h"

@interface RSVAArchivesCell ()


@property (nonatomic, strong) KYMHLabel *numberLabel;
@property (nonatomic, strong) KYMHLabel *medicalRecordNumLabel;
@property (nonatomic, strong) KYMHLabel *nameLabel;
@property (nonatomic, strong) KYMHLabel *phoneNumLabel;
@property (nonatomic, strong) KYMHLabel *mensesDataLabel;
@property (nonatomic, strong) KYMHLabel *estimateTimeLabel;
@property (nonatomic, strong) KYMHLabel *pregnantTimeLabel;
@property (nonatomic, strong) KYMHLabel *babyNumberLabel;
@property (nonatomic, strong) KYMHLabel *exposureFactorLabel;



@end

@implementation RSVAArchivesCell {
    CGFloat cellH;
    UIColor *textColor;
}



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void) setup {
    cellH = 44;
    textColor = EF_TextColor_TextColorPrimary;
    
    _topLineView = [UIView new];
    _topLineView.backgroundColor = EF_TextColor_TextColorDisable;
    _topLineView.hidden = YES; //默认隐藏
    
    _bottomLineView = [UIView new];
    _bottomLineView.backgroundColor = EF_TextColor_TextColorDisable;
    
    
    _numberLabel = [self createLabelWithX:0 width:60];
    _medicalRecordNumLabel = [self createLabelWithX:60 width:115];
    _nameLabel = [self createLabelWithX:175 width:75];
    _phoneNumLabel = [self createLabelWithX:250 width:115];
    _mensesDataLabel = [self createLabelWithX:365 width:95];
    _estimateTimeLabel = [self createLabelWithX:460 width:95];
    _pregnantTimeLabel = [self createLabelWithX:555 width:55];
    _babyNumberLabel = [self createLabelWithX:610 width:55];
    _exposureFactorLabel = [self createLabelWithX:665 width:SCREEN_WIDTH-665];
    
    NSArray *views = @[_topLineView,  _numberLabel, _medicalRecordNumLabel, _nameLabel,_phoneNumLabel,  _mensesDataLabel, _estimateTimeLabel, _pregnantTimeLabel ,_babyNumberLabel, _exposureFactorLabel, _bottomLineView];
    [self.contentView sd_addSubviews:views];
    
    _topLineView.sd_layout
    .topSpaceToView(self.contentView, 1)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);

    
    _bottomLineView.sd_layout
    .bottomSpaceToView(self.contentView, 1)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
 
    [_bottomLineView bringSubviewToFront:self.contentView];
    [_topLineView bringSubviewToFront:self.contentView];
}


- (KYMHLabel *)createLabelWithX:(CGFloat )x width:(CGFloat )width {
    
    KYMHLabel *label = [[KYMHLabel alloc] initWithTitle:nil BaseSize:CGRectMake(x, 0, width, cellH) LabelColor:nil LabelFont:smallFontSize LabelTitleColor:textColor TextAlignment:NSTextAlignmentCenter];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, 0.5, cellH)];
    lineView.backgroundColor = EF_TextColor_TextColorDisable;
    [label addSubview:lineView];
    
    return label;
}



- (void) setModel:(RSVAArchivesModel *)model {
    
    _model = model;
    
    if(model.numberInteger != 0) {
        _numberLabel.text = [NSString stringWithFormat:@"%ld", (long)model.numberInteger];
    }
    _medicalRecordNumLabel.text = model.medicalRecordNumString;
    _nameLabel.text = model.nameString;
    _phoneNumLabel.text = model.phoneNumString;
    _mensesDataLabel.text = model.mensesDataString;
    _estimateTimeLabel.text = model.estimateTimeString;
    _pregnantTimeLabel.text = model.pregnantTimesString;
    _babyNumberLabel.text = model.babyNumberString;
    _exposureFactorLabel.text = model.exposureFactorString;
    
    
    //cell高度适配
    UIView *bottomView;
    bottomView = _bottomLineView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}

@end