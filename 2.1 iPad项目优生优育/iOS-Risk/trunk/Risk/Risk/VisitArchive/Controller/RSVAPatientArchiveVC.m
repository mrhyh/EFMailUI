//
//  RSVAPatientArchiveVC.m
//  Risk
//
//  Created by ylgwhyh on 16/7/7.
//  Copyright © 2016年 com.risk.kingyon. All rights reserved.
//

#import "RSVAPatientArchiveVC.h"
#import "EFCTTextField.h"
#import "RSVAriskFactorCell.h"
#import "RSVAVisitRecordCell.h"

@interface RSVAPatientArchiveVC ( ) <UITableViewDelegate, UITableViewDataSource>

//顶部模块
@property (nonatomic, strong) UIScrollView *topScrollView;
@property (nonatomic, strong) EFCTTextField *medicalRecordTextField; //病历号
@property (nonatomic, strong) EFCTTextField *nameTextField; //
@property (nonatomic, strong) EFCTTextField *phoneNumberTextField;
@property (nonatomic, strong) EFCTTextField *familyAddressTextField;
@property (nonatomic, strong) EFCTTextField *suetsugiMensesTextField; //末次月经
@property (nonatomic, strong) EFCTTextField *expectedBornDataTextField; //预产期

//孕次
@property (nonatomic, strong) KYMHButton *pregnancyNumLeftButton;
@property (nonatomic, strong) KYMHButton *pregnancyNumRightButton;
@property (nonatomic, strong) KYMHLabel *pregnancyNumLabel;
@property (nonatomic, assign) NSInteger pregnancyNumInteger;

//产次
@property (nonatomic, strong) KYMHButton *bornNumLeftButton;
@property (nonatomic, strong) KYMHButton *bornNumRightButton;
@property (nonatomic, strong) KYMHLabel *bornNumLabel;
@property (nonatomic, assign) NSInteger bornNumNumInteger;



@property (nonatomic, strong ) NSMutableArray *dataSource;


//危险因素暴露情况（左下模块）
@property (nonatomic, strong) KYTableView *leftTableView;
@property (nonatomic, strong) EFCTTextField *riskFactorTextField;
@property (nonatomic, strong) EFCTTextField *dosageTextField; //剂量
@property (nonatomic, strong) EFCTTextField *exposureTimeStartDataTextField;
@property (nonatomic, strong) EFCTTextField *exposureTimeEndDataTextField;
@property (nonatomic, strong) KYMHButton *riskAddButton;
@property (nonatomic, strong) UIView *leftHeadView;



//随访记录情况（右下模块）
@property (nonatomic, strong) KYTableView *rightTableView;
@property (nonatomic, strong) EFCTTextField *visitDataTextField;
@property (nonatomic, strong) EFCTTextField *visitResultTextField;
@property (nonatomic, strong) KYMHButton *visitAddButton;
@property (nonatomic, strong) UIView *rightHeadView;


@end

@implementation RSVAPatientArchiveVC {
    
    CGFloat commonFontSize;
    CGFloat spaceToLeft;
    CGFloat buttonH;
    CGFloat nameTextFieldW;
    CGFloat nameToTextFieldSpace;
    CGFloat textFieldSpaceToName;
    CGFloat nameLabelW;
    CGFloat addToLabelSpace;
    CGFloat topScrollViewH;
    CGFloat spaceToTopView;
    
    UIColor *textFieldBGColor;
    UIColor *buttonNotClickColor;
    
}

    static NSString * const RSVAriskFactorCell_One_ID = @"RSVAriskFactorCell_One_ID";
    static NSString * const RSVAVisitRecordCell_One_ID = @"RSVAVisitRecordCell_One_ID";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];
    [self initUI];
    
}

