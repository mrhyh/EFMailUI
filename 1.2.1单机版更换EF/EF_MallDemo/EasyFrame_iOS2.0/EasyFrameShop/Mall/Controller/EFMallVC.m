//
//  EFMallVC.m
//  EF_MallDemo
//
//  Created by MH on 16/6/13.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFMallVC.h"
#import "EFMyOrderVC.h"
#import "EFMallCell.h"
#import "EFCarousel.h"
#import "EFCarouselObject.h"
#import "EFSelectView.h"
#define SDEFMallCell @"EFMallCell"
#import "EFMallDetailsVC.h"
#import "EFSearchVC.h"
#import "EFShopCartVC.h"
@interface EFMallVC ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic)KYTableView * table;

@property (nonatomic,strong)KYMHButton * orderBT;
@property (nonatomic,strong)KYMHButton * shoppingCartBT;
@property (nonatomic,assign)BOOL isLocation;
@property (nonatomic,assign)BOOL isAD;
@property (nonatomic,strong)NSArray * listArray;
@property (assign, nonatomic) int pageCount;
@property (nonatomic,strong)EFSelectView  * m_view;
@property (nonatomic,strong)NSString* m_objectId;
@property (nonatomic,strong)UIView * m_coverView;
@property (assign, nonatomic) float selectH;
@end

@implementation EFMallVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = EF_MainColor;
    //设置title颜色
    UIColor * color = EF_TextColor_TextColorNavigation;
    self.navigationController.navigationBar.tintColor = color;
    if (CurrentSystemVersion > 8.2) {
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17 weight:UIFontWeightMedium],NSForegroundColorAttributeName:color}];
    }else{
        [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:color}];
    }
    self.title = @"商城";
    self.view.backgroundColor = EF_BGColor_Primary;
    NSString *plistPath = nil;
    plistPath = [[NSBundle mainBundle] pathForResource:@"EasyFrame_" ofType:@"plist"];
    //如果没有创建EasyFrame_.plist文件，那么直接加载框架内部自带的
    if (plistPath == nil) {
        plistPath = [[NSBundle mainBundle] pathForResource:@"EasyFrame" ofType:@"plist"];
    }
    _isLocation = [[[NSDictionary alloc] initWithContentsOfFile:plistPath][@"Mall"][@"isLocation"] boolValue];
    _isAD = [[[NSDictionary alloc] initWithContentsOfFile:plistPath][@"Mall"][@"isAD"] boolValue];
    _listArray = [[NSDictionary alloc] initWithContentsOfFile:plistPath][@"Mall"][@"ListArray"];
    if (_isLocation) {
        self.navigationItem.leftBarButtonItem = [UIUtil barButtonItem:self WithTitle:@"定位" withImage:nil withBlock:^{
            
        } isLeft:YES];
    }
    
    WS(weakSelf)
    self.navigationItem.rightBarButtonItem = [UIUtil barButtonItem:self WithTitle:@"" withImage:Img(@"nav_search") withBlock:^{
        
        EFSearchVC *next = [[EFSearchVC alloc] init];
        [weakSelf.navigationController pushViewController:next animated:YES];
        
        
    } isLeft:NO];
    
    _table = [[KYTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) andUpBlock:^{
        [_table endLoading];
    } andDownBlock:^{
        [_table endLoading];
    }];
    [self.view addSubview:_table];
    _table.dataSource = self;
    _table.delegate = self;
    _table.backgroundColor = EF_BGColor_Primary;
    _table.separatorStyle = UITableViewCellAccessoryNone;
    [_table registerClass:[EFMallCell class] forCellReuseIdentifier:SDEFMallCell];
    [_table reloadData];
    
    
    _orderBT = [KYMHButton new];
    _orderBT.titleLabel.font = [UIFont systemFontOfSize:13];
    _orderBT.backgroundColor = EF_MainColor;
    [_orderBT setTitle:@"我的订单" forState:0];
    [_orderBT setTitleColor:[UIColor whiteColor] forState:0];
    [_orderBT RectSize:30 SideWidth:0 SideColor:nil];
    [_orderBT addTarget:self action:@selector(orderButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_orderBT];
    
    _shoppingCartBT = [KYMHButton new];
    _shoppingCartBT.titleLabel.font = [UIFont systemFontOfSize:13];
    [_shoppingCartBT setTitleColor:[UIColor whiteColor] forState:0];
    _shoppingCartBT.backgroundColor = EF_MainColor;
    [_shoppingCartBT setTitle:@"购物车" forState:0];
    [_shoppingCartBT RectSize:30 SideWidth:0 SideColor:nil];
    [_shoppingCartBT addTarget:self action:@selector(shoppingCartButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_shoppingCartBT];
    _orderBT.sd_layout.rightSpaceToView(self.view,10).bottomSpaceToView(self.view,10).widthIs(60).heightIs(60);
    _shoppingCartBT.sd_layout.rightSpaceToView(self.view,10).bottomSpaceToView(_orderBT,10).widthIs(60).heightIs(60);
    
}

- (void)orderButtonClicked{
    EFMyOrderVC *next = [[EFMyOrderVC alloc] init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)shoppingCartButtonClicked{
    
    EFShopCartVC *next = [[EFShopCartVC alloc] init];
    [self.navigationController pushViewController:next animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark TableViewDelegate


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAD&&indexPath.section == 0) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineListCell"];
        EFCarouselObject *object1 = [[EFCarouselObject alloc] init];
        object1.imageURL = @"http://img10.3lian.com/c1/newpic/10/24/29.jpg";
        
        EFCarouselObject *object2 = [[EFCarouselObject alloc] init];
        object2.imageURL = @"http://d.hiphotos.baidu.com/zhidao/pic/item/eac4b74543a9822604312cf28882b9014b90eb77.jpg";
        
        EFCarouselObject *object3 = [[EFCarouselObject alloc] init];
        object3.imageURL = @"http://ww1.sinaimg.cn/large/7bb6feadgw1dv30xnokz5j.jpg";

        
        EFCarousel *carousel = [[EFCarousel alloc] init];
        carousel.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.2];
        carousel.frame = CGRectMake(0, 0, SCREEN_WIDTH, 160);
        carousel.iGCarouselSelectedBlock = ^(NSInteger index , EFCarouselObject *carouselObject){
            NSString * url = @"";
            if (carouselObject.pushURL) {
                url = carouselObject.pushURL;
            }
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        };
        
        NSArray * arr = @[object1,object2,object3];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            carousel.carouselList = arr;
            [carousel reloadCarousel];
        });
        [cell addSubview:carousel];
        
        return cell;
    }
    EFMallCell *cell = [tableView dequeueReusableCellWithIdentifier:SDEFMallCell];
    cell.indexPath = indexPath;

