//
//  EF_MyOrderVC.m
//  EF_MallDemo
//
//  Created by ylgwhyh on 16/6/13.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFMyOrderVC.h"
#import "YJSegmentedControl.h"
#import "EFGoodsCell.h"
#import "EFGoodModel.h"
#import "EFGoodsTwoCell.h"
#import "EFOrderDetailVC.h"
#import "EFOrderDetailTwoVC.h"
#import "EFOrderConfirmVC.h"


typedef NS_ENUM(NSInteger, EF_MyOrderVC_NS_ENUM) {
    EF_MyOrderVC_NS_ENUM_All = 0,
    EF_MyOrderVC_NS_ENUM_NoPayment = 1,
    EF_MyOrderVC_NS_ENUM_NoGetGood = 2,
    EF_MyOrderVC_NS_ENUM_NoAppraise = 3
};

@interface EFMyOrderVC()  <YJSegmentedControlDelegate, UITableViewDataSource, UITableViewDelegate,EFGoodsTwoCellDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) KYTableView *tableView;

@property (nonatomic, strong) UIColor *mainBGColor;

@property (nonatomic, strong)  UIImageView *navBarHairlineImageView;

@end

@implementation EFMyOrderVC {
    CGFloat segmentH;
    CGFloat spaceToLeft;
    CGFloat sectionViewH;
    CGFloat sectionImageH;
    CGFloat sectionFontSize;
}

static NSString * const OrderCell = @"EFMyOrderVCGoodCell";
static NSString * const OrderCellEFGoodsTwoCell = @"EFGoodsTwoCell";

-(void)viewWillAppear:(BOOL)animated {
    _navBarHairlineImageView.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    _navBarHairlineImageView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
     _mainBGColor = EF_MainColor;
    
    //再定义一个imageview来等同于这个黑线
    _navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    _navBarHairlineImageView.image = [UIImage imageWithColor:_mainBGColor];
    
    [self initDataSource];
    [self createUISegmentedControl];
    [self createUITableView];
}

//通过一个方法来找到这个黑线(findHairlineImageViewUnder):
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void) initDataSource {
    segmentH = 40;
    spaceToLeft = 10;
    sectionViewH = 30;
    sectionImageH = 17;
    sectionFontSize = 13;
    
    _dataSource = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i=0; i<3; i++) {
        EFGoodModel *goodModel = [EFGoodModel new];
        goodModel.imageString = @"http://static.adzerk.net/Advertisers/9e442287f4324f77b4b3d8f8b4a7be58.png";
        goodModel.goodNameString = @"Lebond 电动牙刷三合一";
        goodModel.goodPriceInt  = 599;
        goodModel.goodNumInt = 1;
        goodModel.goodSumInt = 928;
        [tempArray addObject:goodModel];
#warning  TODO 是否支付、确认收货等等数据未添加，根据服务端确认
    }
    
    for (int j=0; j<5; j++){
          [_dataSource addObject:tempArray];
    }
   
}

- (void)createUISegmentedControl{

    NSArray * btnDataSource = @[@"全部", @"待支付", @"待收货", @"待评价"];
    YJSegmentedControl * segment = [YJSegmentedControl segmentedControlFrame:CGRectMake(0, 64, self.view.bounds.size.width, segmentH) titleDataSource:btnDataSource backgroundColor:_mainBGColor titleColor:[UIColor whiteColor] titleFont:[UIFont fontWithName:@".Helvetica Neue Interface" size:16.0f] selectColor:[UIColor whiteColor] buttonDownColor:[UIColor whiteColor] Delegate:self];
    [self.view addSubview:segment];

}

