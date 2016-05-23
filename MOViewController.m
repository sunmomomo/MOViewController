//
//  MOViewController.m
//
//  Created by 馍馍帝😈 on 16/1/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#define NaviColor UIColorFromRGB(0x4e4e4e)

#define NaviTitleColor UIColorFromRGB(0xffffff)

#define NaviFont [UIFont boldSystemFontOfSize:IPhone4_5_6_6P(16, 16, 17, 18)]

@interface TitleButton : UIButton

{
    
    UILabel *_titleLabel;
    
    UIImageView *_arrowImg;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)CGFloat maxTitleRight;

@property(nonatomic,strong)UIColor *titleColor;

@end

@implementation TitleButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, frame.size.height)];
        
        _titleLabel.font = NaviFont;
        
        _titleLabel.textColor = NaviTitleColor;
        
        _titleLabel.userInteractionEnabled = NO;
        
        [self addSubview:_titleLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+8, frame.size.height/2-3, 10.6, 6)];
        
        _arrowImg.image = [UIImage imageNamed:@"white_down_arrow"];
        
        [self addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setTitleColor:(UIColor *)titleColor
{
    
    _titleColor = titleColor;
    
    _titleLabel.textColor = _titleColor;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    [_titleLabel autoWidth];
    
    if (self.maxTitleRight) {
        
        if (_titleLabel.right+28.6>self.maxTitleRight) {
            
            [_titleLabel changeWidth:self.maxTitleRight-_titleLabel.left-28.6];
            
        }
        
    }else
    {
        
        if (_titleLabel.width>MSW-100) {
            
            [_titleLabel changeWidth:MSW-100];
            
        }
        
    }
    
    _titleLabel.center = CGPointMake(self.width/2, _titleLabel.center.y);
    
    [_arrowImg changeLeft:_titleLabel.right+8];
    
}

@end

@interface NumView : UIView

{
    
    UILabel *_numLabel;
    
}

@property(nonatomic,assign)NSInteger num;

@end

@implementation NumView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.layer.cornerRadius = frame.size.width/2;
        
        self.layer.masksToBounds = YES;
        
        self.layer.borderColor =  UIColorFromRGB(0x4e4e4e).CGColor;
        
        self.layer.borderWidth = 2;
        
        self.hidden = YES;
        
        _numLabel = [[UILabel alloc]initWithFrame:CGRectMake(2, 2, frame.size.width-4, frame.size.height-4)];
        
        _numLabel.backgroundColor = UIColorFromRGB(0xea6161);
        
        _numLabel.textColor = UIColorFromRGB(0xffffff);
        
        _numLabel.textAlignment = NSTextAlignmentCenter;
        
        _numLabel.font = STFont(12);
        
        _numLabel.adjustsFontSizeToFitWidth = YES;
        
        _numLabel.layer.cornerRadius = _numLabel.width/2;
        
        _numLabel.layer.masksToBounds = YES;
        
        _numLabel.layer.borderWidth = 1;
        
        _numLabel.layer.borderColor = UIColorFromRGB(0xffffff).CGColor;
        
        [self addSubview:_numLabel];
        
    }
    
    return self;
    
}

-(void)setNum:(NSInteger)num
{
    
    _num = num;
    
    if (_num &&_num<100) {
        
        self.hidden = NO;
        
        _numLabel.text = [NSString stringWithFormat:@"%ld",(long)_num];
        
    }else if (_num &&_num>=100) {
        
        self.hidden = NO;
        
        _numLabel.text = @"99";
        
    }else
    {
        
        self.hidden = YES;
        
    }
    
}


@end

@interface NaviButton : UIButton

{
    
    UIImageView *_imgView;
    
    UILabel *_label;
    
}

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,copy)NSString *title;

@end

@implementation NaviButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width*0.4, frame.size.height*0.4)];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
        _imgView.center = CGPointMake(self.width/2, self.height/2);
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        _label.textAlignment = NSTextAlignmentRight;
        
        _label.textColor = kMainColor;
        
        _label.font = STFont(14);
        
        _label.userInteractionEnabled = NO;
        
        [self addSubview:_label];
        
    }
    
    return self;
    
}

-(void)changeWidth:(CGFloat)width
{
    
    [super changeWidth:width];
    
    [_label changeWidth:width];
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imgView.image = _image;
    
    _label.hidden = YES;
    
    _imgView.hidden = NO;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    if (_title.length) {
        
        _label.text = _title;
        
        _label.hidden = NO;
        
        _imgView.hidden = YES;
        
    }else
    {
        
        _label.hidden = YES;
        
        _imgView.hidden = YES;
        
    }
    
}

-(void)setTitleColor:(UIColor *)color forState:(UIControlState)state
{
    
    [super setTitleColor:color forState:state];
    
    _label.textColor = color;
    
}

@end

@interface MONaviView ()

