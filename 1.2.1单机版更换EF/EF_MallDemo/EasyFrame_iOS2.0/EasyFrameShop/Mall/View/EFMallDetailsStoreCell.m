//
//  EFMallDetailsStoreCell.m
//  EF_MallDemo
//
//  Created by MH on 16/6/13.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFMallDetailsStoreCell.h"
const CGFloat titleSLabelFontSize = 15;
CGFloat maxTitleSLabelHeight = 0;
const CGFloat contentSLabelFontSize = 13;
CGFloat maxContentSLabelHeight = 0;
@implementation EFMallDetailsStoreCell{
    UILabel * _titleLabel;
    UILabel * _contentLabel;
    UIView   *_line;
    KYMHButton * _button;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setup];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setup
{

    _titleLabel = [UILabel new];
    _titleLabel.font = [UIFont systemFontOfSize:titleSLabelFontSize];
    _titleLabel.textColor = EF_TextColor_TextColorPrimary;
    _titleLabel.text = @"仁恒镁光牙科";
    if (maxTitleSLabelHeight == 0) {
        maxTitleSLabelHeight = _titleLabel.font.lineHeight * 3;
    }
    
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:contentSLabelFontSize];
    _contentLabel.textColor = EF_TextColor_TextColorSecondary;
    _contentLabel.text = @"成都市武侯区桐梓林北路凯莱帝景还原C-5-C";
    if (maxContentSLabelHeight == 0) {
        maxContentSLabelHeight = _contentLabel.font.lineHeight * 3;
    }

    _button = [KYMHButton new];
    UIImage * image = Img(@"ic_arrow_right_1");
    [_button setImage:image forState:0];
    [_button addTarget:self action:@selector(phoneButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    _line = [UIView new];
    _line.backgroundColor = EF_TextColor_TextColorDisable;
    
    
    
    NSArray *views = @[_titleLabel, _contentLabel, _line, _button];
    
    [self.contentView sd_addSubviews:views];
    
    UIView *contentView = self.contentView;
    CGFloat margin = 10;
    
    
    
    
    _titleLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(contentView, 70)
    .autoHeightRatio(0);
    
    _contentLabel.sd_layout
    .leftSpaceToView(contentView, margin)
    .topSpaceToView(_titleLabel, margin)
    .rightSpaceToView(contentView, 70)
    .autoHeightRatio(0);
    
    _button.sd_layout
    .rightEqualToView(contentView)
    .centerYEqualToView(contentView)
    .widthIs(50)
    .heightIs(50);
    
    _line.sd_layout
    .bottomSpaceToView(contentView,margin)
    .topSpaceToView(contentView, margin)
    .rightSpaceToView(_button,margin)
    .widthIs(0.5);
    
}

- (void)phoneButtonClicked{
    if (self.phoneButtonClickedBlock) {
        self.phoneButtonClickedBlock(self.indexPath);
    }
}
@end
