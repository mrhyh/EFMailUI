//
//  EFShopCartHeadView.h
//  EF_MallDemo
//
//  Created by ylgwhyh on 16/6/15.
//  Copyright © 2016年 MH. All rights reserved.
//

#import <UIKit/UIKit.h>

#if NS_BLOCKS_AVAILABLE

typedef void (^EFShopCartHeadViewBlock)(NSInteger objectId);
typedef void (^EFShopCartHeadViewSelectedBlock)(BOOL isSelected);

#endif

@interface EFShopCartHeadView : UIView{


    __strong EFShopCartHeadViewBlock callBack;
}

@property (nonatomic, strong) KYMHButton *button;
@property (nonatomic, strong) KYMHLabel *nameLabel;
@property (nonatomic, strong) KYMHImageView *indicatorImageView;


- (instancetype)initWithFrame:(CGRect)frame andSelectBlock:(EFShopCartHeadViewBlock)block;

- (void)EFShopCartHeadViewSelectedWithBlock:(EFShopCartHeadViewSelectedBlock)block;
@end
