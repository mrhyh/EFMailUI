//
//  RSHomeVC.m
//  Risk
//
//  Created by ylgwhyh on 16/6/29.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSHomeVC.h"
#import "HYBLoopScrollView.h"
#import "RSDataVC.h"
#import "RSDataView.h"
#import "RSSearchVC.h"

@interface RSHomeVC () <UISearchBarDelegate>

@property (nonatomic, strong) NSArray *carouselUrlArray;
@property (nonatomic, weak) HYBLoopScrollView *loopView; //轮播
@property (nonatomic, strong) UIView *searchView;

@end

@implementation RSHomeVC {
    
    //搜索栏
    UISearchBar * _searchBar;
    KYMHButton  * cancelBtn;
    CGFloat spaceToLeft;
    CGFloat dataViewToLeft;
    CGFloat dataViewToDataViewSpace;
    CGFloat dataViewToTopView;
    CGFloat dataViewW;
    CGFloat dataViewH;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:NO];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self.loopView startTimer];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [self.loopView pauseTimer];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];

}

- (void) initData {
    _carouselUrlArray = @[@"http://img.blog.csdn.net/20160629171851387",
                          @"http://img.blog.csdn.net/20160629171900216",
                          @"http://img.blog.csdn.net/20160629171908137"
                          ];
    spaceToLeft = 20;
    dataViewToLeft = 60;
    dataViewToDataViewSpace = 20;
    dataViewW = (SCREEN_WIDTH-2*dataViewToLeft-2*dataViewToDataViewSpace)/3;
    dataViewToTopView = 50;
    dataViewH = 290;
}

- (void) initUI {
    
    [self initCarouselView];
    [self initSearchView];
    [self initDataView];

}

- (void) initDataView {
    
    CGFloat dataViewY = dataViewToTopView + CGRectGetMaxY(_loopView.frame);
    
    UIView *oneDataView = [self returnDataViewWithFrame:CGRectMake(dataViewToLeft, dataViewY, dataViewW, dataViewH)];
    oneDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:oneDataView];
    
    UIView *twoDataView = [self returnDataViewWithFrame:CGRectMake(CGRectGetMaxX(oneDataView.frame) + dataViewToDataViewSpace, dataViewY , dataViewW, dataViewH)];
    twoDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:twoDataView];
    
    UIView *threeDataView = [self returnDataViewWithFrame:CGRectMake(CGRectGetMaxX(twoDataView.frame) + dataViewToDataViewSpace,  dataViewY, dataViewW, dataViewH)];
    threeDataView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:threeDataView];
    
}

- (UIView *)returnDataViewWithFrame:(CGRect)frame {
    
    UIView *dataSegmentView  = [[UIView alloc] initWithFrame:frame];

     WS(weakSelf)
    
    KYMHLabel *staticLabel = [[KYMHLabel alloc] initWithTitle:@"精品资料" BaseSize:CGRectMake(spaceToLeft, 15, 150, 20) LabelColor:nil LabelFont:normalFontSize LabelTitleColor:[UIColor redColor] TextAlignment:NSTextAlignmentLeft];
    [staticLabel FontWeight:10];
    [dataSegmentView addSubview:staticLabel];
    
    RiskDataModel *model = [[RiskDataModel alloc] init];
    model.titleString = @"【基础知识】剖宫产术后阴道分娩的评估与测试等等撒的发生阿斯蒂芬接口阿萨德风口浪尖阿萨德练腹肌";
    model.contentString = @"剖宫产术是产科保障母儿安全的重要手段，但高剖宫产术带来了一些母儿健康的相关问题...";
    model.readNumberInteger = 33;
    model.memorySizeFloat = 197.65;
    model.imageUrlString = @"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1467620731&di=cd9baa6bbbd5eb4b11311f26175fd420&src=http://pic6.wed114.cn/20140907/2014090711522716.jpg";
    
    CGFloat dataViewCellH = 130;
    
    RSDataView *oneView  = [[RSDataView alloc] initWithFrame:CGRectMake(0, 40, dataViewW, dataViewCellH) dataModel:model SelectBlock:^(BOOL isSelected) {
        RSDataVC *next = [[RSDataVC alloc] init];
        [weakSelf.navigationController pushViewController:next animated:YES];
    }];
    oneView.model = model;
    [dataSegmentView addSubview:oneView];
    
    RSDataView *twoView  = [[RSDataView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(oneView.frame), dataViewW, dataViewCellH) dataModel:model SelectBlock:^(BOOL isSelected) {
        RSDataVC *next = [[RSDataVC alloc] init];
        [weakSelf.navigationController pushViewController:next animated:YES];
    }];
    twoView.model = model;

    [dataSegmentView addSubview:twoView];
    
    twoView.topLineView.sd_layout
    .widthIs(dataViewW-15);
    
    return dataSegmentView;
}


- (void) initSearchView {
    
    CGFloat searchViewToLeft = 115;
    CGFloat searchViewH = 48;
    _searchView = [UIView new];
    _searchView.backgroundColor = [UIColor whiteColor];
    _searchView.layer.cornerRadius = 5;
    [_loopView addSubview:_searchView];
    
    
    _searchView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchViewClick)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [_searchView addGestureRecognizer:tapGesture];
    
    
    KYMHImageView *searchImage = [KYMHImageView new];
    searchImage.image = Img(@"tabbar_search");
    [_searchView addSubview:searchImage];
    
    KYMHLabel *searchLabel = [KYMHLabel new];
    searchLabel.font = Font(normalFontSize);
    searchLabel.textColor = EF_TextColor_TextColorSecondary;
    searchLabel.text = @"如: 阿司匹林、ASPL ";
    searchLabel.textAlignment = NSTextAlignmentLeft;
    [_searchView addSubview:searchLabel];
    
    _searchView.sd_layout
    .bottomSpaceToView(_loopView, 40)
    .leftSpaceToView(_loopView, searchViewToLeft)
    .rightSpaceToView (_loopView, searchViewToLeft)
    .heightIs(searchViewH);
    
    searchImage.sd_layout
    .centerYEqualToView(_searchView)
    .leftSpaceToView(_searchView, 30)
    .widthIs(25)
    .heightIs(25);
    
    searchLabel.sd_layout
    .centerYEqualToView(_searchView)
    .leftSpaceToView(searchImage, 15)
    .heightIs(25)
    .widthIs(300);
}

- (void) initCarouselView {
    
    NSTimeInterval timeInterval =2.0;
    _loopView = [HYBLoopScrollView loopScrollViewWithFrame:CGRectMake(0, -10, SCREEN_WIDTH, (SCREEN_HEIGHT-49)/2-20) imageUrls:_carouselUrlArray timeInterval:timeInterval didSelect:^(NSInteger atIndex) {
        NSLog(@"点击轮播%ld",(long)atIndex);
        RSDataVC *next = [[RSDataVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
        
        
    } didScroll:^(NSInteger toIndex) {
        ;
    }];
    [self.view addSubview:_loopView];
}


#pragma mark 手势事件

- (void) searchViewClick {
    RSSearchVC *next = [[RSSearchVC alloc] init];
    
    UINavigationController *searchNC = [[UINavigationController alloc] initWithRootViewController: next];
    [self.navigationController presentViewController:searchNC animated:YES completion:^{
        
    }];
    

}
@end


