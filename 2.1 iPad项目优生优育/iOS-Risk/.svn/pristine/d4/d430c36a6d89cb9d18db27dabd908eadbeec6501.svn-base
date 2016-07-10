//
//  RiskTypeFDALeftTwoVC.h
//  Risk
//
//  Created by ylgwhyh on 16/7/5.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "EFBaseViewController.h"
#import "RiskTypeModel.h"

@class RiskTypeFDALeftTwoVC,RiskTypeModel;

@protocol RiskTypeFDALeftTwoVCDelegate <NSObject>

- (void)RiskTypeFDALeftTwoVC:(RiskTypeFDALeftTwoVC *)RiskTypeFDALeftTwoVC didSelectedRiskTypeFDALeftTwoVC:(RiskTypeModel *)model;

@end

@interface RiskTypeFDALeftTwoVC : UITableViewController

@property (nonatomic, strong) RiskTypeModel *typeModel;
@property (nonatomic, assign) BOOL isHideNavigationTitleLabelBOOL;

@property (nonatomic, weak) id <RiskTypeFDALeftTwoVCDelegate > delegate;

@end
