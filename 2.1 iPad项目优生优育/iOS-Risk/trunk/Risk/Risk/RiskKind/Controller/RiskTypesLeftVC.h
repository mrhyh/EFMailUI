//
//  MedicineTypesVC.h
//  Risk
//
//  Created by ylgwhyh on 16/6/30.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//  风险类别

#import <UIKit/UIKit.h>

@class RiskTypesLeftVC, RiskTypeModel;

@protocol RiskTypesLeftVCDelegate <NSObject>

@optional

- (void)riskTypesVC:(RiskTypesLeftVC *)RiskTypesVC didSelectedRiskType:(RiskTypeModel *)type;

@end

@interface RiskTypesLeftVC : UITableViewController

@property (nonatomic, weak) id <RiskTypesLeftVCDelegate > delegate;


@end
