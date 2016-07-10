//
//  RSFDARightVC.m
//  Risk
//
//  Created by ylgwhyh on 16/7/5.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RiskTypeFDARightVC.h"
#import "YFViewPager.h"
#import "EFMailNS_Enum.h"
#import "RiskTypeFDARightCell.h"
#import "RiskTypeDetailVC.h"
#import "RiskFactorModel.h"
#import "RiskTypeFDALeftTwoVC.h"

typedef NS_ENUM(NSInteger, EF_MyOrderVC_NS_ENUM) {
    RiskTypeFDARightVC_ENUM_One = 0,
    RiskTypeFDARightVC_ENUM_Two = 1,
    RiskTypeFDARightVC_ENUM_Three = 2,
    RiskTypeFDARightVC_ENUM_Four = 3,
    EF_MyOrderVC_NS_ENUM_Five = 4
};

@interface RiskTypeFDARightVC () < UITableViewDataSource, UITableViewDelegate, RiskTypeFDALeftTwoVCDelegate>

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableArray *riskArray;
@property (nonatomic, strong) NSMutableArray *AllDataArray;
@property (nonatomic, strong) NSMutableArray *TwoDataArray;
@property (nonatomic, strong) NSMutableArray *ThreeDataArray;
@property (nonatomic, strong) NSMutableArray *FourDataArray;
@property (nonatomic, strong) NSMutableArray *FiveDataArray;

@property (nonatomic, strong) KYTableView *tableView;
@property (nonatomic, strong) KYTableView *twoTableView;
@property (nonatomic, strong) KYTableView *threeTableView;
@property (nonatomic, strong) KYTableView *fourTableView;
@property (nonatomic, strong) KYTableView *fiveTableView;

@property (nonatomic, strong) YFViewPager *viewPager;

@property (nonatomic, strong) UIColor *mainBGColor;

@property (nonatomic, strong) UIImageView *navBarHairlineImageView;

@property (nonatomic, strong) KYMHLabel *noDataLabel;

@property (nonatomic, assign) NSInteger orderButtonClickInteger; //记录点击的哪个选项

@end

@implementation RiskTypeFDARightVC{
    CGFloat segmentH;
    CGFloat spaceToLeft;

    CGFloat sectionImageH;
    CGFloat sectionFontSize;
    
    UIColor *canSelectColor;
    UIColor *noCanSelectColor;
}


static NSString * const RiskTypeFDARightCell_ID = @"RiskTypeFDARightCell_ID";

-(void)viewWillAppear:(BOOL)animated {
    _navBarHairlineImageView.hidden = YES;
    
    self.navigationController.navigationBar.translucent = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)viewWillDisappear:(BOOL)animated {
    _navBarHairlineImageView.hidden = NO;
    
    //还原此页Navigation的设置
    self.navigationController.navigationBar.translucent = YES;
    self.edgesForExtendedLayout = UIRectEdgeAll;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    
}


- (void) initUI {

    [self initViewPager];
    [self initLineView];
}

- (void ) initLineView {
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, segmentH+2, SCREEN_WIDTH/2, 0.5)];
    lineView.backgroundColor = EF_TextColor_TextColorSecondary;
    [self.view addSubview:lineView];
}

