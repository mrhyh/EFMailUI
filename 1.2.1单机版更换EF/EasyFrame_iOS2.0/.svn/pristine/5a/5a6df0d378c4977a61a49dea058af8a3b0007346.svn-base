//
//  GoodsCommentVC.m
//  hujinrong
//
//  Created by HqLee on 16/5/17.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFGoodsCommentVC.h"
#import "EFGoodsCommentCell.h"
#define SDEFGoodsCommentCell @"EFGoodsCommentCell"
@interface EFGoodsCommentVC ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)KYTableView * table;
@end

@implementation EFGoodsCommentVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavi];
    [self layoutViewController];
}

- (void)setupNavi{
    self.title = @"评价详情";
}

- (void)layoutViewController{
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
    [_table registerClass:[EFGoodsCommentCell class] forCellReuseIdentifier:SDEFGoodsCommentCell];
    [_table reloadData];
}
#pragma mark ---<UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EFGoodsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:SDEFGoodsCommentCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
@end