- (void) initData {
    
    commonFontSize = RSVisitArchiveCommonFontSize;
    spaceToLeft = 20;
    buttonH = RSVisitArchiveButtonH;
    nameTextFieldW = 160;
    nameToTextFieldSpace= 15;
    textFieldSpaceToName = 40;
    nameLabelW = 68;
    addToLabelSpace = 10;
    _pregnancyNumInteger = 0;
    _bornNumNumInteger = 0;
    topScrollViewH = 220;
    spaceToTopView = 15;
    
    
    textFieldBGColor = RSVisitArchiveTextFieldBGColor;
    buttonNotClickColor = RGBColor(121, 219, 169);
    
    _dataSource = [[NSMutableArray alloc] init];

    for (int i=0; i<3; i++ ) {
        RSVAArchivesModel *model = [[RSVAArchivesModel alloc] init];
        
       model.isSelected = NO;
        model.numberInteger = i;
        model.mensesDataString = @"2016.07.05 - 2016.07.05";
        model.exposureFactorString = @"多粘菌素B(2016.07-2016.07.07)";
        model.dosageString = @"100";
        
        if(i==0) {
            model.exposureFactorString = @"暴露因素名称";
            model.dosageString = @"剂量";
            model.mensesDataString = @"暴露时间范围";
        }

        [_dataSource addObject:model];
    }
    
}

- (void) initUI {
    
    self.title = @"患者档案";
    
    [self initNavigateView];
    [self initTopScrollView];
    [self initLeftAndRightTableView];
}