-(void)initViewPager {
    
    if(_tableView == nil) {
        _tableView = [self createUITableView];
//        _tableView.backgroundColor =[UIColor grayColor];
    }
    if(_twoTableView == nil) {
        _twoTableView = [self createUITableView];
//         _twoTableView.backgroundColor =[UIColor yellowColor];
    }
    if(_threeTableView == nil) {
        _threeTableView = [self createUITableView];
    }
    if(_fourTableView == nil) {
        _fourTableView = [self createUITableView];
    }
    if(_fiveTableView == nil) {
        _fiveTableView = [self createUITableView];
    }
    
    
    NSArray *titles = @[@"A", @"B", @"C", @"D", @"X"];
    
    NSArray *views = [[NSArray alloc] initWithObjects:
                      _tableView,
                      _twoTableView,
                      _threeTableView,
                      _fourTableView,
                      _fiveTableView, nil];
    
    if(_viewPager == nil ) {
        _viewPager = [[YFViewPager alloc] initWithFrame:CGRectMake(0 , 0, SCREEN_WIDTH/2 ,SCREEN_HEIGHT- segmentH-64)
                                                 titles:titles
                                                  icons:nil
                                          selectedIcons:nil
                                                  views:views];
        
        [self.view addSubview:_viewPager];
        
#pragma mark - YFViewPager 相关属性 方法
        _viewPager.showVLine = NO;
        _viewPager.tabArrowBgColor = [UIColor whiteColor];
        _viewPager.tabBgColor = [UIColor whiteColor];
        _viewPager.tabSelectedArrowBgColor = [UIColor redColor];
        _viewPager.tabSelectedBgColor = [UIColor whiteColor];
        _viewPager.tabSelectedTitleColor = RiskTypeTitleColor;
        _viewPager.tabTitleColor = RiskTypeTitleColor;
        _viewPager.bottomLineToBottomSpace = 1;
        
        [_viewPager didSelectedBlock:^(id viewPager, NSInteger index) {
            switch (index) {
                case RiskTypeFDARightVC_ENUM_One:
                {
                    NSLog(@"点击第一个菜单");
                    _orderButtonClickInteger = RiskTypeFDARightVC_ENUM_One;
                    //                    if(_AllDataArray.count == 0) {
                    //                        [self.viewModel getMyOrderList:0 Size:20 Status:@"ALL"];
                    //                    }
                    
                    //[self.viewModel getMyOrderList:0 Size:20 Status:@"ALL"];
                   // [_dataSource removeAllObjects];
                    //[_dataSource addObjectsFromArray:_AllDataArray];
                    [_tableView reloadData];
                }
                    break;
                case 1:
                {
                    NSLog(@"点击第二个菜单");
                    _orderButtonClickInteger = RiskTypeFDARightVC_ENUM_Two;
                    
                    //                    if(_TwoDataArray.count == 0) {
                    //                        [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_PAYED"];
                    //                    }
                   // [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_PAYED"];
                    //[_dataSource removeAllObjects];
                    //[_dataSource addObjectsFromArray:_TwoDataArray];
                    [_twoTableView reloadData];
                }
                    break;
                case 2:
                {
                    NSLog(@"点击第三个菜单");
                    _orderButtonClickInteger = RiskTypeFDARightVC_ENUM_Three;
                    
                    //                    if(_ThreeDataArray.count == 0) {
                    //                           [self.viewModel getMyOrderList:0 Size:20 Status:@"SHIPPED"];
                    //                    }
                   // [self.viewModel getMyOrderList:0 Size:20 Status:@"SHIPPED"];
                   // [_dataSource removeAllObjects];
                    //[_dataSource addObjectsFromArray:_ThreeDataArray];
                    [_threeTableView reloadData];
                    
                }
                    break;
                    
                case 3:
                {
                    NSLog(@"点击第四个菜单");
                    _orderButtonClickInteger = RiskTypeFDARightVC_ENUM_Four;
                    
                    //                    if(_FourDataArray.count == 0) {
                    //                         [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_COMMENTED"];
                    //                    }
                  //  [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_COMMENTED"];
                   // [_dataSource removeAllObjects];
                    //[_dataSource addObjectsFromArray:_FourDataArray];
                    [_fourTableView reloadData];
                }
                    break;
                
                case EF_MyOrderVC_NS_ENUM_Five:
                {
                    NSLog(@"点击第四个菜单");
                    _orderButtonClickInteger = EF_MyOrderVC_NS_ENUM_Five;
                    
                    //                    if(_FourDataArray.count == 0) {
                    //                         [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_COMMENTED"];
                    //                    }
                   // [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_COMMENTED"];
                   // [_dataSource removeAllObjects];
                    //[_dataSource addObjectsFromArray:_FourDataArray];
                    [_fiveTableView reloadData];
                }
            
                default:
                    break;
            }
        }];
    }
    
    if(_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_One) {
        
        [self noDataWithArray:self.dataSource tableView:_tableView];
        
    }else  if (_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Two) {
        
        [self noDataWithArray:self.dataSource tableView:_twoTableView];
        
    }else  if (_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Three) {
        
        [self noDataWithArray:self.dataSource tableView:_threeTableView];
        
    }else if ( _orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Four) {
        
        [self noDataWithArray:self.dataSource tableView:_fourTableView];
        
    }else {
        
    }
}


