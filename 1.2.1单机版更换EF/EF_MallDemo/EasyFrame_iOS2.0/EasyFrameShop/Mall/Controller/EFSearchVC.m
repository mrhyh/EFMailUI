//
//  SearchVC.m
//  hujinrong
//
//  Created by MH on 16/4/29.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFSearchVC.h"
#import "UIButton+LXMImagePosition.h"
//#import "SearchViewModel.h"
//#import "SearchResultListVC.h"
#import "SVProgressHUD.h"

//#import "MineCenterViewModel.h"


#define Search_History @"Search_History"

@interface EFSearchVC ()

//@property (nonatomic, strong) SearchViewModel *viewModel;

@property (nonatomic, strong) NSMutableArray * historyArr;

//@property (nonatomic,strong ) MineCenterViewModel *msgViewModel;

@end

@implementation EFSearchVC {
    //尺寸、颜色
    NSNumber * _normal;
    NSNumber * _middle;
    NSNumber * _small;
    UIColor * _textMainColor;
    UIColor * _textSecondColor;
    
    //搜索栏
    UISearchBar * _searchBar;
    UIView      * searchView;
    KYMHButton  * cancelBtn;
    
    //大家都在搜View
    UIView      * topBackView;
    
    //tableview
    UITableView *historyTable;
    
    //cell
    KYMHButton *delBtn;
    UIColor *labelMainColor;
    
    int numberOfTagPage;
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    searchView.hidden = YES;
    _searchBar.text = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    searchView.hidden = NO;
    
    //[self.msgViewModel GetUnReadMsgCount];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.hidesBackButton = YES;
    WS(weakSelf)
    
    numberOfTagPage = 0;
    
    labelMainColor = EF_TextColor_TextColorSecondary; //灰色
    self.view.backgroundColor = EF_BGColor_Primary;
    
    
    _normal = [EFSkinThemeManager getFontSizeWithKey:SkinThemeKey_FontSizeNormal];//17
    _middle = [EFSkinThemeManager getFontSizeWithKey:SkinThemeKey_FontSizeMiddle];//15
    _small = [EFSkinThemeManager getFontSizeWithKey:SkinThemeKey_FontSizeSmall];//13
    
    _textMainColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackNormal];
    _textSecondColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackSecondary];
    
    searchView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = searchView;
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20-50, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"搜索";
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    [[[[_searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [_searchBar becomeFirstResponder];
    [searchView addSubview:_searchBar];
    
    cancelBtn = [[KYMHButton alloc]initWithbarButtonItem:self Title:@"取 消" BaseSize:CGRectMake(CGRectGetMaxX(_searchBar.frame)+10, 0, 40, 44) ButtonColor:[UIColor clearColor] ButtonFont:[_middle floatValue] ButtonTitleColor:[UIColor whiteColor] Block:^{
     
        [_searchBar resignFirstResponder];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }];
    [searchView addSubview:cancelBtn];
    
    topBackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 175)];
    topBackView.backgroundColor = [UIColor whiteColor];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resignFirstResponderGesture)];
    tapGesture.numberOfTapsRequired = 1;
    tapGesture.numberOfTouchesRequired = 1;
    [topBackView addGestureRecognizer:tapGesture];
    
    
    [self.view addSubview:topBackView];
    
    KYMHLabel * leftTopLB = [[KYMHLabel alloc]initWithTitle:@"大家都在搜" BaseSize:CGRectMake(10, 15, 100, 20) LabelColor:[UIColor clearColor] LabelFont:[_middle floatValue] LabelTitleColor:_textSecondColor TextAlignment:NSTextAlignmentLeft];
    [topBackView addSubview:leftTopLB];
    
    KYMHButton * rightTopBtn = [[KYMHButton alloc]initWithbarButtonItem:self Title:@"换一批" BaseSize:CGRectMake(SCREEN_WIDTH-80, 15, 80, 20) ButtonColor:[UIColor clearColor] ButtonFont:[_middle floatValue] ButtonTitleColor:_textSecondColor Block:^{
        //换一批
        NSLog(@"换一批");
//        if (numberOfTagPage < (int)weakSelf.viewModel.tagModel.totalPages-1) {
//            numberOfTagPage++;
//        }else {
//            numberOfTagPage = 0;
//        }
        
    }];
    [topBackView addSubview:rightTopBtn];
    [rightTopBtn setImage:Img(@"ic_refresh") forState:UIControlStateNormal];
    [rightTopBtn setImagePosition:LXMImagePositionRight spacing:5];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 174.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = EF_TextColor_TextColorDisable;
    [topBackView addSubview:line];
    
    KYMHLabel * noteLB = [[KYMHLabel alloc]initWithTitle:@"您还没有搜索历史记录" BaseSize:CGRectMake(0, CGRectGetMaxY(topBackView.frame)+50, SCREEN_WIDTH, 50) LabelColor:[UIColor clearColor] LabelFont:17 LabelTitleColor:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noteLB];
    
    //初始化ViewModel
