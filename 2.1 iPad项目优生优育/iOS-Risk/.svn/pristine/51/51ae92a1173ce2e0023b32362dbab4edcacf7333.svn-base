//
//  RSVAriskFactorCell.m
//  Risk
//
//  Created by ylgwhyh on 16/7/7.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSVAriskFactorCell.h"



@interface RSVAriskFactorCell ()
{
    RSVAriskFactorCellHeadBlock rsVAriskFactorCellHeadBlock;
}

@property (nonatomic, strong) KYMHButton *numberButton;
@property (nonatomic, strong) KYMHLabel *medicalRecordNumLabel;
@property (nonatomic, strong) KYMHLabel *nameLabel;
@property (nonatomic, strong) KYMHLabel *phoneNumLabel;
@property (nonatomic, strong) UIView *cellBGView;

@end

@implementation RSVAriskFactorCell {
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void) setup {
    
    cellH = 44;
    textColor = EF_TextColor_TextColorPrimary;
    
    _cellBGView = [[UIView alloc] init];
    _cellBGView.frame = self.contentView.frame;
    [self.contentView addSubview:_cellBGView];
    
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
    
    _medicalRecordNumLabel = [self createLabelWithX:cellH width:200];
    _nameLabel = [self createLabelWithX:cellH+200 width:50];
    _phoneNumLabel = [self createLabelWithX:cellH+250 width:SCREEN_WIDTH/2-cellH-250];    
    
    NSArray *views = @[_topLineView,  _numberButton, _medicalRecordNumLabel, _nameLabel,_phoneNumLabel , _bottomLineView];
    [_cellBGView sd_addSubviews:views];
    
    _topLineView.sd_layout
    .topSpaceToView(self.cellBGView, 1)
    .leftSpaceToView(self.cellBGView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
    
    _bottomLineView.sd_layout
    .bottomSpaceToView(self.cellBGView, 1)
    .leftSpaceToView(self.cellBGView, 0)
    .widthIs(SCREEN_WIDTH)
    .heightIs(0.5);
    
//    [_bottomLineView bringSubviewToFront:self.contentView];
//    [_topLineView bringSubviewToFront:self.contentView];
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
    
    if(rsVAriskFactorCellHeadBlock ) {
        rsVAriskFactorCellHeadBlock(button.selected);
    }
}

- (void)RSVAriskFactorCellHeadSelectBlock:(RSVAriskFactorCellHeadBlock )block{
    
    rsVAriskFactorCellHeadBlock = block;
}


-(void) setEditing:(BOOL)editing animated:(BOOL)animated{
    
    if (self.editing == editing)
    {
        return;
    }
    
    [super setEditing:editing animated:animated];
    
    //cell本会右移，这里讲其往左边移动30，抵消编辑模式的右移距离
    if (editing) {

        [self.cellBGView setFrame:CGRectMake(self.cellBGView.frame.origin.x - 30, self.cellBGView.frame.origin.y, self.cellBGView.frame.size.width, self.cellBGView.frame.size.height)];
        }
    else {
        [self.cellBGView setFrame:CGRectMake(self.cellBGView.frame.origin.x + 30, self.cellBGView.frame.origin.y, self.cellBGView.frame.size.width, self.cellBGView.frame.size.height)];
    }
    
}

- (void) setChecked:(BOOL)checked
{
//    if (checked)
//    {
//        _checkImageView.image = [UIImage imageNamed:@"Selected.png"];
//        self.backgroundView.backgroundColor = [UIColor colorWithRed:223.0/255.0 green:230.0/255.0 blue:250.0/255.0 alpha:1.0];
//    }
//    else
//    {
//        _checkImageView.image = [UIImage imageNamed:@"Unselected.png"];
//        self.backgroundView.backgroundColor = [UIColor whiteColor];
//    }
//    _checked = checked;
}


@end