- (void) noDataWithArray:(NSArray *)dataArray tableView:(KYTableView *)tableView {
    
    if(dataArray.count <= 0){
        if(_noDataLabel == nil){
            _noDataLabel = [[KYMHLabel alloc] initWithTitle:@"暂无数据，下拉刷新" BaseSize:CGRectMake(0,0,SCREEN_WIDTH/2, SCREEN_H_RATE*15) LabelColor: [UIColor clearColor] LabelFont:16 LabelTitleColor:[UIColor grayColor] TextAlignment:NSTextAlignmentCenter];
            _noDataLabel.center = CGPointMake(SCREEN_WIDTH/4*3, SCREEN_HEIGHT/5*2);
            [tableView addSubview:_noDataLabel];
        }
    } else {
        if(_noDataLabel != nil) {
            [_noDataLabel removeFromSuperview];
            _noDataLabel = nil;
        }
        [tableView reloadData];
    }
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

- (void) initData {
    _dataSource = [[NSMutableArray alloc] init];
    _riskArray = [[NSMutableArray alloc] init];

    
    for (int i=0; i<11; i++)  {
        
        RiskTypeModel *model = [[RiskTypeModel alloc] init];
        model.name = @"页酸(FOLICACID) FDA分类：A";
        model.idstr = @"蝶酰谷氨酸、美天福、维生素、维生素、维生素、维生素、维生素、维生素、维生素、维生素、维生素、维生素、维生素";
        [_dataSource addObject:model];
    }


    _orderButtonClickInteger = RiskTypeFDARightVC_ENUM_One;
    segmentH = 40;
    spaceToLeft = 10;

    sectionImageH = 17;
    sectionFontSize = 13;
    
    canSelectColor = RGBColor(25, 182, 23);
    noCanSelectColor = RGBColor(175, 176, 175);
    
    _AllDataArray = [[NSMutableArray alloc] init];
    _ThreeDataArray =  [[NSMutableArray alloc] init];
    _TwoDataArray = [[NSMutableArray alloc] init];
    _FourDataArray = [[NSMutableArray alloc] init];
    _FiveDataArray =  [[NSMutableArray alloc] init];
    
    self.title = @"我的订单";
    _mainBGColor = EF_MainColor;
    
    //再定义一个imageview来等同于这个黑线（去掉Navigation下面的黑线）
    _navBarHairlineImageView = [self findHairlineImageViewUnder:self.navigationController.navigationBar];
    _navBarHairlineImageView.image = [UIImage imageWithColor:_mainBGColor];
    
    // 初始化_riskArray
    int i=0, j=0, k=0;
    for ( k=0; k<10; k++ ) {
        RiskFactorModel *model = [[RiskFactorModel alloc] init];
        model.name = [NSString stringWithFormat:@"西药分类第一层%d",k];
        
        NSMutableArray *oneArray = [[NSMutableArray alloc] init];
        for ( j=0; j<10; j++) {
            RiskFactorNextModel *model = [[RiskFactorNextModel alloc] init];
            model.name = [NSString stringWithFormat:@"西药分类第二层%d-%d",k,j];
            
            NSMutableArray *twoArray = [[NSMutableArray alloc] init];
            for ( i=0; i<10; i++) {
                RiskFactorNext2Model *model = [[RiskFactorNext2Model alloc] init];
                model.name = [NSString stringWithFormat:@"西药分类第三层%d-%d-%d",k,j,i];
                
                //这里应该构造第四层数据
                
                
                [twoArray addObject:model];
            }
            model.content = [twoArray mutableCopy];
            [oneArray addObject:model];
        }
        model.content = [oneArray mutableCopy];
        [_riskArray addObject:model];
    }
}


- (KYTableView *)createUITableView{
    
    WS(weakSelf)
    KYTableView *tableView = [[KYTableView alloc]initWithFrame:CGRectMake(0, segmentH+1, SCREEN_WIDTH/2, SCREEN_HEIGHT-segmentH-64-49) andUpBlock:^{
        [weakSelf.tableView endLoading];
        [weakSelf.twoTableView endLoading];
        [weakSelf.threeTableView endLoading];
        [weakSelf.fourTableView endLoading];
        [weakSelf.fiveTableView endLoading];
    

        if(_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_One) {
            //[self.viewModel getMyOrderList:0 Size:20 Status:@"ALL"];
        }else  if (_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Two) {
            //[self.viewModel getMyOrderList:0 Size:20 Status:@"UN_PAYED"];
        }else  if (_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Three) {
            _orderButtonClickInteger = RiskTypeFDARightVC_ENUM_Four;
            //[self.viewModel getMyOrderList:0 Size:20 Status:@"SHIPPED"];
        }else if (_orderButtonClickInteger == EF_MyOrderVC_NS_ENUM_Five) {
           // [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_COMMENTED"];
        }else {
             // [self.viewModel getMyOrderList:0 Size:20 Status:@"UN_COMMENTED"];
        }
        
    } andDownBlock:^{
        
        [weakSelf.tableView endLoading];
        [weakSelf.twoTableView endLoading];
        [weakSelf.threeTableView endLoading];
        [weakSelf.fourTableView endLoading];
        [weakSelf.fiveTableView endLoading];
        
    }];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registerClass:[RiskTypeFDARightCell class] forCellReuseIdentifier:RiskTypeFDARightCell_ID];
    
    [tableView reloadData];
    
    return tableView;
}