- (void) initTopScrollView {
    
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, topScrollViewH)];
    _topScrollView.bounces = YES;
    _topScrollView.scrollEnabled = YES;
    _topScrollView.backgroundColor = [UIColor whiteColor];
     _topScrollView.showsVerticalScrollIndicator = NO;
    [_topScrollView setContentSize:CGSizeMake(SCREEN_WIDTH, 220)];
    [self.view addSubview:_topScrollView];

     KYMHLabel  *staticOneLabel = [self createLabelWith:NSTextAlignmentRight text:@"病历号: "];
     KYMHLabel  *staticNameLabel = [self createLabelWith:NSTextAlignmentRight text:@"姓  名: "];
     KYMHLabel  *staticPhoneNumberLabel = [self createLabelWith:NSTextAlignmentRight text:@"联系电话: "];
     KYMHLabel  *staticFamilyAddressLabel = [self createLabelWith:NSTextAlignmentRight text:@"家庭住址: "];
     KYMHLabel  *staticFourLabel = [self createLabelWith:NSTextAlignmentRight text:@"末次月经: "];
     KYMHLabel  *staticFiveLabel = [self createLabelWith:NSTextAlignmentRight text:@"预 产 期: "];
     KYMHLabel  *staticSixLabel = [self createLabelWith:NSTextAlignmentRight text:@"孕  次: "];
     KYMHLabel  *staticSevenLabel = [self createLabelWith:NSTextAlignmentRight text:@"产  次: "];
    _pregnancyNumLabel = [self createLabelWith:NSTextAlignmentCenter text:@"0"];
    _bornNumLabel = [self createLabelWith:NSTextAlignmentCenter text:@"0"];
    
    
     _medicalRecordTextField = [self createTextFieldWith:@"病历号"];
     _nameTextField = [self createTextFieldWith:@"患者姓名"];
     _phoneNumberTextField = [self createTextFieldWith:@"联系电话"];
     _familyAddressTextField = [self createTextFieldWith:@"家庭住址"];
     _suetsugiMensesTextField = [self createTextFieldWithImage:@"末次月经日期"];
     _expectedBornDataTextField = [self createTextFieldWithImage:@"预产期"];
    
     _pregnancyNumLeftButton = [self createButtonWithTitle:@"-" action:@selector(pregnancyNumLeftButtonAction)];
     _pregnancyNumRightButton = [self createButtonWithTitle:@"+" action:@selector(pregnancyNumRightButtonAction)];
     _bornNumLeftButton = [self createButtonWithTitle:@"-" action:@selector(bornNumLeftButtonAction)];
     _bornNumRightButton = [self createButtonWithTitle:@"+" action:@selector(bornNumRightButtonAction)];
    [self initButtonStatus];
    
     NSArray *views = @[staticOneLabel, staticNameLabel, staticPhoneNumberLabel,
                       staticFamilyAddressLabel, staticFourLabel, staticFiveLabel,
                       staticSixLabel, staticSevenLabel, _medicalRecordTextField,
                        _nameTextField, _phoneNumberTextField,_familyAddressTextField,
                       _suetsugiMensesTextField, _expectedBornDataTextField,_pregnancyNumLeftButton,
                       _pregnancyNumRightButton, _bornNumLeftButton,_bornNumRightButton,
                        _pregnancyNumLabel, _bornNumLabel
                       ];
    
     [_topScrollView sd_addSubviews:views];
     UIView *contentView = _topScrollView;
    

    //第一行第一个
    staticOneLabel.sd_layout
    .topSpaceToView(contentView, 15)
    .leftSpaceToView(contentView, spaceToLeft)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _medicalRecordTextField.sd_layout
    .topEqualToView(staticOneLabel)
    .leftSpaceToView(staticOneLabel, 15)
    .widthIs(nameTextFieldW)
    .heightIs(buttonH);
    
    //患者姓名
    staticNameLabel.sd_layout
    .topEqualToView(staticOneLabel)
    .leftSpaceToView(_medicalRecordTextField,textFieldSpaceToName)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _nameTextField.sd_layout
    .topEqualToView(staticOneLabel)
    .leftSpaceToView(staticNameLabel, nameToTextFieldSpace)
    .widthIs(nameTextFieldW)
    .heightIs(buttonH);
    
    
    //联系电话

    staticPhoneNumberLabel.sd_layout
    .topEqualToView(staticOneLabel)
    .leftSpaceToView(_nameTextField, textFieldSpaceToName)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _phoneNumberTextField.sd_layout
    .topEqualToView(staticOneLabel)
    .leftSpaceToView (staticPhoneNumberLabel, nameToTextFieldSpace)
    .rightSpaceToView(contentView, 2*spaceToLeft)
    .heightIs(buttonH);
    

    
    //第二行第二个
    staticFamilyAddressLabel.sd_layout
    .topSpaceToView(staticOneLabel, 20)
    .leftSpaceToView(contentView, spaceToLeft)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _familyAddressTextField.sd_layout
    .topEqualToView(staticFamilyAddressLabel)
    .leftSpaceToView(staticFamilyAddressLabel, nameToTextFieldSpace)
    .rightSpaceToView(contentView, 2*spaceToLeft)
    .heightIs(buttonH);
    
    
     //第三行第三个
    
    //末次月经
    staticFourLabel.sd_layout
    .topSpaceToView(staticFamilyAddressLabel, 20)
    .leftSpaceToView(contentView, spaceToLeft)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _suetsugiMensesTextField.sd_layout
    .topEqualToView(staticFourLabel)
    .leftSpaceToView(staticFourLabel, nameToTextFieldSpace)
    .widthIs(nameTextFieldW)
    .heightIs(buttonH);
    
    
    //预产期
    staticFiveLabel.sd_layout
    .topEqualToView(staticFourLabel)
    .leftSpaceToView(_suetsugiMensesTextField, textFieldSpaceToName)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _expectedBornDataTextField.sd_layout
    .topEqualToView(staticFourLabel)
    .leftSpaceToView(staticFiveLabel, nameToTextFieldSpace)
    .widthIs(nameTextFieldW)
    .heightIs(buttonH);
    
    //产次
    _bornNumRightButton.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(contentView, 2*spaceToLeft)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
    _bornNumLabel.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(_bornNumRightButton, addToLabelSpace)
    .widthIs(20)
    .heightIs(buttonH);
    
    _bornNumLeftButton.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(_bornNumLabel, 10)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
    staticSevenLabel.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(_bornNumLeftButton, nameToTextFieldSpace)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    

    //孕次
    _pregnancyNumRightButton.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(staticSevenLabel, textFieldSpaceToName)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
    _pregnancyNumLabel.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(_pregnancyNumRightButton, 10)
    .widthIs(20)
    .heightIs(buttonH);
    
    _pregnancyNumLeftButton.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(_pregnancyNumLabel, 10)
    .widthIs(buttonH)
    .heightIs(buttonH);
    
    staticSixLabel.sd_layout
    .topEqualToView(staticFourLabel)
    .rightSpaceToView(_pregnancyNumLeftButton, 10)
    .widthIs(nameLabelW)
    .heightIs(buttonH);

    
}

- (void) initButtonStatus {
    
    if(_pregnancyNumInteger<=0  ) {
        
        [self setButtonNoCanClick:_pregnancyNumLeftButton];
    }
    
    if(_bornNumNumInteger<=0  ) {
        
        [self setButtonNoCanClick:_bornNumLeftButton];
    }
    
}

