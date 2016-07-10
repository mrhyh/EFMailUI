//
//  RSVAVisitRecordCell.m
//  Risk
//
//  Created by ylgwhyh on 16/7/7.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSVAVisitRecordCell.h"

@interface RSVAVisitRecordCell ()
{
    RSVAVisitRecordCellHeadBlock rsVAVisitRecordCellHeadBlock;
}

@property (nonatomic, strong) KYMHButton *numberButton;
@property (nonatomic, strong) KYMHLabel *medicalRecordNumLabel;
@property (nonatomic, strong) KYMHLabel *nameLabel;
@property (nonatomic, strong) KYMHLabel *phoneNumLabel;


@end

@implementation RSVAVisitRecordCell {
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
    
    
    UIColor *buttonTitleColor = EF_TextColor_TextColorPrimary;
    _numberButton = [[KYMHButton alloc] initWithFrame:CGRectMake(0, 0, cellH, cellH)];
    [_numberButton setTitle:@"" forState:UIControlStateNormal];
    [_numberButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
    _numberButton.titleLabel.font = Font(smallFontSize);
    _numberButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    [_numberButton addTarget:self action:@selector(numberButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIView *buttonRightlineView = [[UIView alloc] initWithFrame:CGRectMake(_numberButton.frame.size.width, 0, 0.5, cellH-2)];
    buttonRightlineView.backgroundColor = EF_TextColor_TextColorDisable;
    [_numberButton addSubview:buttonRightlineView];
    
    CGFloat labelW = (SCREEN_WIDTH/2 - cellH )/2;
    _medicalRecordNumLabel = [self createLabelWithX:cellH width:labelW];
    _nameLabel = [self createLabelWithX:cellH+labelW width:labelW];

    NSArray *views = @[_topLineView,  _numberButton, _medicalRecordNumLabel, _nameLabel , _bottomLineView];
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
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(width, 0, 0.5, cellH-2)];
    lineView.backgroundColor = EF_TextColor_TextColorDisable;
    [label addSubview:lineView];
    
    return label;
}

#pragma mark Set

- (void) setIsShowButtonBool:(BOOL)isShowButtonBool {
    
    if(isShowButtonBool ) {
        
        [_numberButton setImage:Img(@"design_delete_down") forState:UIControlStateNormal];
        [_numberButton setImage:Img(@"design_choice_down") forState:UIControlStateSelected];
    }else {
        
        if(_model.numberInteger != 0) {
            NSString *string = [NSString stringWithFormat:@"%ld", (long)_model.numberInteger];
            [_numberButton setTitle:string forState:UIControlStateNormal];
        }else {
            [_numberButton setTitle:@"" forState:UIControlStateNormal];
        }
        
        [_numberButton setImage:Img(@"design_choice_down") forState:UIControlStateSelected];
    }
    
}

- (void) setModel:(RSVAArchivesModel *)model {
    
    _model = model;
    
    if(model.numberInteger != 0) {
        
        if(model.isSelected == YES ) {
            
            [_numberButton setImage:Img(@"design_delete_down") forState:UIControlStateNormal];
        }else {
            NSString *string = [NSString stringWithFormat:@"%ld", (long)model.numberInteger];
            [_numberButton setTitle:string forState:UIControlStateNormal];
            _numberButton.enabled = NO;
            
        }
        
    }else {
        [_numberButton setImage:Img(@"design_delete_down") forState:UIControlStateNormal];
        [_numberButton setImage:Img(@"design_choice_down") forState:UIControlStateSelected];
    }
    _medicalRecordNumLabel.text = model.exposureFactorString;
    _nameLabel.text = model.dosageString;
    _phoneNumLabel.text = model.mensesDataString;
    
    //cell高度适配
    UIView *bottomView;
    bottomView = _bottomLineView;
    [self setupAutoHeightWithBottomView:bottomView bottomMargin:0];
}

#pragma mark Button Action

- (void ) numberButtonAction: (KYMHButton *)button {
    
    button.selected = !button.selected;
    
    if(rsVAVisitRecordCellHeadBlock ) {
        rsVAVisitRecordCellHeadBlock(button.selected);
    }
}

- (void)RSVAVisitRecordCellHeadSelectBlock:(RSVAVisitRecordCellHeadBlock )block{
    
    rsVAVisitRecordCellHeadBlock = block;
}

@end