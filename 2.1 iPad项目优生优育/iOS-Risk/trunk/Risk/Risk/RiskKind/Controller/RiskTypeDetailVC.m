
//
//  RiskTypeDetailVC.m
//  Risk
//
//  Created by ylgwhyh on 16/7/2.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RiskTypeDetailVC.h"
#import "RiskTypeDetailLeftModel.h"
#import "RiskTypeDetailLeftCell.h"

@interface RiskTypeDetailVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) KYTableView *leftTableView;
@property (nonatomic, strong) KYTableView *rightTableView;
@property (nonatomic, strong) RiskTypeDetailLeftModel *model;
@end

@implementation RiskTypeDetailVC {

}

    static NSString * const RiskTypeDetailLeftCell_One_ID = @"RiskTypeDetailLeftCell_One_ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    
}

- (void) initData {
    
    _model = [[RiskTypeDetailLeftModel alloc] init];
    _model.medicinalNameString = @"多粘菌素B(POLYMYXINB)";
    _model.medicinalTypeString = @"西药   FDA分类:  B";
    _model.medicinalTypeNumString = @"1110101105";
    _model.medicinalTimeString = @"2014-11-01";
    _model.otherNameString = @"头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、维生素、抗生素、头孢错领、Kefazol、Kefazol、Kefazol、Kefazol、Kefazol、Kefazol";
    _model.disclaimerString = @"本资料是根据国内外研究文献归纳总结的信息。所提供的信息仅供参考，不作为临床诊断和治疗的依据";
}

- (void) initUI {
    
    [self initLeftTableView];
}

- (void ) initRightTableView {
    
    WS(weakSelf)
        _rightTableView = [[KYTableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4 ,  0, SCREEN_WIDTH/4*3, SCREEN_HEIGHT-64-49) andUpBlock:^{

         [weakSelf.rightTableView endLoading];
        
    } andDownBlock:^{
        
        [weakSelf.rightTableView endLoading];

    }];
    
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //[_rightTableView registerClass:[RiskTypeFDARightCell class] forCellReuseIdentifier:RiskTypeFDARightCell_ID];
    
    [_rightTableView reloadData];
}

- (void ) initLeftTableView {
    
     WS(weakSelf)
    _leftTableView = [[KYTableView alloc]initWithFrame:CGRectMake(0 ,  0, SCREEN_WIDTH/4, SCREEN_HEIGHT) andUpBlock:^{
        
        [weakSelf.leftTableView endLoading];
        
    } andDownBlock:^{
        
        [weakSelf.leftTableView endLoading];
        
    }];
    
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
   // _leftTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [_leftTableView registerClass:[RiskTypeDetailLeftCell class] forCellReuseIdentifier:RiskTypeDetailLeftCell_One_ID];
    
    [self.view addSubview:_leftTableView];
    [_leftTableView reloadData];
}


#pragma mark - TableView data source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    if(tableView == _leftTableView) {
        
    }
    RiskTypeDetailLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:RiskTypeDetailLeftCell_One_ID];
    cell.model = _model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    id model = _model;

    return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RiskTypeDetailLeftCell class] contentViewWidth:[self cellContentViewWith]];
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

@end
