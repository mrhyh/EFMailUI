//
//  RSMoreDataVC.m
//  Risk
//
//  Created by Cherie Jeong on 16/7/7.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSMoreDataVC.h"
#import "MoreDataCollectionViewCell.h"
#import "RSDataVC.h"


#define MoreDataCollectionCell @"MoreDataCollectionCell"

@interface RSMoreDataVC ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * moreCollectionView;
@property (nonatomic,assign) CGFloat  moreCellH;

@end

@implementation RSMoreDataVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.titleString;
    
     _moreCellH = (SCREEN_HEIGHT-64)/9;
    
    [self initCollectionView];
    
   
    
}


- (void)initCollectionView {
    //确定是水平滚动，还是垂直滚动
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.itemSize = CGSizeMake(SCREEN_WIDTH/3, _moreCellH);
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    _moreCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:flowLayout];
    [_moreCollectionView setBackgroundColor:[UIColor whiteColor]];
    _moreCollectionView.delegate = self;
    _moreCollectionView.dataSource = self;
    _moreCollectionView.pagingEnabled = YES;
    _moreCollectionView.showsVerticalScrollIndicator = NO;
    _moreCollectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_moreCollectionView];
    
    //注册cell
    [_moreCollectionView registerClass:[MoreDataCollectionViewCell class] forCellWithReuseIdentifier:MoreDataCollectionCell];

}

#pragma mark -- UICollectionViewDataSource

//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 48;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    MoreDataCollectionViewCell * cell = (MoreDataCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:MoreDataCollectionCell forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.layer.borderWidth = 0.25;
    cell.layer.borderColor = [EFSkinThemeManager  getTextColorWithKey:SkinThemeKey_BlackDivider].CGColor;
    
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout

////定义每个Item 的大小
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return CGSizeMake(60, 60);
//}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSLog(@"item======%ld",(long)indexPath.item);
    NSLog(@"row=======%ld",(long)indexPath.row);
    NSLog(@"section===%ld",(long)indexPath.section);
}


//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