//    self.viewModel = [[SearchViewModel alloc]initWithViewController:self];
//    [self.viewModel getContentTagWithPage:0 Size:9];
    
    /**
     刷新系统消息
     */
//    self.msgViewModel = [[MineCenterViewModel alloc]initWithViewController:self];
//    [self.msgViewModel GetUnReadMsgCount];
    
    //获取历史搜索
    self.historyArr = [NSMutableArray array];
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:Search_History];
    self.historyArr = [self arrayToMutableArray:array];
    if (self.historyArr.count > 0) {
        [self seaerchHistoryTable];
    }

}

- (void)resignFirstResponderGesture {
    [_searchBar resignFirstResponder];
}

/*
- (void)callBackAction:(EFViewControllerCallBackAction)action Result:(NetworkModel *)result {
    if (action & HJR_SearchCallBackActionGetContentTag) {
        if (result.status == NetworkModelStatusTypeSuccess) {
            if (self.viewModel.tagModel.content.count > 0) {
                [self everyBodyDo];
            }
        }
    }
    
    if (action & HJR_SearchCallBackActionUpdateContentTagHot) {
        
    }
    
    if (action & HJR_SearchCallBackActionFindContentsByTag) {
        if (result.status == NetworkModelStatusTypeSuccess) {
            if (self.viewModel.contentsModelArray.count > 0) {
                SearchResultListVC *vc = [[SearchResultListVC alloc]init];
                vc.newsArr = self.viewModel.contentsModelArray;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                [UIUtil alert:@"暂无相关新闻"];
            }
        }
    }
    
    if (action & HJR_SearchCallBackActionFindContentsByKeyword) {
        if (result.status == NetworkModelStatusTypeSuccess) {
            if (self.viewModel.contentsModelArray.count > 0) {
                SearchResultListVC *vc = [[SearchResultListVC alloc]init];
                vc.newsArr = self.viewModel.contentsModelArray;
                [self.navigationController pushViewController:vc animated:YES];
            }else {
                [UIUtil alert:@"暂无相关新闻"];
            }
        }
    }
    
 //刷新系统消息
    if (action & HJR_MineCallBackActionGetUnReadMsgCount) {
        
        UIViewController *rootController = [UIApplication sharedApplication].keyWindow.rootViewController;
        UITabBarController *tabController = (UITabBarController*)rootController;
        UIViewController *requiredViewController = [tabController.viewControllers objectAtIndex:3];
        UITabBarItem *item = requiredViewController.tabBarItem;
        if (self.msgViewModel.sysUnReadMsgCount > 0) {
            [item setBadgeValue:[NSString stringWithFormat:@"%d",self.msgViewModel.sysUnReadMsgCount]];
        }else {
            [item setBadgeValue:nil];
        }
    }
 
    [_searchBar resignFirstResponder];
    [SVProgressHUD dismiss];
}
*/

