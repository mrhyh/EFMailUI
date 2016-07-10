//
//  RSSearchVC.m
//  Risk
//
//  Created by ylgwhyh on 16/7/4.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSSearchVC.h"
#import "RSSearchHistoryCell.h"
#import "UIButton+LXMImagePosition.h"

@interface RSSearchVC () <UISearchBarDelegate,UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray * historyArr;
@property (nonatomic, strong) NSMutableArray * dataSource;

@property (nonatomic, strong)  UIView *footView;
@property (nonatomic, strong)  UIView *headView;
@property (nonatomic, strong)  UITableView *historyTable;

@property (nonatomic,  assign) BOOL isFirstJoin;

@end

@implementation RSSearchVC {
    
    //尺寸、颜色
    UIColor * _textMainColor;
    UIColor * _textSecondColor;
    
    //搜索栏
    UISearchBar * _searchBar;
    UIView      * searchView;
    KYMHButton  * cancelBtn;
    
    //cell
    KYMHButton *delBtn;
    UIColor *labelMainColor;
    
    int numberOfTagPage;
    
    CGFloat cellToLeft;
}

#define SearchHistory_UserDefault_Key @"SearchHistory_UserDefault_Key"

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:YES];
    
    searchView.hidden = YES;
    _searchBar.text = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    searchView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    

}

- (void) initData {
    
    cellToLeft = 150;
    _isFirstJoin = YES;
    _dataSource = [[NSMutableArray alloc] init];
    _historyArr = [[NSMutableArray alloc] init];
    labelMainColor = EF_TextColor_TextColorSecondary; //灰色
    _textMainColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackNormal];
    _textSecondColor = [EFSkinThemeManager getTextColorWithKey:SkinThemeKey_BlackSecondary];
    numberOfTagPage = 0;
}

- (void ) initUI {
    
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = EF_BGColor_Primary;
    
    [self initNavigationRightBack];
    [self initSearchView];
    [self initSearchHistoryView];
    
}

- (void) initNavigationRightBack {
    
    KYMHButton *backButton = [[KYMHButton alloc] initWithFrame:CGRectMake(0, 0, 75, 30)];
    [backButton setImage:Img(@"icon_previous") forState:UIControlStateNormal];
    backButton.titleLabel.font = Font(middleFontSize);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton horizontalCenterImageAndTitle];
    [backButton addTarget:self action:@selector(backButtonClickAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:backItem];
    
}

- (void ) backButtonClickAction {
    
    [self.navigationController dismissViewControllerAnimated:YES completion:^{
        
    }];

}

- (void) initSearchHistoryView {
    
    KYMHLabel * noteLB = [[KYMHLabel alloc]initWithTitle:@"您还没有搜索历史记录" BaseSize:CGRectMake(0, 200, SCREEN_WIDTH, 50) LabelColor:[UIColor clearColor] LabelFont:17 LabelTitleColor:[UIColor blackColor] TextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:noteLB];
    
    //获取历史搜索
    NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:SearchHistory_UserDefault_Key];
   
 
    if (array.count > 0) {
        
         self.historyArr = [array mutableCopy];
    }else {
    }
    
    if(_isFirstJoin) {
        [self.historyArr removeAllObjects];
        NSArray *array = @[@"头孢拉定" ,@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素",@"大观霉素", @"克拉霉素" ];
        self.historyArr = [array mutableCopy];
    }
    
    [self seaerchHistoryTable];
}

- (void) initSearchView {
    
    WS(weakSelf)
    searchView = [[UIView alloc]initWithFrame:CGRectMake(320, 0, SCREEN_WIDTH-2*320, 44)];
    searchView.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = searchView;
    
    
    _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-320*2-50, 44)];
    _searchBar.delegate = self;
    _searchBar.placeholder = @"如: 阿司匹林、ASPL ";
     [_searchBar setContentMode:UIViewContentModeLeft];
    _searchBar.searchBarStyle = UISearchBarStyleDefault;
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    [[[[_searchBar.subviews objectAtIndex:0] subviews] objectAtIndex:0] removeFromSuperview];
    [_searchBar becomeFirstResponder];
    [searchView addSubview:_searchBar];
    
    
    cancelBtn = [[KYMHButton alloc]initWithbarButtonItem:self Title:@"取 消" BaseSize:CGRectMake(CGRectGetMaxX(_searchBar.frame)+10, 0, 40, 44) ButtonColor:[UIColor clearColor] ButtonFont:middleFontSize ButtonTitleColor:[UIColor whiteColor] Block:^{
        
        [_searchBar resignFirstResponder];
        [weakSelf.navigationController popViewControllerAnimated:YES];
        [SVProgressHUD dismiss];
    }];
    [searchView addSubview:cancelBtn];
}

- (void)resignFirstResponderGesture {
    [_searchBar resignFirstResponder];
}


