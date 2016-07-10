//
//  RiskTypesDetailVC.m
//  Risk
//
//  Created by ylgwhyh on 16/6/30.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RiskTypesRightVC.h"
#import "RiskDetailTypeModel.h"
#import "MJExtension.h"
#import "RiskTypeModel.h"
#import "RiskFactorModel.h"
#import "RiskTypeDetailVC.h"

@interface RiskTypesRightVC ( )

@property (nonatomic, strong) NSMutableArray *riskArray;
@property (nonatomic, strong) NSMutableArray *sourceDataArray;


@property (nonatomic, strong) UIColor *oldNavigationBGColor;
@property (nonatomic, strong) UIColor *oldNavigationTitleColor;
@property (nonatomic, strong)  UILabel *navigationTitleLabel;

@end

@implementation RiskTypesRightVC {
    
}


- (void)viewWillDisappear:(BOOL)animated {
    //还原此页Navigation的设置
    //[self.navigationController.navigationBar setBarTintColor:_oldNavigationBGColor];
    
}

-(void)viewWillAppear:(BOOL)animated {

    _oldNavigationBGColor = self.navigationController.navigationBar.tintColor; //记录Navigation原来的颜色
    _oldNavigationTitleColor = self.navigationController.navigationBar.titleTextAttributes[NSForegroundColorAttributeName]; //记录Navigation原来的文字颜色
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor whiteColor]];
    
    NSDictionary *textAttributes=[NSDictionary dictionaryWithObjectsAndKeys:RGBColor(110, 133, 152),NSForegroundColorAttributeName,nil];
    [self.navigationController.navigationBar setTitleTextAttributes:textAttributes];
    
    //更改返回按钮文字和颜色
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    self.navigationController.navigationBar.tintColor = RGBColor(110, 133, 152);
    
    //在此控制器第一次在左边显示title
    if(_isHideNavigationTitleLabelBOOL) {
        _navigationTitleLabel.hidden = YES;
    }else {
        if(_navigationTitleLabel == nil ) {
            _navigationTitleLabel= [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 150, 44)];
            _navigationTitleLabel.textAlignment = NSTextAlignmentLeft;
            _navigationTitleLabel.textColor = RGBColor(110, 133, 152);
            _navigationTitleLabel.font = Font(middleFontSize);
            _navigationTitleLabel.text = @"西药";
            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:_navigationTitleLabel];
            self.navigationItem.leftBarButtonItem = barBtnItem;
        }
        _navigationTitleLabel.hidden = NO;
        
    }

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initData ];
    
}

- (void) initData {
    
    _sourceDataArray = [[NSMutableArray alloc] init];
    _riskArray = [[NSMutableArray alloc] init];
    
    //self.title = @"西药";
    
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
    
    RiskFactorNextModel *model = _riskArray[0];
    _sourceDataArray = [model.content mutableCopy];
}

- (void)splitViewController:(UISplitViewController *)svc willShowViewController:(UIViewController *)aViewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    self.navigationItem.leftBarButtonItem = nil;
}


- (void)splitViewController:(UISplitViewController *)svc willHideViewController:(UIViewController *)aViewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)pc
{
    barButtonItem.title = @"菜系";
    self.navigationItem.leftBarButtonItem = barButtonItem;
}


- (void) setTypeModel:(RiskTypeModel *)typeModel {

    [self.navigationController popToRootViewControllerAnimated:NO];
    _typeModel = typeModel;
    _navigationTitleLabel.text = typeModel.name;

    int index = arc4random() % 9;
    RiskFactorNextModel *model = [[RiskFactorNextModel alloc] init];
    model = _riskArray[index];
    _sourceDataArray = [model.content mutableCopy];
    
    
    [self.tableView scrollToRowAtIndexPath:IndexZero atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.tableView reloadData];
    
}


- (void)setSplitViewController:(UISplitViewController *)splitViewController {
    _splitViewController = splitViewController;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _sourceDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"RiskTypesRightVC_Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    //如果下页还有数据
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //否则
    //cell.accessoryType = UITableViewCellAccessoryNone;
    
    RiskFactorModel *model = self.sourceDataArray[indexPath.row];
    cell.textLabel.text = model.name;

    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RiskDetailTypeModel *model = self.riskArray[indexPath.row];
    
    //RiskTypeDetailVC *next = [[RiskTypeDetailVC alloc] init];
    
    RiskTypesRightVC *next = [[RiskTypesRightVC alloc] init];
    next.isHideNavigationTitleLabelBOOL = YES;
    [self.navigationController pushViewController:next animated:YES];
    
    
//    [self.navigationController presentViewController:next animated:YES completion:^{
//        
//    }];
    //[_splitViewController.navigationController pushViewController:next animated:YES];
    
}


#pragma mark - Table view  delegate

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    
//    return self.title;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    
//    return 44;
//}

@end