- (void)everyBodyDo {
    WS(weakSelf)
    UIColor *buttonTitleColor =EF_TextColor_TextColorPrimary;
    UIColor *buttonBorderColor = EF_TextColor_TextColorDisable;
    CGFloat buttonFontSize = 15;
    
    CGFloat width;
    if (IS_IPHONE4 || IS_IPHONE5) {
        width = (SCREEN_WIDTH-20-20)/3;
    }else {
        width = (SCREEN_WIDTH-20-60)/3;
    }
    CGFloat _ox;
    if (IS_IPHONE4 || IS_IPHONE5) {
        _ox = width+10;
    }else {
        _ox = width+30;
    }
    
    //移除原来的Button
    for (UIView *subviews in [topBackView subviews]) {
        if (subviews.tag==10011) {
            [subviews removeFromSuperview];
        }
    }

    /*
    for (int i = 0; i < self.viewModel.tagModel.content.count; i++) {
        int x = i%3;
        int y = i/3;
    
        KYMHButton * btn = [[KYMHButton alloc]initWithbarButtonItem:self Title:self.viewModel.tagModel.content[i].tag BaseSize:CGRectMake(10+_ox*x, 44+40*y, width, 30) ButtonColor:[UIColor clearColor] ButtonFont:[_middle floatValue] ButtonTitleColor:buttonTitleColor Block:^{
           //点击搜索该项
            [weakSelf searchByTag:weakSelf.viewModel.tagModel.content[i]];
            
        }];
        btn.tag = 10011;
        [topBackView addSubview:btn];
        [btn RectSize:2 SideWidth:1 SideColor:buttonBorderColor];
    }
     */
}

/*
- (void)searchByTag:(tagContent *)_tagContent  {
    tagContent *tag = _tagContent;
    
    [SVProgressHUD show];
    [self.viewModel UpdateContentTagHotWithTagId:(int)tag.objectId];
    [self.viewModel FindContentsByTag:(int)tag.objectId Page:0 Size:15];
}
*/

- (void)seaerchHistoryTable {
    //tableview-headerview
    UIView * headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 35)];
    headView.backgroundColor = [UIColor whiteColor];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = _textSecondColor;
    [headView addSubview:line];
    
    KYMHLabel * tbLB = [[KYMHLabel alloc]initWithTitle:@"历史搜索" BaseSize:CGRectMake(10, 0, 100, 35) LabelColor:[UIColor clearColor] LabelFont:[_middle floatValue] LabelTitleColor:_textSecondColor TextAlignment:NSTextAlignmentLeft];
    [headView addSubview:tbLB];
    
    //tableview-footerview
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    footView.backgroundColor = [UIColor whiteColor];
    WS(weakSelf)
    KYMHButton * clearBtn = [[KYMHButton alloc]initWithbarButtonItem:self Title:@"清除搜索记录" BaseSize:CGRectMake(0, 0, SCREEN_WIDTH, 50) ButtonColor:[UIColor clearColor] ButtonFont:[_middle floatValue] ButtonTitleColor:[UIColor redColor] Block:^{
        //清除搜索记录
        NSLog(@"清除搜索记录");
        [weakSelf.historyArr removeAllObjects];
        historyTable.hidden = YES;
        
        [[NSUserDefaults standardUserDefaults] setObject:[self mugtableArrayToArray:self.historyArr] forKey:Search_History];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    [footView addSubview:clearBtn];
    
    //tableview
    UIColor *tableViewBorderColor = EF_TextColor_TextColorDisable;
    historyTable = [[UITableView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(topBackView.frame)+10, SCREEN_WIDTH, SCREEN_HEIGHT-175-10-44-50-20)];
    [self.view addSubview:historyTable];
    historyTable.delegate = self;
    historyTable.dataSource = self;
    historyTable.showsVerticalScrollIndicator = NO;
    historyTable.backgroundColor = EF_BGColor_Primary;
    historyTable.separatorStyle = UITableViewCellAccessoryNone;
    historyTable.tableHeaderView = headView;
    historyTable.tableFooterView = footView;
    historyTable.layer.borderColor = tableViewBorderColor.CGColor;
    historyTable.layer.borderWidth = 0.5;
    
    if (IS_IPHONE4 || IS_IPHONE5) {
        historyTable.scrollEnabled = YES;
    }else {
        //historyTable.scrollEnabled = NO;
        historyTable.scrollEnabled = YES; //hyh
    }
    
}

#pragma mark -- tableview设置
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark ------------------ TableViewCell的创建 -----------------

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WS(weakSelf);
    
    static NSString *CellIdentifier = @"histroyCell";
    EFSearchHistroyCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell ) {
        NSString *cellStr = [NSString stringWithFormat:@"%@",self.historyArr[indexPath.row]];
        cell = [[EFSearchHistroyCell alloc]initWithHistroy:cellStr];
        
        delBtn = [[KYMHButton alloc]initWithbarButtonItem:self Title:@"" BaseSize:CGRectMake(SCREEN_WIDTH-30, 15, 20, 20) ButtonColor:[UIColor clearColor] ButtonFont:0 ButtonTitleColor:nil Block:^{
            [weakSelf deleteHistroy:indexPath.row];
        }];
        [delBtn setImage:Img(@"btn_nointerest") forState:UIControlStateNormal];
        [cell addSubview:delBtn];
    }
    
    if (indexPath.row == self.historyArr.count-1) {
        cell.line.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
        cell.line.backgroundColor = EF_TextColor_TextColorDisable;
    }else{
//        cell.line.frame = CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5);
//        cell.line.backgroundColor = EF_TextColor_TextColorDisable;
    }
    
    cell.selectionStyle  = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"搜索该项");
    [_searchBar becomeFirstResponder];
    _searchBar.text = self.historyArr[indexPath.row];
    
}

