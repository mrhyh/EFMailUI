//
//  EFOrderDetailVC.m
//  EF_MallDemo
//
//  Created by ylgwhyh on 16/6/14.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFOrderDetailTwoVC.h"
#import "EFGoodModel.h"
#import "EFGoodsCell.h"
#import "EFGoodsTwoCell.h"
#import "EFOrderStatusCell.h"
#import "EFMallDetailsStoreCell.h"
#import "EFOrderInfoCell.h"
#import "EFOrderDetailTwoCell.h"

@interface EFOrderDetailTwoVC () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) KYTableView *tableView;
@property (nonatomic, strong) UIColor *mainBGColor;


@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *orderinfoLeftArray;
@property (nonatomic, strong) NSArray *orderinfoRightArray;

@property (nonatomic, strong) UIView *topView;

@end

@implementation EFOrderDetailTwoVC {
    
    CGFloat segmentH;
    CGFloat spaceToLeft;
    CGFloat sectionViewH;
    CGFloat sectionImageH;
    CGFloat sectionFontSize;
}

typedef NS_ENUM(NSInteger, EFOrderDetailVCSectionNS_ENUM) {
    EFOrderDetailVCSectionNS_ENUM_OrderStatus=0,
    EFOrderDetailVCSectionNS_ENUM_GoodInfo,
    EFOrderDetailVCSectionNS_ENUM_Business,
    EFOrderDetailVCSectionNS_ENUM_OrderInfo,
    EFOrderDetailVCSectionNS_ENUM_GoodStatus
};

static NSString * const OrderCell = @"EFOrderDetailTwoVCGoodCell";
static NSString * const OrderCellEFGoodsTwoCell = @"EFOrderDetailTwoVCEFGoodsTwoCell";
static NSString * const EFOrderDetailTwoVCStatusCellEFGoodsTwoCell = @"EFOrderDetailTwoVCEFOrderStatusCellEFGoodsTwoCell";
static NSString * const EFMallDetailsStoreCellEFGoodsTwoCell = @"EFOrderDetailTwoVCEFMallDetailsStoreCellEFGoodsTwoCell";
static NSString * const OrderInfoCellEFGoodsTwoCell = @"EFOrderDetailTwoVCOrderInfoCellEFGoodsTwoCell";
static NSString * const GoodStatusCellEFGoodsTwoCell = @"EFOrderDetailTwoVCGoodStatusCellEFGoodsTwoCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    self.view.backgroundColor = RGBColor(239, 244, 248);
    self.automaticallyAdjustsScrollViewInsets = NO;
    _mainBGColor = EF_MainColor;
    
    [self initDataSource];
    [self createUITableView];
    // Do any additional setup after loading the view.
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
    }
    for (int j=0; j<5; j++){
        [_dataSource addObject:tempArray];
    }
    
    _nameArray = @[@"消费码",@"商品信息", @"商家", @"订单信息", @" "];
    _orderinfoLeftArray = @[@"联系人",@"联系电话", @"寄送地址", @"支付方式", @"下单时间 "];
    _orderinfoRightArray = @[@"何鸠",@"186-9019-3064", @"成都市武侯区玉林七巷18号1单元507室", @"我的钱包", @"2016-06-07 10:28"];

}

