//
//  EFGoodsTwoCell.h
//  EF_MallDemo
//
//  Created by ylgwhyh on 16/6/14.
//  Copyright © 2016年 MH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EFGoodModel.h"

@protocol EFGoodsTwoCellDelegate <NSObject>

@optional
- (void)rightPayment;

@end
@interface EFGoodsTwoCell : UITableViewCell

@property (nonatomic, strong) UIView *bottomLineView;

@property (nonatomic, strong) EFGoodModel *goodModel;
@property (nonatomic, weak) id<EFGoodsTwoCellDelegate> delegate;
@end
