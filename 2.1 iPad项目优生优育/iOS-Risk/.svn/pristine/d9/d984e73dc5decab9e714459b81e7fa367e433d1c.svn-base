//
//  MedicineTypesVC.m
//  Risk
//
//  Created by ylgwhyh on 16/6/30.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RiskTypesLeftVC.h"
#import "RiskTypeModel.h"
#import "RiskTypesLeftCell.h"

@interface RiskTypesLeftVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *riskTypesArray;
@property (nonatomic, strong) NSArray *sectionTitleArray;
@property (nonatomic, strong) NSIndexPath *oldSelectIndexPath;


@end

@implementation RiskTypesLeftVC {
}

static NSString * const RiskTypesLeftVC_RiskTypesLeftCell_ID = @"RiskTypesLeftVC_RiskTypesLeftCell_ID";

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
}


- (void) initUI {
    
    self.tableView.tableHeaderView.backgroundColor = RGBColor(213, 213, 220);
    [self.tableView registerClass:[RiskTypesLeftCell class] forCellReuseIdentifier:RiskTypesLeftVC_RiskTypesLeftCell_ID];
    
}

- (void) initData {
    
    if(_riskTypesArray == nil ) {
        _riskTypesArray = [[NSMutableArray alloc] init];
    }
    
    RiskTypeModel *model00 = [[RiskTypeModel alloc] init];
    RiskTypeModel *model01 = [[RiskTypeModel alloc] init];
    model00.name = @"西药";
    model00.isSelect = YES;   //默认选中第一个
    model01.name = @"中药";
    NSMutableArray *oneArray  = [[NSMutableArray alloc] init];
    [oneArray addObject:model00];
    [oneArray addObject:model01];
    
    NSMutableArray *twoArray = [NSMutableArray array];
    NSArray *twoNameArray = @[@"化学因素", @"物理因素",@"生物因素", @"膳食与营养",@"职业、习惯与行为", @"家用化学品",@"其他"];
    for (int i=0; i<7; i++) {
        RiskTypeModel *model = [[RiskTypeModel alloc] init];
        model.name = twoNameArray[i];
        [twoArray addObject:model];
    }
    
    
    NSMutableArray *threeArray = [NSMutableArray array];
    NSArray *threeNameArray = @[@"染色体", @"基因", @"遗传病"];
    for (int i=0; i<3; i++) {
        RiskTypeModel *model = [[RiskTypeModel alloc] init];
        model.name = threeNameArray[i];
        [threeArray addObject:model];
    }
    
    RiskTypeModel *model30 = [[RiskTypeModel alloc] init];
    RiskTypeModel *model40 = [[RiskTypeModel alloc] init];
    
    model30.name = @"软指标";
    model40.name = @"正常值";
    
    NSMutableArray *fourArray = [NSMutableArray array];
    [fourArray addObject:model30];
    
    NSMutableArray *fiveArray = [NSMutableArray array];
    [fiveArray addObject:model40];
    
    NSMutableArray *arrays = [[NSMutableArray alloc] init];
    [arrays addObject:oneArray];
    [arrays addObject:twoArray];
    [arrays addObject:threeArray];
    [arrays addObject:fourArray];
    [arrays addObject:fiveArray];
    
    [_riskTypesArray addObjectsFromArray:arrays];
    _sectionTitleArray = @[@"药物", @"其他环境因素", @"遗传因素", @"产前超声", @"正常值"];
    
    
    //默认选中第一个
    _oldSelectIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
}


#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _riskTypesArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return [_riskTypesArray[section] count];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    RiskTypesLeftCell *cell = [tableView dequeueReusableCellWithIdentifier:RiskTypesLeftVC_RiskTypesLeftCell_ID];
    RiskTypeModel *model = [_riskTypesArray[indexPath.section] objectAtIndex:indexPath.row];
    model.integer = indexPath.row+1;
    cell.riskTypeModel = model;
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if(_oldSelectIndexPath != nil ) {
        //取消以前选中的
        RiskTypeModel *oldModel = [_riskTypesArray[_oldSelectIndexPath.section] objectAtIndex:_oldSelectIndexPath.row];
        oldModel.isSelect = NO;
        [_riskTypesArray[_oldSelectIndexPath.section]  replaceObjectAtIndex:_oldSelectIndexPath.row withObject:oldModel];
        [self.tableView reloadRowsAtIndexPaths:@[_oldSelectIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic] ;
    }
    
    //选中当前的
    RiskTypeModel *model = [_riskTypesArray[indexPath.section] objectAtIndex:indexPath.row];
    model.isSelect = YES;
    [_riskTypesArray[indexPath.section]  replaceObjectAtIndex:indexPath.row withObject:model];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic] ;
    _oldSelectIndexPath = indexPath;  //记录当前选中的cell
    
    if ([self.delegate respondsToSelector:@selector(riskTypesVC:didSelectedRiskType:)]) {
        
        RiskTypeModel *model = [[RiskTypeModel alloc] init];
        model = [_riskTypesArray[indexPath.section] objectAtIndex:indexPath.row];
        [self.delegate riskTypesVC:self didSelectedRiskType:model];
    }
}

#pragma mark - Table view  delegate

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    return _sectionTitleArray[section];
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    header.textLabel.textColor = RGBColor(46, 83, 111);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}



@end