- (void ) initLeftAndRightTableView {
    
    CGFloat tableViewH =  SCREEN_HEIGHT-topScrollViewH;
    CGFloat tableViewY = topScrollViewH+1;
    
    _leftTableView = [self createTableViewWithFrame:CGRectMake(0, tableViewY, SCREEN_WIDTH/2-0.5,tableViewH) cellID:RSVAriskFactorCell_One_ID tableViewCell:[RSVAriskFactorCell class]];
    [self.view addSubview:_leftTableView];
    
    _rightTableView = [self createTableViewWithFrame:CGRectMake(SCREEN_WIDTH/2+0.5, tableViewY, SCREEN_WIDTH/2, tableViewH) cellID:RSVAVisitRecordCell_One_ID tableViewCell:[RSVAVisitRecordCell class]];
    [self.view addSubview:_rightTableView];
    
}


- (void)initNavigateView{
    
    UIColor *textColorButtonSelected = EF_TextColor_TextColorButtonSelected;
    UIButton * btn= [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 66, 44)];
    [btn addTarget:self action:@selector(navigationRightAction) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"保存" forState:UIControlStateNormal];
    [btn setTitleColor:textColorButtonSelected forState:UIControlStateSelected];
    UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = barBtnItem;
    
    
    KYMHButton * centerBtn= [[KYMHButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2, 0, 132, 44)];
    [centerBtn addTarget:self action:@selector(navigationCenterButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [centerBtn setTitle:@"患者档案" forState:UIControlStateNormal];
    [centerBtn setTitleColor:textColorButtonSelected forState:UIControlStateSelected];
    [centerBtn setImage:Img(@"right_menu") forState:UIControlStateNormal];
    [centerBtn horizontalCenterTitleAndImage];

    self.navigationItem.titleView = centerBtn;
}










#pragma mark Create UI



- (KYTableView *) createTableViewWithFrame:(CGRect )frame cellID:(NSString *)cellID tableViewCell: (Class )cellClass {
    
    KYTableView *tableView = [[KYTableView alloc]initWithFrame:frame andUpBlock:^{
        
        [_leftTableView endLoading];
        [_rightTableView endLoading];

    } andDownBlock:^{
        
        [_leftTableView endLoading];
        [_rightTableView endLoading];
        
    }];
    
    tableView.showsVerticalScrollIndicator = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [tableView registerClass:cellClass forCellReuseIdentifier:cellID];

    return tableView;
}


- (KYMHButton *)createButtonWithTitle: (NSString *)title  action:(SEL)action {
    
   KYMHButton *button = [KYMHButton new];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = Font(smallFontSize);
    [button setBackgroundImage:[UIImage imageWithColor:RSVisitArchiveButtonColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = 5;
    button.titleLabel.font = Font(middleFontSize);
    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}



- ( EFCTTextField *)createTextFieldWith: (NSString *)placeholder {
    
    EFCTTextField *textField = [EFCTTextField new];
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.backgroundColor = textFieldBGColor;
    textField.layer.cornerRadius = 5;
    textField.font = Font(RSVisitArchiveCommonFontSize);
    textField.layer.borderColor = textFieldBGColor.CGColor;
    textField.backgroundColor = textFieldBGColor;
    
    return textField;
}

- ( EFCTTextField *)createTextFieldWithImage: (NSString *)placeholder {
    
    EFCTTextField *textField = [self createTextFieldWithImageName:@"calendar" text:placeholder];
    
    return textField;
}


- ( EFCTTextField *)createTextFieldWithImageName: (NSString *)imageName text: (NSString *)placeholder {
    
    
    EFCTTextField *textField = [EFCTTextField new];
    textField.placeholder = placeholder;
    textField.textAlignment = NSTextAlignmentLeft;
    textField.backgroundColor = textFieldBGColor;
    textField.layer.cornerRadius = 5;
    textField.font = Font(RSVisitArchiveCommonFontSize);
    textField.layer.borderColor = textFieldBGColor.CGColor;
    textField.backgroundColor = textFieldBGColor;
    
    
    KYMHImageView *imageView = [KYMHImageView new];
    imageView.image = Img(imageName);
    [textField addSubview:imageView];
    
    imageView.sd_layout
    .centerYEqualToView(textField)
    .rightSpaceToView(textField, 5)
    .heightIs(buttonH-10)
    .widthIs(buttonH-10);
    
    return textField;
}


- (KYMHLabel *)createLabelWithTitle:(NSString *)text{
     KYMHLabel  *label = [self createLabelWith:NSTextAlignmentLeft text:text];
    return label;
}

- (KYMHLabel *)createLabelWith:(NSTextAlignment )textAlignment text:(NSString *)text{
    
    KYMHLabel  *label = [KYMHLabel new];
    label.font = Font(RSVisitArchiveCommonFontSize);
    label.textColor = EF_TextColor_TextColorPrimary;
    label.text = text;
    label.textAlignment = textAlignment;
    return label;
}

- (void) createLeftHeadView: (UIView *)view{
    
    //_leftHeadView
    
    KYMHLabel *staticLTVOneLabel = [self createLabelWithTitle:@"【危险因素暴露情况】"];
    KYMHLabel *staticLTVTwoLabel = [self createLabelWithTitle:@"风险因素: "];
    KYMHLabel *staticLTVThreeLabel = [self createLabelWithTitle:@"剂量: "];
    KYMHLabel *staticLTVFourLabel = [self createLabelWithTitle:@"暴露时间: "];
    KYMHLabel *staticLTVLineLabel=[self createLabelWith:NSTextAlignmentCenter text:@"-"];
    

    _riskFactorTextField = [self createTextFieldWithImageName:@"ic_searchbar_search" text:@"点击选择风险因素"];
    _dosageTextField = [self createTextFieldWith:@"剂量"];
    _exposureTimeStartDataTextField = [self createTextFieldWithImage:@"开始如期"];
    _exposureTimeEndDataTextField = [self createTextFieldWithImage:@"结束日期"];
    _riskAddButton = [self createButtonWithTitle:@"+添  加" action:@selector(riskAddButtonAction)];
     _riskAddButton.titleLabel.font = Font(smallFontSize);

    NSArray *views = @[staticLTVOneLabel, staticLTVTwoLabel, staticLTVThreeLabel, staticLTVFourLabel ,  staticLTVLineLabel, _riskFactorTextField , _dosageTextField ,_exposureTimeStartDataTextField  ,_exposureTimeEndDataTextField, _riskAddButton];
    
    [view sd_addSubviews:views];
    UIView *contentView = view;
    
    staticLTVOneLabel.sd_layout
    .leftSpaceToView(contentView, spaceToLeft)
    .topSpaceToView(contentView, spaceToTopView)
    .widthIs(200)
    .heightIs(buttonH);
    
    staticLTVTwoLabel.sd_layout
    .leftSpaceToView(contentView, spaceToLeft)
    .topSpaceToView(staticLTVOneLabel, spaceToTopView)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    
    //剂量TextField
    
    _dosageTextField.sd_layout
    .rightSpaceToView(contentView, spaceToLeft)
    .topEqualToView(staticLTVTwoLabel)
    .widthIs(70)
    .heightIs(buttonH);
    
    staticLTVThreeLabel.sd_layout
    .rightSpaceToView(_dosageTextField, nameToTextFieldSpace)
    .topEqualToView(staticLTVTwoLabel)
    .widthIs(40)
    .heightIs(buttonH);
    

    _riskFactorTextField.sd_layout
    .leftSpaceToView(staticLTVTwoLabel, nameToTextFieldSpace)
    .rightSpaceToView(staticLTVThreeLabel, textFieldSpaceToName)
    .topEqualToView(staticLTVTwoLabel)
    .heightIs(buttonH);
    
    
    //暴露时间
    staticLTVFourLabel.sd_layout
    .leftSpaceToView(contentView, spaceToLeft)
    .topSpaceToView(staticLTVTwoLabel, spaceToTopView)
    .widthIs(nameLabelW)
    .heightIs(buttonH);
    
    _exposureTimeStartDataTextField.sd_layout
    .leftSpaceToView(staticLTVFourLabel, nameToTextFieldSpace)
    .topEqualToView(staticLTVFourLabel)
    .widthIs(nameTextFieldW-20)
    .heightIs(buttonH);
    
    
    //添加
    _riskAddButton.sd_layout
    .rightSpaceToView(contentView, spaceToLeft)
    .topEqualToView(staticLTVFourLabel)
    .widthIs(70)
    .heightIs(buttonH-2);
    
    _exposureTimeEndDataTextField.sd_layout
    .rightSpaceToView(_riskAddButton, spaceToLeft)
    .topEqualToView(staticLTVFourLabel)
    .widthIs(nameTextFieldW-20)
    .heightIs(buttonH);
    
    staticLTVLineLabel.sd_layout
    .topEqualToView(staticLTVFourLabel)
    .leftSpaceToView(_exposureTimeStartDataTextField, 0)
    .rightSpaceToView(_exposureTimeEndDataTextField, 0)
    .heightIs(buttonH);
}

- (void) createRightHeadView: (UIView *)view{
    
    KYMHLabel *staticRTVOneLabel = [self createLabelWithTitle:@"【随访记录情况】"];
    KYMHLabel *staticRTVTwoLabel = [self createLabelWithTitle:@"日期: "];
    KYMHLabel *staticRTVFourLabel = [self createLabelWithTitle:@"结果: "];
    
    _visitDataTextField = [self createTextFieldWithImage:@"随访日期"];
    _visitResultTextField = [self createTextFieldWith:@"随访结果"];
    
     _visitAddButton = [self createButtonWithTitle:@"+添  加" action:@selector(visitAddButtonAction)];
     _visitAddButton.titleLabel.font = Font(smallFontSize);
    
    NSArray *views = @[staticRTVOneLabel, staticRTVTwoLabel, staticRTVFourLabel, _visitDataTextField ,  _visitResultTextField, _visitAddButton ];
    
    [view sd_addSubviews:views];
    UIView *contentView = view;
    
    staticRTVOneLabel.sd_layout
    .leftSpaceToView(contentView, spaceToLeft)
    .topSpaceToView(contentView, spaceToTopView)
    .widthIs(200)
    .heightIs(buttonH);
    
    //日期
    staticRTVTwoLabel.sd_layout
    .leftSpaceToView(contentView, spaceToLeft)
    .topSpaceToView(staticRTVOneLabel, spaceToTopView)
    .widthIs(40)
    .heightIs(buttonH);
    
    _visitDataTextField.sd_layout
    .leftSpaceToView(staticRTVTwoLabel, spaceToLeft)
    .topEqualToView(staticRTVTwoLabel)
    .widthIs(nameTextFieldW-35)
    .heightIs(buttonH);
    
    
    staticRTVFourLabel.sd_layout
    .leftSpaceToView(_visitDataTextField, nameToTextFieldSpace)
    .topEqualToView(staticRTVTwoLabel)
    .widthIs(40)
    .heightIs(buttonH);
    
    _visitAddButton.sd_layout
    .topEqualToView(staticRTVTwoLabel)
    .rightSpaceToView(contentView, 2 *spaceToLeft)
    .widthIs(70)
    .heightIs(buttonH);
    
    _visitResultTextField.sd_layout
    .topEqualToView(staticRTVTwoLabel)
    .leftSpaceToView(staticRTVFourLabel, nameToTextFieldSpace)
    .rightSpaceToView(_visitAddButton, spaceToLeft)
    .heightIs(buttonH);

}

#pragma mark Button Action 

- (void ) visitAddButtonAction {
    
    NSLog(@"visitAddButtonAction");
}

- (void ) riskAddButtonAction {
    
    NSLog(@"riskAddButtonAction");
}

- (void ) navigationCenterButtonAction {
    
    NSLog(@"navigationCenterButtonAction");
}

- (void ) navigationRightAction {
    
    NSLog(@"navigationRightAction");
}

- (void ) pregnancyNumLeftButtonAction {
    
    NSLog(@"pregnancyNumLeftButtonAction");
    _pregnancyNumInteger--;
    if(_pregnancyNumInteger<=0  ) {
        _pregnancyNumInteger = 0;

        [self setButtonNoCanClick:_pregnancyNumLeftButton];
    }
    
    _pregnancyNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_pregnancyNumInteger];
    
    
}

- (void ) pregnancyNumRightButtonAction {
    
    NSLog(@"pregnancyNumRightButtonAction");
    _pregnancyNumInteger++;
    
    if(_pregnancyNumInteger > 0) {
        [self setButtonCanClick:_pregnancyNumLeftButton];
    }
    
     _pregnancyNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_pregnancyNumInteger];
}




- (void ) bornNumLeftButtonAction {
    
    NSLog(@"bornNumLeftButtonAction");
    _bornNumNumInteger--;
    if(_bornNumNumInteger<=0  ) {
        _bornNumNumInteger = 0;
        
        [self setButtonNoCanClick:_bornNumLeftButton];
        
    }
    
    _bornNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_pregnancyNumInteger];
}

