//
//  EFShopCartVC.m
//  EF_MallDemo
//
//  Created by ylgwhyh on 16/6/15.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFShopCartVC.h"
#import "EFShopCartCell.h"
#import "EFGoodModel.h"
#import "EFShopCartHeadView.h"
#import "EFCartModel.h"

@interface EFShopCartVC () <UITableViewDataSource, UITableViewDelegate> {

    BOOL _isHasNavitationController;//是否含有导航
}

@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) KYTableView *tableView;
@property (nonatomic, strong) UIColor *mainBGColor;

@property (nonatomic, strong) KYMHButton *rightButton;


@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableArray *selectedArray;
@property (strong, nonatomic) UIButton *allSellectedButton;
@property (strong, nonatomic) UILabel *totlePriceLabel;

@property (strong, nonatomic) UIView *bottomRightView; //底部右边View
@property (strong, nonatomic) UIView *backgroundView;  //底部View
@property (strong, nonatomic) KYMHButton *deleteButton;

@property (nonatomic, assign) BOOL isMultipleSectionBool;


@end

@implementation EFShopCartVC {
    
    CGFloat segmentH;
    CGFloat spaceToLeft;
    CGFloat sectionViewH;
    CGFloat sectionImageH;
    CGFloat sectionFontSize;
    CGFloat tabBarH;
}

static NSString * const EFShopCartVC_EFShopCartCell = @"EFShopCartVC_EFShopCartCell";
#define  TAG_CartEmptyView 100

- (void)viewWillAppear:(BOOL)animated {
    
    //初始化显示状态
    _allSellectedButton.selected = NO;
    _totlePriceLabel.text = @"￥0.00";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"购物车";
    _mainBGColor = EF_MainColor;
    
    [self initDataSource];
    [self initNavigateView];
    
    if (self.dataArray.count > 0) {
        [self setupCartView];
    } else {
        [self setupCartEmptyView];
    }
    
    
    // Do any additional setup after loading the view.
}

//购物车为空时显示效果
- (void)setupCartEmptyView {
    //默认视图背景
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, tabBarH, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    backgroundView.tag = TAG_CartEmptyView;
    [self.view addSubview:backgroundView];
    
    //默认图片
    UIImageView *img = [[UIImageView alloc]initWithImage:Img(@"cart_default_bg")];
    img.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 120);
    img.bounds = CGRectMake(0, 0, 247.0/187 * 100, 100);
    [backgroundView addSubview:img];
    
    UILabel *warnLabel = [[UILabel alloc]init];
    warnLabel.center = CGPointMake(SCREEN_WIDTH/2.0, SCREEN_HEIGHT/2.0 - 10);
    warnLabel.bounds = CGRectMake(0, 0, SCREEN_WIDTH, 30);
    warnLabel.textAlignment = NSTextAlignmentCenter;
    warnLabel.text = @"购物车为空!";
    warnLabel.font = [UIFont systemFontOfSize:15];
    warnLabel.textColor = EF_TextColor_TextColorSecondary;
    [backgroundView addSubview:warnLabel];
}

-(void)creatData {
    for (int i = 0; i < 7; i++) {
        EFCartModel *model = [[EFCartModel alloc]init];
        
        model.nameStr = [NSString stringWithFormat:@"测试数据%d",i];
        model.price = @"100.00";
        model.number = 1;
        model.image = [UIImage imageNamed:@"aaa.jpg"];
        
        [self.dataArray addObject:model];
    }
}