- (KYTableView *)createUITableView{
    
    WS(weakSelf)
    if (!_tableView) {
        _tableView = [[KYTableView alloc]initWithFrame:CGRectMake(0, 11+64, SCREEN_WIDTH, SCREEN_HEIGHT-11-64) andUpBlock:^{
            [weakSelf.tableView endLoading];
        } andDownBlock:^{
            [weakSelf.tableView endLoading];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[EFGoodsCell class] forCellReuseIdentifier:OrderCell];
        [_tableView registerClass:[EFOrderDetailTwoCell class] forCellReuseIdentifier:OrderCellEFGoodsTwoCell];
        [_tableView registerClass:[EFOrderStatusCell class] forCellReuseIdentifier:EFOrderDetailTwoVCStatusCellEFGoodsTwoCell];
        [_tableView registerClass:[EFMallDetailsStoreCell class] forCellReuseIdentifier:EFMallDetailsStoreCellEFGoodsTwoCell];
        [_tableView registerClass:[EFOrderInfoCell class] forCellReuseIdentifier:OrderInfoCellEFGoodsTwoCell];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark - Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_OrderStatus) {
    static NSString * const sectionOneCell = @"EFOrderDetailTwoVCEFO15234rderStatusCellEFGoodsTwoCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:sectionOneCell];
        if(!cell){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:sectionOneCell];
        }
        
        
        CGFloat topViewH = 60;
        if(_topView== nil) {
            _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topViewH)];
            [cell addSubview:_topView];
            
            KYMHLabel *consumeCodeLabel = [KYMHLabel new];
            consumeCodeLabel.textColor = EF_MainColor;
            consumeCodeLabel.textAlignment = NSTextAlignmentLeft;
            consumeCodeLabel.font = Font(14);
            [_topView addSubview:consumeCodeLabel];
            
            KYMHLabel *useStatusLabel = [KYMHLabel new];
            useStatusLabel.textColor = EF_TextColor_TextColorSecondary;
            useStatusLabel.font = Font(14);
            useStatusLabel.textAlignment = NSTextAlignmentRight;
            [_topView addSubview:useStatusLabel];
            
            UIView *bottomView = [UIView new];
            bottomView.backgroundColor = RGBColor(239, 244, 248);
            [_topView addSubview:bottomView];
            
            //更新数据
            consumeCodeLabel.text = @"6000201608091019";
            useStatusLabel.text = @"未使用";
            
            //布局
            CGFloat labelH = 20;
            CGFloat bottomViewH = 10;
            CGFloat topSpace = (topViewH-labelH-bottomViewH)/2;
            consumeCodeLabel.sd_layout
            .leftSpaceToView (_topView, spaceToLeft)
            .topSpaceToView (_topView, topSpace)
            .heightIs(labelH);
            [consumeCodeLabel setSingleLineAutoResizeWithMaxWidth:SCREEN_WIDTH/3*2];
            
            useStatusLabel.sd_layout
            .rightSpaceToView (_topView, spaceToLeft)
            .topSpaceToView (_topView, topSpace)
            .heightIs(labelH)
            .widthIs(70);
            
            bottomView.sd_layout
            .bottomSpaceToView (_topView, 0)
            .widthIs(SCREEN_WIDTH)
            .heightIs(bottomViewH);
        }
        

         return cell;
        
    }else if (indexPath.section == EFOrderDetailVCSectionNS_ENUM_GoodInfo) {
        NSMutableArray *sectionArray = _dataSource[indexPath.row];
        if(indexPath.row+1 != sectionArray.count) {
            EFGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCell];
            EFGoodModel *goodModel = _dataSource[indexPath.row];
            cell.goodModel = goodModel;
            return cell;
        }else {
            EFOrderDetailTwoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderCellEFGoodsTwoCell];
            EFGoodModel *goodModel = _dataSource[indexPath.row];
            cell.goodModel = goodModel;
            return cell;
        }
    }else if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_Business) {
        EFMallDetailsStoreCell *cell = [tableView dequeueReusableCellWithIdentifier:EFMallDetailsStoreCellEFGoodsTwoCell];
        cell.indexPath = indexPath;
        if (!cell.phoneButtonClickedBlock) {
            [cell setPhoneButtonClickedBlock:^(NSIndexPath *indexPath) {
                
            }];
        }
        return cell;
    }else if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_OrderInfo) {
        EFOrderInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:OrderInfoCellEFGoodsTwoCell];
        cell.leftLabel.text = _orderinfoLeftArray[indexPath.row];
        cell.rightLabel.text = _orderinfoRightArray[indexPath.row];
        
        if(indexPath.row+1 == _orderinfoLeftArray.count) {
            cell.lineView.hidden = YES;
        }else {
            cell.lineView.hidden = NO;
        }
        return cell;
    }else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GoodStatusCellEFGoodsTwoCell];
       
        if(!cell){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:GoodStatusCellEFGoodsTwoCell];
        }
        
        CGFloat bottomViewH = 49;
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, bottomViewH)];
        [cell addSubview:bottomView];
        
        UIView *lineView = [UIView new];
        KYMHButton *goodStatusButton = [KYMHButton new];
        lineView.backgroundColor = EF_TextColor_TextColorSecondary;
        [bottomView addSubview:lineView];
        
        goodStatusButton.backgroundColor = RGBColor(25, 182, 23);
        goodStatusButton.layer.cornerRadius = 5;
        goodStatusButton.titleLabel.font = Font(14);
        [goodStatusButton setTitle:@"确认收货" forState:UIControlStateNormal];
        [bottomView addSubview:goodStatusButton];
        
        lineView.sd_layout
        .topSpaceToView(bottomView, 0)
        .widthIs(SCREEN_WIDTH)
        .heightIs(1);
        
        CGFloat spaceToTop = (bottomViewH-36)/2;
        goodStatusButton.sd_layout
        .topSpaceToView (lineView, spaceToTop)
        .rightSpaceToView(bottomView, 10)
        .widthIs (95)
        .heightIs(36);
        
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section == EFOrderDetailVCSectionNS_ENUM_OrderStatus ||
       section == EFOrderDetailVCSectionNS_ENUM_Business ||
       section == EFOrderDetailVCSectionNS_ENUM_GoodStatus ) {
        return 1;
    }else if (section == EFOrderDetailVCSectionNS_ENUM_GoodInfo) {
        NSMutableArray *sectionArray = _dataSource[section];
        return sectionArray.count;
    }else  if(section == EFOrderDetailVCSectionNS_ENUM_OrderInfo) {
        return _orderinfoLeftArray.count;
    }else {
        return 1;
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_OrderStatus) {
        return 50+10;
    }else if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_GoodInfo) {
        NSMutableArray *sectionArray = _dataSource[indexPath.row];
        if(indexPath.row+1 != sectionArray.count) {
            return 81;
        }
        return 131;
    }else if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_Business) {
        return 91;
    }else if(indexPath.section == EFOrderDetailVCSectionNS_ENUM_OrderInfo) {
        return 44;
    }else {
        return 49;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionViewH)];
    headView.backgroundColor = RGBColor(248, 249, 248);
    
    KYMHLabel *nameLabel = [KYMHLabel new];
    nameLabel.textColor = EF_TextColor_TextColorSecondary;
    nameLabel.textAlignment = NSTextAlignmentLeft;
    nameLabel.font = Font(sectionFontSize);
    
    
    KYMHLabel *timeLabel = [KYMHLabel new];
    timeLabel.textColor = EF_TextColor_TextColorSecondary;
    timeLabel.textAlignment = NSTextAlignmentRight;
    timeLabel.font = Font(sectionFontSize);
    
    [headView addSubview:timeLabel];
    [headView addSubview:nameLabel];

    
    //更新数据
    if(section < _nameArray.count){
        nameLabel.text = _nameArray[section];
    }
    if(section == EFOrderDetailVCSectionNS_ENUM_OrderStatus){
        timeLabel.text = @"有效期: 2016-10-31 23:59";
    }
    //布局
    CGFloat spaceToTop = (sectionViewH-sectionImageH)/2;

    nameLabel.sd_layout
    .leftSpaceToView(headView, spaceToLeft)
    .topSpaceToView(headView, spaceToTop)
    .heightIs(sectionImageH);
    [nameLabel setSingleLineAutoResizeWithMaxWidth:70];
    
    timeLabel.sd_layout
    .rightSpaceToView(headView, spaceToLeft)
    .topSpaceToView(headView, spaceToTop)
    .heightIs(sectionImageH);
    [timeLabel setSingleLineAutoResizeWithMaxWidth:(SCREEN_WIDTH-70-2*spaceToLeft)];
    
    return headView;
}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return sectionViewH;
}

#pragma mark scrollViewDelegate
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