- (void ) bornNumRightButtonAction {
    
    NSLog(@"bornNumRightButtonAction");
    _bornNumNumInteger++;
    
    if(_bornNumNumInteger > 0  ) {
        [self setButtonCanClick:_bornNumRightButton];
    }
    
    _bornNumLabel.text = [NSString stringWithFormat:@"%ld",(long)_bornNumNumInteger];
}

#pragma mark setButtonIsCanClick

- (void) setButtonCanClick:(KYMHButton *)button  {
    button.enabled = YES;
    [button setBackgroundImage:[UIImage imageWithColor:RSVisitArchiveButtonColor] forState:UIControlStateNormal];
}

- (void) setButtonNoCanClick:(KYMHButton *)button  {
    button.enabled = NO;
    [button setBackgroundImage:[UIImage imageWithColor:buttonNotClickColor] forState:UIControlStateNormal];
}


#pragma mark TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    WS(weakSelf)
    if(tableView == _leftTableView ) {
        
        RSVAriskFactorCell *cell = [tableView dequeueReusableCellWithIdentifier:RSVAriskFactorCell_One_ID];
        
        if(_dataSource.count > 0) {
            RSVAArchivesModel *model = _dataSource[indexPath.row];
            cell.model = model;
        }
        if(indexPath.row == 0) {
            cell.backgroundColor = RSVisitArchiveTableViewHeadSectionBGColor;
        }
        
        __block typeof(cell)wsCell = cell;
        [wsCell RSVAriskFactorCellHeadSelectBlock:^(BOOL isSelected) {
            if(indexPath.row == 0) { //全选
                //启动表格的编辑模式
                [weakSelf.leftTableView setEditing:YES animated:NO];
            }

        }];
        
        
        return cell;
        
    } else {
        
        RSVAVisitRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:RSVAVisitRecordCell_One_ID];
        
        if(_dataSource.count > 0) {
            RSVAArchivesModel *model = _dataSource[indexPath.row];
            cell.model = model;
        }
        if(indexPath.row == 0) {
            cell.backgroundColor = RSVisitArchiveTableViewHeadSectionBGColor;
        }
        
        __block typeof(cell)wsCell = cell;
        [wsCell RSVAVisitRecordCellHeadSelectBlock:^(BOOL isSelected) {
            if(indexPath.row == 0) { //全选
                //启动表格的编辑模式
                [weakSelf.leftTableView setEditing:YES animated:YES];
            }
            
        }];
        
        return cell;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataSource.count;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    if(_dataSource.count > 0) {
//        id model = _dataSource[indexPath.row];
//        
//        if(tableView == _leftTableView ) {
//            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RSVAriskFactorCell class] contentViewWidth:[self cellContentViewWith]];
//        }else {
//            return [tableView cellHeightForIndexPath:indexPath model:model keyPath:@"model" cellClass:[RSVAVisitRecordCell class] contentViewWidth:[self cellContentViewWith]];
//        }
//        
//    }else {
//        return  0;
//    }
//   
//}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    
    return width;
}

#pragma mark TableView Delegate

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if(tableView == _leftTableView) {
        if (_leftHeadView == nil ) {
            _leftHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 140)];
        }

        //_leftHeadView.backgroundColor = [UIColor grayColor];
        [self createLeftHeadView:_leftHeadView];
        
        return _leftHeadView;
    }else {
        
        if (_rightHeadView == nil ) {
            _rightHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH/2, 95)];
        }
        //_rightHeadView.backgroundColor = [UIColor grayColor];
        [self  createRightHeadView:_rightHeadView];
        return _rightHeadView;

    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (tableView == _leftTableView ) {
        return  140;
    }else {
        return 95;
    }

}


@end