//    if (self.listModel.content.count>0) {
//        NewsContent * model = [NewsContent yy_modelWithDictionary:[(NSArray*)self.listModel.content objectAtIndex:indexPath.row]];
//        cell.model = model;
//    }
    
    return cell;
    
}




- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (_isAD) {
        if (section==0) {
            return 1;
        }
        return 7;
    }
    return 7;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_isAD) {
        return 2;
    }
    return 1;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    headView.backgroundColor = EF_MainColor;
    for (int i = 0; i < _listArray.count; i++) {
        KYMHButton * button = [KYMHButton new];
        [button setTitle:_listArray[i] forState:0];
        UIColor * color = EF_TextColor_TextColorNavigation;
        [button setTitleColor:color forState:0];
        [button setImage:Img(@"") forState:0];
        button.titleLabel.font = [UIFont systemFontOfSize:13];
        [headView addSubview:button];
        [button addTarget:self action:@selector(showList:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        CGFloat w = SCREEN_WIDTH/_listArray.count;
        button.sd_layout
        .leftSpaceToView(0,i*w)
        .topEqualToView(headView)
        .heightIs(40)
        .widthIs(w);
    }
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_isAD&&section==0) {
        return 0;
    }
    return 40;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAD&&indexPath.section == 0) {
        return 160;
    }
    id model;
    return 122;
////    if (self.listModel.content>0) {
////        model = [NewsContent yy_modelWithDictionary:[(NSArray*)self.listModel.content objectAtIndex:indexPath.row]];
////    }
//    return [self.table cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[EFMallCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isAD&&indexPath.section == 1) {
        EFMallDetailsVC * vc = [[EFMallDetailsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (!_isAD){
        EFMallDetailsVC * vc = [[EFMallDetailsVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}


#pragma mark 下拉列表
- (void)showList:(UIButton*)sender{
    [_m_coverView removeFromSuperview];
    _m_coverView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    [self.view addSubview:_m_coverView];
    _m_coverView.backgroundColor = [UIColor clearColor];
    _m_coverView.hidden = YES;
    
    
    UIButton * bt = [self.view viewWithTag:sender.tag];

    
    UIButton * button =[UIButton buttonWithType:UIButtonTypeCustom];
    [button addTarget:self action:@selector(touch) forControlEvents:UIControlEventTouchUpInside];
    [_m_coverView addSubview:button];
    button.frame = _m_coverView.bounds;
    
    
    _m_view = [[EFSelectView alloc]initWithFrame:CGRectMake(CGRectGetMinX(bt.frame), 200-_selectH, bt.frame.size.width, 160) ObjectId:(int)sender.tag-100 Array:nil andSelectBlock:^(NSString *objectId) {
        _m_view.hidden = YES;
        _m_coverView.hidden = YES;
        _m_objectId = objectId;
    }];
    [self.view addSubview:_m_view];
    _m_view.hidden = YES;
    
    _m_view.hidden = !_m_view.hidden;
    _m_coverView.hidden = !_m_coverView.hidden;
}
- (void)touch{
    _m_view.hidden = !_m_view.hidden;
    _m_coverView.hidden = !_m_coverView.hidden;
}


/** 正在滚动 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]]) {
        CGFloat tabOffsetY = 160;
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY<=tabOffsetY) {
            _selectH = offsetY;
        }else{
            _selectH = 160;
        }
    }
    
}


@end
