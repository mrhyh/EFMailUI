//
//  RSDataView.h
//  Risk
//
//  Created by ylgwhyh on 16/7/4.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RiskDataModel.h"


#if NS_BLOCKS_AVAILABLE

typedef void (^RSDataViewViewBlock)(BOOL isSelected);

#endif

@interface RSDataView : UIView

@property (nonatomic, strong)  KYMHLabel *titleLabel;
@property (nonatomic, strong)  KYMHLabel *contentLabel;
@property (nonatomic, strong)  KYMHLabel *statusLabel;
@property (nonatomic, strong)  KYMHImageView *leftImageView;
@property (nonatomic, strong)  UIView *topLineView;

@property (nonatomic , strong) RiskDataModel *model;

- (instancetype)initWithFrame:(CGRect)frame  dataModel: (RiskDataModel *)riskDataModel SelectBlock:(RSDataViewViewBlock)block;

@end