- (KYTableView *)createUITableView{
    
    WS(weakSelf)
    if (!_tableView) {
        _tableView = [[KYTableView alloc]initWithFrame:CGRectMake(0, 64+segmentH, SCREEN_WIDTH, SCREEN_HEIGHT-segmentH-64) andUpBlock:^{
             [weakSelf.tableView endLoading];
        } andDownBlock:^{
            [weakSelf.tableView endLoading];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[EFGoodsCell class] forCellReuseIdentifier:OrderCell];
        [_tableView registerClass:[EFGoodsTwoCell class] forCellReuseIdentifier:OrderCellEFGoodsTwoCell];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark -- SegmentedControlDelegate
- (void)segumentSelectionChange:(NSInteger)selection{
    if (selection == EF_MyOrderVC_NS_ENUM_All) {
        NSLog(@"全部");
    }else if (selection == EF_MyOrderVC_NS_ENUM_NoPayment){
        NSLog(@"待支付");
    }else if(selection == EF_MyOrderVC_NS_ENUM_NoGetGood){
        NSLog(@"待收货");
    }else {
        NSLog(@"待评价");
    }
    [self Refreshing:selection];
    
    //这里更新tableView的数据并重新刷新界面
    [self.tableView reloadData];
}

//下拉刷新,上拉加载
- (void)Refreshing:(NSInteger )type{
    
    //上拉刷新
//    _ta.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        self.number = 0;
//        [self RequestData:type];
//        NSLog(@"=== 点击 “%@” ", type);
//        [_listView.mj_header endRefreshing];
//    }];
//    [_listView.mj_header beginRefreshing];
    
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *sectionArray = _dataSource[indexPath.row];
    if(indexPath.row+1 != sectionArray.count) {
        EFGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCell];
        EFGoodModel *goodModel = _dataSource[indexPath.row];
        cell.goodModel = goodModel;
        return cell;
    }else {
        EFGoodsTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellEFGoodsTwoCell];
        cell.delegate = self;
        EFGoodModel *goodModel = _dataSource[indexPath.row];
        cell.goodModel = goodModel;
        
        if(indexPath.section+1 == self.dataSource.count) {  //最后一条，用于底部分割的lineView要隐藏.
            cell.bottomLineView.hidden = YES;
        }else {
            cell.bottomLineView.hidden = NO;
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSMutableArray *sectionArray = _dataSource[section];
    return sectionArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *sectionArray = _dataSource[indexPath.row];
    if(indexPath.row+1 != sectionArray.count) {
        return 81;
    }
    
    return 174;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionViewH)];
    headView.backgroundColor = RGBColor(248, 249, 248);
    
    KYMHImageView *imageView = [KYMHImageView new];
    
    KYMHLabel *nameLabel = [KYMHLabel new];
    nameLabel.textColor = EF_TextColor_TextColorPrimary;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = Font(sectionFontSize);
    
    
    KYMHImageView *indicatorImageView = [KYMHImageView new];
    
    KYMHLabel *tradeStateLabel = [KYMHLabel new];
    tradeStateLabel.textColor = EF_TextColor_TextColorSecondary;
    tradeStateLabel.textAlignment = NSTextAlignmentRight;
    tradeStateLabel.font = Font(sectionFontSize);
    
    [headView addSubview:imageView];
    [headView addSubview:nameLabel];
    [headView addSubview:indicatorImageView];
    [headView addSubview:tradeStateLabel];
    
    
    //更新数据
    imageView.image = Img(@"");
    imageView.backgroundColor = [UIColor grayColor];
    nameLabel.text = @"仁恒美光牙科";
    indicatorImageView.image = Img(@"");
    indicatorImageView.backgroundColor = [UIColor grayColor];
    tradeStateLabel.text = @"待支付";
    
    //布局
    CGFloat spaceToTop = (sectionViewH-sectionImageH)/2;
    imageView.sd_layout
    .leftSpaceToView(headView, spaceToLeft)
    .topSpaceToView(headView, spaceToTop)
    .widthIs(sectionImageH)
    .heightIs(sectionImageH);
    
    nameLabel.sd_layout
    .leftSpaceToView(imageView, spaceToLeft)
    .topSpaceToView(headView, spaceToTop)
    .heightIs(sectionImageH);
     [nameLabel setSingleLineAutoResizeWithMaxWidth:200];
    
    indicatorImageView.sd_layout
    .leftSpaceToView(nameLabel, spaceToLeft)
    .topSpaceToView(headView, spaceToTop)
    .widthIs(sectionImageH)
    .heightIs(sectionImageH);

    tradeStateLabel.sd_layout
    .rightSpaceToView(headView, spaceToLeft)
    .topSpaceToView(headView, spaceToTop)
    .heightIs(sectionImageH);
    [tradeStateLabel setSingleLineAutoResizeWithMaxWidth:50];

    return headView;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return sectionViewH;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == 0) {
        EFOrderDetailTwoVC *next = [[EFOrderDetailTwoVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }else {
        EFOrderDetailVC *next = [[EFOrderDetailVC alloc] init];
        [self.navigationController pushViewController:next animated:YES];
    }
}

#pragma mark --- EFGoodsTwoCellDelegate
- (void)rightPayment{
    EFOrderConfirmVC *confirmVC = [[EFOrderConfirmVC alloc] init];
    [self.navigationController pushViewController:confirmVC animated:YES];
}

#pragma mark scrollViewDelegate
/*
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView == self.tableView) {
        CGFloat sectionHeaderHeight = sectionViewH;
        if (scrollView.contentOffset.y <= sectionHeaderHeight && scrollView.contentOffset.y >= 0) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
            
        } else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
            
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
            
        }
    }
}
 */

@end