#pragma mark - TableView data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    RiskTypeModel *model = _dataSource[indexPath.row];
    RiskTypeFDARightCell *cell = [tableView dequeueReusableCellWithIdentifier:RiskTypeFDARightCell_ID];
    cell.model = model;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RiskTypeDetailVC *next = [[RiskTypeDetailVC alloc] init];
    [_rsRiskKindVC.navigationController pushViewController:next animated:YES];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id model = _dataSource[indexPath.row];

    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RiskTypeFDARightCell class] contentViewWidth:[self cellContentViewWith]];
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

- (void ) setRsRiskKindVC:(RSRiskKindVC *)rsRiskKindVC {
    
     _rsRiskKindVC = rsRiskKindVC;

}

#pragma mark 开启了FDA  RiskTypeFDALeftTwoVCDelegate

- (void)RiskTypeFDALeftTwoVC:(RiskTypeFDALeftTwoVC *)RiskTypeFDALeftTwoVC didSelectedRiskTypeFDALeftTwoVC:(RiskTypeModel *)model {
    
    _model = model;
    
    int index = arc4random() % 9;
    RiskFactorNextModel *riskFactorNextModel = [[RiskFactorNextModel alloc] init];
    riskFactorNextModel = _riskArray[index];
    

    [_dataSource removeAllObjects];
    for (int i=0; i<11; i++)  {
        
        RiskTypeModel *model = [[RiskTypeModel alloc] init];
        model.name = riskFactorNextModel.name;
        model.idstr = riskFactorNextModel.name;
        [_dataSource addObject:model];
    }
    
    
    if(_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_One) {
        
        [_tableView reloadData];
        
    }else  if (_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Two) {
        
        [_twoTableView reloadData];
    }else  if (_orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Three) {
        
        [_threeTableView reloadData];
        
    }else if ( _orderButtonClickInteger == RiskTypeFDARightVC_ENUM_Four) {
        
        [_fourTableView reloadData];
        
    }else {
        [_fiveTableView reloadData];
    }
    
    
}

#pragma mark ViewModel 回调
/*
- (void)callBackAction:(EFViewControllerCallBackAction)action Result:(NetworkModel *)result{
    if (action & EFMailShopCart_MyOrderList) {
        if ([result.jsonDict[@"status"] intValue] == 200) {
            
            [_dataSource removeAllObjects];
            _dataSource = _viewModel.orderModelArray;
            
            if(_orderButtonClickInteger == EF_MyOrderVC_NS_ENUM_All) {
                _AllDataArray = [_dataSource copy];
            }else  if (_orderButtonClickInteger == EF_MyOrderVC_NS_ENUM_NoPayment) {
                _TwoDataArray = [_dataSource copy];
            }else  if (_orderButtonClickInteger == EF_MyOrderVC_NS_ENUM_NoGetGood) {
                _ThreeDataArray = [_dataSource copy];
            }else {
                _FourDataArray = [_dataSource copy];
            }
            
            [self initViewPager];
        }
    }
}
*/

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

//- (void)dealloc
//{
//    if (self.viewModel) {
//        [self.viewModel cancelAndClearAll];
//        self.viewModel = nil;
//    }
//}

@end