- (void)initNavigateView{

    _rightButton= [[KYMHButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    [_rightButton addTarget:self action:@selector(rightButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [_rightButton setTitle:@"编辑" forState:UIControlStateNormal];
    [_rightButton setTitle:@"完成" forState:UIControlStateSelected];
    
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_rightButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]  initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace  target:nil action:nil];
    
    negativeSpacer.width = -10;
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barBtnItem, nil];
}



#pragma mark -- 购物车为空时的默认视图
- (void)changeView {
    
    if (self.dataArray.count > 0) {
        UIView *view = [self.view viewWithTag:TAG_CartEmptyView];
        if (view != nil) {
            [view removeFromSuperview];
        }
        
        [self setupCartView];
        
    } else {
        
        if(_backgroundView) {
             [_backgroundView removeFromSuperview];
            _backgroundView = nil;
        }
        [self.tableView removeFromSuperview];
        self.tableView = nil;
        
        [self setupCartEmptyView];
    }
}

- (void)rightButtonAction {
    _rightButton.selected = !_rightButton.selected;
    _bottomRightView.hidden = !_bottomRightView.hidden;
    _deleteButton.hidden = !_deleteButton.hidden;
}

#pragma mark --- 底部视图
- (void)setupCustomBottomView {
    
    CGFloat backgroundViewH = 49;
    
    if(_backgroundView == nil) {
        _backgroundView = [[UIView alloc]init];
        _backgroundView.frame = CGRectMake(0, SCREEN_HEIGHT - tabBarH, SCREEN_WIDTH, tabBarH);
        _backgroundView.backgroundColor = [UIColor whiteColor];
        _backgroundView.tag = TAG_CartEmptyView + 1;
        [self.view addSubview:_backgroundView];
        
        
        UIView *lineView = [[UIView alloc]init];
        lineView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1);
        lineView.backgroundColor = [UIColor lightGrayColor];
        [_backgroundView addSubview:lineView];
        
        //全选按钮
        CGFloat selectAllButtonH = 39;
        UIColor *selectAllButtonSelectTitleColor = EF_TextColor_TextColorPrimary;
        _allSellectedButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _allSellectedButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_allSellectedButton setTitle:@" 全选" forState:UIControlStateNormal];
        [_allSellectedButton setImage:Img(@"ic_pass") forState:UIControlStateNormal];
        [_allSellectedButton setImage:Img(@"ic_select") forState:UIControlStateSelected];
        [_allSellectedButton setTitleColor:selectAllButtonSelectTitleColor forState:UIControlStateNormal];
        [_allSellectedButton addTarget:self action:@selector(selectAllBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:_allSellectedButton];
        
        _bottomRightView = [UIView new];
        _bottomRightView.hidden = NO; //默认显示
        [_backgroundView addSubview:_bottomRightView];
        
        //结算确认
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor = RGBColor(207, 153, 54);
        btn.titleLabel.font = Font(17);
        [btn setTitle:@"确认" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(goToPayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [_bottomRightView addSubview:btn];
        
        KYMHLabel *staticLabel = [KYMHLabel new];
        staticLabel.textColor = EF_TextColor_TextColorSecondary;
        staticLabel.font = Font(12);
        staticLabel.textAlignment = NSTextAlignmentRight;
        staticLabel.text = @"合计 (不含运费)";
        [_bottomRightView addSubview:staticLabel];
        
        //合计
        _totlePriceLabel = [[UILabel alloc]init];
        _totlePriceLabel.font = Font(13);
        _totlePriceLabel.textAlignment = NSTextAlignmentRight;
        _totlePriceLabel.textColor = EF_TextColor_TextColorPrimary;
        _totlePriceLabel.text = @"¥0.00";
        [_bottomRightView addSubview:_totlePriceLabel];
        
        //删除
        _deleteButton = [KYMHButton new];
        _deleteButton.backgroundColor = [UIColor redColor];
        _deleteButton.titleLabel.font = Font(17);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.hidden = YES; //默认隐藏
        [_deleteButton addTarget:self action:@selector(deleteButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [_backgroundView addSubview:_deleteButton];
        
        //布局
        _allSellectedButton.sd_layout
        .leftSpaceToView(_backgroundView, 0)
        .topSpaceToView (_backgroundView, (backgroundViewH-selectAllButtonH)/2)
        .widthIs(80)
        .heightIs(selectAllButtonH);
        
        _bottomRightView.sd_layout
        .topSpaceToView(_backgroundView, 0)
        .leftSpaceToView (_allSellectedButton, 20)
        .rightSpaceToView(_backgroundView, 0)
        .heightIs(tabBarH);
        
        btn.sd_layout
        .topSpaceToView (_bottomRightView, 0)
        .rightSpaceToView (_bottomRightView, 0)
        .widthIs(123)
        .heightIs(tabBarH);
        
        staticLabel.sd_layout
        .topSpaceToView (_bottomRightView, 8)
        .rightSpaceToView (btn, 22)
        .heightIs(12)
        .widthIs(140);
        
        _totlePriceLabel.sd_layout
        .topSpaceToView (staticLabel, 7)
        .rightSpaceToView (btn, 22)
        .widthIs (140)
        .heightIs(12);
        
        _deleteButton.sd_layout
        .topSpaceToView (_backgroundView, 0)
        .rightSpaceToView (_backgroundView, 0)
        .widthIs (123)
        .heightIs(tabBarH);
    }
}

#pragma mark --- 确认选择,提交订单按钮点击事件
- (void)goToPayButtonClick:(UIButton*)button {
    if (self.selectedArray.count > 0) {
        for (EFCartModel *model in self.selectedArray) {
            NSLog(@"选择的商品>>%@>>>%ld",model,(long)model.number);
        }
    } else {
        NSLog(@"你还没有选择任何商品");
    }
    
}

- (void) initDataSource {
    
    segmentH = 40;
    spaceToLeft = 10;
    sectionViewH = 30;
    sectionImageH = 17;
    sectionFontSize = 13;
    tabBarH = 49;
    
    _isMultipleSectionBool = [[[NSDictionary alloc] initWithContentsOfFile:self.plistPath][@"Mall"][@"isMultipleSection"] boolValue];
    
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
    
    [self creatData];
    [self changeView];
}

- (void)setupCartView {
    [self createUITableView];
}

- (KYTableView *)createUITableView{
    
    //创建底部视图
    [self setupCustomBottomView];

    WS(weakSelf)
    if (!_tableView) {
        _tableView = [[KYTableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49) andUpBlock:^{
            [weakSelf.tableView endLoading];
        } andDownBlock:^{
            [weakSelf.tableView endLoading];
        }];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = RGBColor(237, 243, 248);
        [_tableView registerClass:[EFShopCartCell class] forCellReuseIdentifier:EFShopCartVC_EFShopCartCell];
        [self.view addSubview:_tableView];
        
    }
    return _tableView;
}

#pragma mark --- Table view data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    EFShopCartCell *cell = [tableView dequeueReusableCellWithIdentifier:EFShopCartVC_EFShopCartCell];
    EFCartModel *model = self.dataArray[indexPath.row];
    __block typeof(cell)wsCell = cell;
    
    [cell EFNumberAddWithBlock:^(NSInteger number) {
        wsCell.efNumber = number;
        model.number = number;
        
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
    }];
    
    [cell EFNumberCutWithBlock:^(NSInteger number) {
        
        wsCell.efNumber = number;
        model.number = number;
        
        [self.dataArray replaceObjectAtIndex:indexPath.row withObject:model];
        
        //判断已选择数组里有无该对象,有就删除  重新添加
        if ([self.selectedArray containsObject:model]) {
            [self.selectedArray removeObject:model];
            [self.selectedArray addObject:model];
            [self countPrice];
        }
    }];
    
    [cell EFCellSelectedWithBlock:^(BOOL select) {
        
        model.select = select;
        if (select) {
            [self.selectedArray addObject:model];
        } else {
            [self.selectedArray removeObject:model];
        }
        
        if (self.selectedArray.count == self.dataArray.count) {
            _allSellectedButton.selected = YES;
        } else {
            _allSellectedButton.selected = NO;
        }
        
        [self countPrice];
    }];
    
    [cell EFReloadDataWithModel:model];
    return cell;
}


-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"确定要删除该商品?删除后无法恢复!" preferredStyle:1];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            EFCartModel *model = [self.dataArray objectAtIndex:indexPath.row];
            
            [self.dataArray removeObjectAtIndex:indexPath.row];
            //删除
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            //判断删除的商品是否已选择
            if ([self.selectedArray containsObject:model]) {
                //从已选中删除,重新计算价格
                [self.selectedArray removeObject:model];
                [self countPrice];
            }
            
            if (self.selectedArray.count == self.dataArray.count) {
                _allSellectedButton.selected = YES;
            } else {
                _allSellectedButton.selected = NO;
            }
            
            if (self.dataArray.count == 0) {
                [self changeView];
            }
            
            [_tableView reloadData];
            
        }];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        
        [alert addAction:okAction];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    if( _isMultipleSectionBool == NO) {
        return 1;
    } else {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 96;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(_isMultipleSectionBool == NO ) {
        return nil;
    } else {
        
        EFShopCartHeadView *headView  =  [[EFShopCartHeadView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, sectionViewH) andSelectBlock:^(NSInteger objectId) {
        }];
        [headView EFShopCartHeadViewSelectedWithBlock:^(BOOL isSelected) {
#warning TODO 将一个section的区域都加入被选
            /*
             EFCartModel *model = self.dataArray[indexPath.row];
             model.select = select;
             if (select) {
             [self.selectedArray addObject:model];
             } else {
             [self.selectedArray removeObject:model];
             }
             
             if (self.selectedArray.count == self.dataArray.count) {
             _allSellectedButton.selected = YES;
             } else {
             _allSellectedButton.selected = NO;
             }
             
             [self countPrice];
             */
        }];
        
        return headView;
    }
    
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    if(_isMultipleSectionBool == NO){
        return nil;
        
    } else {
        
        if(section+1 == self.dataArray.count) { //最后一个section
            return nil;
        }else {
            UIView *sectionFootView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 8)];
            sectionFootView.backgroundColor = RGBColor(238, 244, 249);
            return sectionFootView;
        }
    }

}

