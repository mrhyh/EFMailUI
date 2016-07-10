//
//  EFAgencyInfoVC.m
//  EF_MallDemo
//
//  Created by HqLee on 16/6/15.
//  Copyright © 2016年 MH. All rights reserved.
//

#import "EFAgencyInfoVC.h"
#import "EFAgencyInfoCell.h"
#import "EFAgencyPictureCell.h"

static NSString *const commonCellID = @"commonCellID";
static NSString *const infoCellID = @"infoCellID";
static NSString *const pictureCellID = @"pictureCellID";

@interface EFAgencyInfoVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation EFAgencyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"机构信息";
    [self setupTableView];
}

- (void)setupTableView{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.sectionFooterHeight = 0;
    tableView.sectionHeaderHeight = 10;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:commonCellID];
    [tableView registerClass:NSClassFromString(@"EFAgencyInfoCell") forCellReuseIdentifier:infoCellID];
    [tableView registerClass:NSClassFromString(@"EFAgencyPictureCell") forCellReuseIdentifier:pictureCellID];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    tableView.sd_layout.spaceToSuperView(UIEdgeInsetsZero);
    UIImageView *imageView = [[UIImageView alloc] init];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://img10.3lian.com/c1/newpic/10/24/29.jpg"] placeholderImage:[UIImage imageNamed:@""]];
    imageView.size = CGSizeMake(SCREEN_WIDTH, 160);
    tableView.tableHeaderView = imageView;
}

#pragma mark --- <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 2;
    }
    else if (section == 1){
        return 1;
    }else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:commonCellID];
        UIView *separateLine = [[UIView alloc] init];
        separateLine.backgroundColor = RGBColor(238, 246, 250);
        separateLine.frame = CGRectMake(10, 43, SCREEN_WIDTH - 20, 1);
        [cell.contentView addSubview:separateLine];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (indexPath.row == 0) {
            cell.imageView.image = [UIImage imageNamed:@"ic_share_qq"];
            cell.textLabel.text = @"成都市武侯区桐梓林北路2号凯莱帝景花园C-5-C";
            separateLine.hidden = NO;
        }else {
            cell.imageView.image = [UIImage imageNamed:@"ic_share_qq"];
            cell.textLabel.text = @"028456110";
            separateLine.hidden = YES;
        }
        return cell;
    }else if (indexPath.section == 1){
        EFAgencyInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:infoCellID];
        cell.agencyInfo = @"嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻";
        return cell;
    }else{
        EFAgencyPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:pictureCellID];
        cell.imageUrls = @[@"http://img10.3lian.com/c1/newpic/10/24/29.jpg",@"http://img10.3lian.com/c1/newpic/10/24/29.jpg",@"http://img10.3lian.com/c1/newpic/10/24/29.jpg",@"http://img10.3lian.com/c1/newpic/10/24/29.jpg",@"http://img10.3lian.com/c1/newpic/10/24/29.jpg",@"http://img10.3lian.com/c1/newpic/10/24/29.jpg",@"http://img10.3lian.com/c1/newpic/10/24/29.jpg"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 44;
    }else if (indexPath.section == 1){
        NSString *agencyInfo = @"嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻嘻";
        CGFloat textHeight = [agencyInfo boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:15]} context:nil].size.height;
        return textHeight + 50;
    }else{
        return (SCREEN_WIDTH - 70) / 4.0 + 60;
    }
}
@end