{
    
    NaviButton *_leftButton;
    
    UILabel *_titleLabel;
    
    TitleButton *_titleButton;
    
    NaviButton *_rightButton;
    
    NumView *_numView;
    
    NaviButton *_rightSubButton;
    
    UIView *_line;
    
}

@property(nonatomic,assign)BOOL shadowHidden;

@property(nonatomic,strong)UIImage *leftImg;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,strong)UIColor *rightColor;

@end

@implementation MONaviView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = NaviColor;
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_line];
        
        _leftButton = [[NaviButton alloc]initWithFrame:CGRectMake(0, 20, 48, 48)];
        
        [self addSubview:_leftButton];
        
        _rightButton = [[NaviButton alloc]initWithFrame:CGRectMake(MSW-48, 20, 48, 48)];
        
        [_rightButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        [self addSubview:_rightButton];
        
        _rightSubButton = [[NaviButton alloc]initWithFrame:CGRectMake(MSW-101, 20, 48, 48)];
        
        [self addSubview:_rightSubButton];
        
        _numView = [[NumView alloc]initWithFrame:CGRectMake(MSW-25, 28, 22, 22)];
        
        [self addSubview:_numView];
        
        _titleButton = [[TitleButton alloc]initWithFrame:CGRectMake(_leftButton.right+10, 20, MSW-_leftButton.width*2-32, 44)];
        
        [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_titleButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftButton.right+10, 20, MSW-_leftButton.width*2-20, 44)];
        
        _titleLabel.textColor = NaviTitleColor;
        
        _titleLabel.font = NaviFont;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        
        self.titleType = MONaviTitleTypeLabel;
        
    }
    
    return self;
    
}

-(void)setTitleColor:(UIColor *)titleColor
{
    
    _titleColor = titleColor;
    
    _titleLabel.textColor = _titleColor;
    
    _titleButton.titleColor = _titleColor;
    
}

-(void)setMsgNum:(NSInteger)msgNum
{
    
    _msgNum = msgNum;
    
    _numView.num = _msgNum;
    
}

-(void)setTitleType:(MONaviTitleType)titleType
{
    
    _titleType = titleType;
    
    if (_titleType == MONaviTitleTypeLabel) {
        
        _titleButton.hidden = YES;
        
        _titleLabel.hidden = NO;
        
    }else
    {
        
        _titleButton.hidden = NO;
        
        _titleLabel.hidden = YES;
        
    }
    
}

-(void)setShadowHidden:(BOOL)shadowHidden
{
    
    _shadowHidden = shadowHidden;
    
    _line.hidden = shadowHidden;
    
}

-(void)setMaxTitleRight:(CGFloat)maxTitleRight
{
    
    _maxTitleRight = maxTitleRight;
    
    _titleButton.maxTitleRight = _maxTitleRight;
    
}

