//
//  RSVAriskFactorCell.h
//  Risk
//
//  Created by ylgwhyh on 16/7/7.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RSVAArchivesModel.h"

typedef void(^RSVAriskFactorCellHeadBlock)(BOOL isSelected);


@interface RSVAriskFactorCell : UITableViewCell

@property (nonatomic, strong) RSVAArchivesModel *model;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, assign) BOOL isShowButtonBool;

- (void)RSVAriskFactorCellHeadSelectBlock:(RSVAriskFactorCellHeadBlock )block;

@end