-(CGFloat )tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if(_isMultipleSectionBool == NO ) {
        return 0.0001;
    } else {
         return sectionViewH;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if(_isMultipleSectionBool == NO ) {
        return 0.0001;
        
    } else {
        
        if(section+1 == self.dataArray.count) { //最后一个section
            return 0.0001;
        }else {
            return 8;
        }
    }

}


- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (void)reloadTable {
    [self.tableView reloadData];
}



#pragma mark --- 页面按钮点击事件
#pragma mark --- 返回按钮点击事件
- (void)backButtonClick:(UIButton*)button {
    if (_isHasNavitationController == NO) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --- 全选按钮点击事件
- (void)selectAllBtnClick:(UIButton*)button {
    button.selected = !button.selected;
    
    //点击全选时,把之前已选择的全部删除
    for (EFCartModel *model in self.selectedArray) {
        model.select = NO;
    }
    [self.selectedArray removeAllObjects];
    
    if (button.selected) {
        
        for (EFCartModel *model in self.dataArray) {
            model.select = YES;
            [self.selectedArray addObject:model];
        }
    }
    
    [self.tableView reloadData];
    [self countPrice];
}


#pragma mark --- 删除按钮事件
- (void) deleteButtonAction {
   
    [self.dataArray removeObjectsInArray:self.selectedArray];
    [self.selectedArray removeAllObjects];
    [self changeView];
    [_tableView reloadData];
    [self countPrice];
}

#pragma mark --- 计算已选中商品金额
-(void)countPrice {
    double totlePrice = 0.0;

    for (EFCartModel *model in self.selectedArray) {
        double price = [model.price doubleValue];
        totlePrice += price*model.number;
    }
    NSString *string = [NSString stringWithFormat:@"￥%.2f",totlePrice];
    self.totlePriceLabel.text = string;
}



#pragma mark --- 初始化数组
- (NSMutableArray *)dataArray {
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSMutableArray *)selectedArray {
    if (_selectedArray == nil) {
        _selectedArray = [NSMutableArray array];
    }
    return _selectedArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