-(void)setLeftImg:(UIImage *)leftImg
{
    
    _leftImg = leftImg;
    
    _leftButton.image = _leftImg;
    
    [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setLeftType:(MONaviLeftType)leftType
{
    
    _leftType = leftType;
    
    switch (_leftType) {
        case MONaviLeftTypeBack:
            
            _leftButton.image = [UIImage imageNamed:@"navi_back"];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypePage:
            _leftButton.image = [UIImage imageNamed:@"page"];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeClose:
            
            _leftButton.image = [UIImage imageNamed:@"navi_close"];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviLeftTypeNO:
            _leftButton.image = nil;
            
            [_leftButton removeTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            break;
        default:
            break;
    }
    
}

-(void)setRightSubType:(MONaviRightSubType)rightSubType
{
    
    _rightSubType = rightSubType;
    
    switch (_rightSubType) {
        case MONaviRightSubTypeSearch:
            
            _maxTitleRight = _rightSubButton.left;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_search"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self bringSubviewToFront:_rightSubButton];
            
            break;
        
        case MONaviRightSubTypeNO:
            
            _maxTitleRight = _rightButton.left;
            
            [_rightSubButton setImage:nil];
            
            [_rightSubButton removeTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
        default:
            break;
    }
    
}

-(void)setRightType:(MONaviRightType)rightType
{
    
    _rightType = rightType;
    
    switch (_rightType) {
        case MONaviRightTypeAdd:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_add"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeEdit:
            
            [_rightButton setImage:[UIImage imageNamed:@"edit"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeRing:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_ring"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeEditDisable:
            
            [_rightButton setImage:[UIImage imageNamed:@"edit_disable"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeTrash:
            
            [_rightButton setImage:[UIImage imageNamed:@"trash"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeShare:
            
            [_rightButton setImage:[UIImage imageNamed:@"share"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeCheck:
            
            [_rightButton setImage:[UIImage imageNamed:@"check"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeMore:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_more"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeTitle:
            
            [_rightButton setImage:nil];
            
            [_rightButton changeLeft:MSW-101];
            
            [_rightButton changeWidth:81];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeSearch:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_search"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeNO:
            
            [_rightButton setImage:nil];
            
            [_rightButton setTitle:@""];
            
            [_rightButton removeTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        default:
            break;
    }
    
}

-(void)setRightColor:(UIColor *)rightColor
{
    
    _rightColor = rightColor;
    
    [_rightButton setTitleColor:rightColor forState:UIControlStateNormal];
    
}

-(void)setRightTitle:(NSString *)rightTitle
{
    
    _rightTitle = rightTitle;
    
    if (_rightTitle.length&&_rightType != MONaviRightTypeTitle) {
        
        self.rightType = MONaviRightTypeTitle;
        
    }
    
    _rightButton.title = rightTitle;
    
}

-(void)leftClick:(NaviButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviLeftClick)]) {
        
        [_delegate naviLeftClick];
        
    }else
    {
        
        if ([_delegate isKindOfClass:[UIViewController class]]) {
            
            UIViewController *vc = (UIViewController*)_delegate;
            
            if ([vc.navigationController.visibleViewController isKindOfClass:[vc superclass]]) {
                
                [vc.navigationController popViewControllerAnimated:YES];
                
            }
            
        }
        
    }
    
}

-(void)rightClick:(NaviButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviRightClick)]) {
        
        [_delegate naviRightClick];
        
    }
    
}

-(void)rightSubClick:(NaviButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviRightSubClick)]) {
        
        [_delegate naviRightSubClick];
        
    }
    
}

-(void)titleClick:(UIButton*)btn
{
    
    if ([_delegate respondsToSelector:@selector(naviTitleClick)]) {
        
        [_delegate naviTitleClick];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
    _titleButton.title = _title;
    
}

@end

@interface MOViewController ()

{
    
    MBProgressHUD *_defaultHUD;
    
    MONaviView *_navi;
    
}

@end

@implementation MOViewController

-(void)reloadData
{
    
    
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _defaultHUD = [[MBProgressHUD alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
        
        _navi = [[MONaviView alloc]initWithFrame:CGRectMake(0, 0, MSW, 65)];
        
        _navi.shadowHidden = _shadowType == MONaviShadowTypeDefault;
        
        _navi.leftType = MONaviLeftTypeBack;
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [self.view bringSubviewToFront:_navi];
    
}

-(void)viewDidLoad
{
    
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self.view addSubview:_navi];
    
    _navi.delegate = self;
    
    _navi.title = self.title;
    
    [self.view addSubview:_defaultHUD];
    
}

-(void)setRightTitle:(NSString *)rightTitle
{
    
    _navi.rightTitle = rightTitle;
    
}

-(void)setRightColor:(UIColor *)rightColor
{
    
    _rightColor = rightColor;
    
    _navi.rightColor = rightColor;
    
}

-(void)hudShow:(BOOL)show
{
    
    if (show) {
        
        [_defaultHUD show:YES];
        
    }else
    {
        
        [_defaultHUD hide:YES];
        
    }
    
}

-(void)setLeftType:(MONaviLeftType)leftType
{
    
    _leftType = leftType;
    
    _navi.leftType = _leftType;
    
}

-(void)setRightType:(MONaviRightType)rightType
{
    
    _rightType = rightType;
    
    _navi.rightType = _rightType;
    
}

-(void)setTitle:(NSString *)title
{
    
    [super setTitle:title];
    
    _navi.title = self.title;
    
}

-(void)setTitleType:(MONaviTitleType)titleType
{
    
    _navi.titleType = titleType;
    
}

-(void)setShadowType:(MONaviShadowType)shadowType
{
    
    _shadowType = shadowType;
    
    _navi.shadowHidden = shadowType == MONaviShadowTypeDefault;
    
}

-(void)setNavigationBarHidden:(BOOL)navigationBarHidden
{
    
    _navi.hidden = navigationBarHidden;
    
}

-(void)setNavigationBarColor:(UIColor *)navigationBarColor
{
    
    _navigationBarColor = navigationBarColor;
    
    _navi.backgroundColor = navigationBarColor;
    
}

-(void)setNavigationTitleColor:(UIColor *)navigationTitleColor
{
    
    _navigationTitleColor = navigationTitleColor;
    
    _navi.titleColor = _navigationTitleColor;
    
}

-(void)setLeftImg:(UIImage *)leftImg
{
    
    _leftImg = leftImg;
    
    _navi.leftImg = _leftImg;
    
}

-(void)setRightNum:(NSInteger)rightNum
{
    
    _rightNum = rightNum;
    
    _navi.msgNum = _rightNum;
    
}

-(void)setRightSubType:(MONaviRightSubType)rightSubType
{
    
    _rightSubType = rightSubType;
    
    _navi.rightSubType = _rightSubType;
    
}

@end