- (void)deleteHistroy:(NSInteger)sender {
    NSLog(@"删除单项%ld-->刷新数据",(long)sender);
    
    [self.historyArr removeObjectAtIndex:sender];
    [[NSUserDefaults standardUserDefaults] setValue:self.historyArr forKey:Search_History];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.historyArr.count > 0) {
        historyTable.hidden = NO;
        [historyTable reloadData];
    }else {
        historyTable.hidden = YES;
    }
}

#pragma mark -- searchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.1f animations:^{
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH-50-20, 44);
        cancelBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame)+10, 0, 40, 44);
    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
    [UIView animateWithDuration:0.1f animations:^{
        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 44);
        cancelBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame)+10, 0, 40, 44);
    }];
    _searchBar.text = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([UIUtil isEmptyStr:_searchBar.text]) {
        [UIUtil alert:@"请输入搜素内容"];
        return;
    }
    NSLog(@"搜索内容；；%@",_searchBar.text);
    NSLog(@"搜索内容；；%@",searchBar.text);
    for (int i = 0; i<self.historyArr.count; i++) {
        if ([self.historyArr[i] isEqualToString:_searchBar.text]) {
            [self.historyArr removeObjectAtIndex:i];
            [self.historyArr insertObject:_searchBar.text atIndex:0];
            [self search];
            return;
        }
    }
    if (self.historyArr.count== 5) {
        [self.historyArr removeObjectAtIndex:4];
        [self.historyArr insertObject:_searchBar.text atIndex:0];
    }else {
        [self.historyArr insertObject:_searchBar.text atIndex:0];
    }
    
    [self search];
    
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
     [self.navigationController popViewControllerAnimated:YES];
}

- (void)search {
    
    [[NSUserDefaults standardUserDefaults] setObject:[self mugtableArrayToArray:self.historyArr] forKey:Search_History];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SVProgressHUD showWithStatus:@"正在搜索"];
    historyTable.hidden = NO;
    [historyTable reloadData];
    //[self.viewModel FindContentsByKeyword:_searchBar.text Page:0 Size:15];
    
}


- (NSArray *)mugtableArrayToArray:(NSMutableArray *)mutableArray {
    NSArray *array = [NSArray array];
    array = mutableArray;
    return array;
}

- (NSMutableArray *)arrayToMutableArray:(NSArray *)array {
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    return mutableArray;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