- (void)seaerchHistoryTable {

     WS(weakSelf)
    
    if(_headView == nil) {
        
        _headView = [[UIView alloc] initWithFrame:CGRectMake(cellToLeft, 64, SCREEN_WIDTH-2*cellToLeft, 35)];
        _headView.backgroundColor = [UIColor whiteColor];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
        line.backgroundColor = _textSecondColor;
        [_headView addSubview:line];
        
        KYMHLabel * tbLB = [[KYMHLabel alloc]initWithTitle:@"历史搜索" BaseSize:CGRectMake(10, 0, 100, 35) LabelColor:[UIColor clearColor] LabelFont:middleFontSize LabelTitleColor:_textSecondColor TextAlignment:NSTextAlignmentLeft];
        [_headView addSubview:tbLB];
    }
    
    if(_footView == nil) {
        _footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-2*cellToLeft, 50)];
        _footView.backgroundColor = [UIColor whiteColor];
        
        KYMHButton * clearBtn = [[KYMHButton alloc]initWithbarButtonItem:self Title:@"清除搜索记录" BaseSize:CGRectMake(0, 0, SCREEN_WIDTH-2*cellToLeft, 50) ButtonColor:[UIColor clearColor] ButtonFont:middleFontSize ButtonTitleColor:[UIColor redColor] Block:^{
            
            NSLog(@"清除搜索记录");
            [weakSelf.historyArr removeAllObjects];
            _historyTable.hidden = YES;
            
            [[NSUserDefaults standardUserDefaults] setObject:[self mugtableArrayToArray:self.historyArr] forKey:SearchHistory_UserDefault_Key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }];
        [_footView addSubview:clearBtn];
    }
    
    
    if(_historyTable == nil) {
        UIColor *tableViewBorderColor = EF_TextColor_TextColorDisable;
        _historyTable = [[UITableView alloc]initWithFrame:CGRectMake(cellToLeft, 64, SCREEN_WIDTH-2*cellToLeft, SCREEN_HEIGHT-64)];
        [self.view addSubview:_historyTable];
        _historyTable.delegate = self;
        _historyTable.dataSource = self;
        _historyTable.showsVerticalScrollIndicator = NO;
        _historyTable.backgroundColor = EF_BGColor_Primary;
        _historyTable.separatorStyle = UITableViewCellAccessoryNone;
        _historyTable.layer.borderColor = tableViewBorderColor.CGColor;
        _historyTable.layer.borderWidth = 0.5;
    }
    
    if(_isFirstJoin) {
        _headView.hidden = YES;
        _footView.hidden = YES;
    }else {
        _headView.hidden = NO;
        _footView.hidden = NO;
        _historyTable.tableHeaderView = _headView;
        _historyTable.tableFooterView = _footView;
    }
    
    [_historyTable reloadData];
}

#pragma mark TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.historyArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WS(weakSelf);
    
    static NSString *CellIdentifier = @"histroyCell";
    RSSearchHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell ) {
        NSString *cellStr = [NSString stringWithFormat:@"%@",self.historyArr[indexPath.row]];
        cell = [[RSSearchHistoryCell alloc]initWithHistroy:cellStr];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
    [[NSUserDefaults standardUserDefaults] setValue:self.historyArr forKey:SearchHistory_UserDefault_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    if (self.historyArr.count > 0) {
        _historyTable.hidden = NO;
        [_historyTable reloadData];
    }else {
        _historyTable.hidden = YES;
    }
}

#pragma mark - SearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
//    [UIView animateWithDuration:0.1f animations:^{
//        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH-50-20, 44);
//        cancelBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame)+10, 0, 40, 44);
//    }];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar {
//    [UIView animateWithDuration:0.1f animations:^{
//        _searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 44);
//        cancelBtn.frame = CGRectMake(CGRectGetMaxX(_searchBar.frame)+10, 0, 40, 44);
//    }];
    _searchBar.text = nil;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    if ([UIUtil isEmptyStr:_searchBar.text]) {
        [UIUtil alert:@"请输入搜素内容"];
        return;
    }
    NSLog(@"搜索内容1；；%@",_searchBar.text);
    NSLog(@"搜索内容2；；%@",searchBar.text);
    
    if ( (![searchBar.text isEqualToString:@""] && searchBar.text != nil)  && ![self.historyArr containsObject:searchBar.text]) {
        [_historyArr addObject:_searchBar.text];
    }
    
    int i;
    BOOL isFindBool = NO;
    for ( i = 0; i<self.historyArr.count; i++) {
        
        if ([self.historyArr[i] isEqualToString:_searchBar.text]) {
            isFindBool = YES;
            break;
        }
    }
    if(isFindBool) {
         [_historyArr exchangeObjectAtIndex:0 withObjectAtIndex:i];
    }
   
    
#warning TODO 不知道什么意思
//    if (self.historyArr.count== 5) {
//        [self.historyArr removeObjectAtIndex:4];
//        [self.historyArr insertObject:_searchBar.text atIndex:0];
//    }else {
//        [self.historyArr insertObject:_searchBar.text atIndex:0];
//    }
    
    [self search];
    
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)search {
    
    if(_isFirstJoin) {
        [_historyArr removeAllObjects];
        //获取历史搜索
        NSArray *array = [[NSUserDefaults standardUserDefaults] arrayForKey:SearchHistory_UserDefault_Key];
        _historyArr = [array mutableCopy];
        _isFirstJoin = NO;
    }
    [self seaerchHistoryTable];
    
    [[NSUserDefaults standardUserDefaults] setObject:[self mugtableArrayToArray:self.historyArr] forKey:SearchHistory_UserDefault_Key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [SVProgressHUD showWithStatus:@"正在搜索"];
    _historyTable.hidden = NO;
    
    
    [_historyTable reloadData];
    //[self.viewModel FindContentsByKeyword:_searchBar.text Page:0 Size:15];
    
}


- (NSArray *)mugtableArrayToArray:(NSMutableArray *)mutableArray {
    
    NSArray *array = [[NSArray alloc] init];
    array = [mutableArray mutableCopy];
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
