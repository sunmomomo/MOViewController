//
//  MOViewController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#define IPhone4_5_6_6P(a,b,c,d) (CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) ?(a) :(CGSizeEqualToSize(CGSizeMake(320, 568), [[UIScreen mainScreen] bounds].size) ? (b) : (CGSizeEqualToSize(CGSizeMake(375, 667), [[UIScreen mainScreen] bounds].size) ?(c) : (CGSizeEqualToSize(CGSizeMake(414, 736), [[UIScreen mainScreen] bounds].size) ?(d) : a))))

#define MOColorFromRGB [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define NaviColor MOColorFromRGB(0x4e4e4e)

#define NaviTitleColor MOColorFromRGB(0xffffff)

#define NaviFont [UIFont boldSystemFontOfSize:IPhone4_5_6_6P(16, 16, 17, 18)]

typedef enum : NSUInteger {
    TitleButtonTypeDown,
    TitleButtonTypePull,
} TitleButtonType;

@interface TitleButton : UIButton

{
    
    UILabel *_titleLabel;
    
    UIImageView *_arrowImg;
    
    UIImageView *_pullImg;
    
    BOOL _isTransformed;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)CGFloat maxTitleRight;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,assign)TitleButtonType type;

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
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.frame.origin.x+_titleLabel.frame.size.width+8, frame.size.height/2-3, 10.6, 6)];
        
        _arrowImg.image = [UIImage imageNamed:@"white_down_arrow"];
        
        [self addSubview:_arrowImg];
        
        _pullImg = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-3, self.frame.size.height-11, 6, 4)];
        
        _pullImg.image = [UIImage imageNamed:@"navi_pull_image"];
        
        [self addSubview:_pullImg];
        
        _pullImg.hidden = YES;
        
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
    
    CGSize size = [self sizeThatFits:CGSizeMake(MAXFLOAT, _titleLabel.frame.size.height)];
    
    [_titleLabel setFrame:(CGRectMake(_titleLabel.frame.origin.x,_titleLabel.frame.origin.y,size.width,_titleLabel.frame.size.height))];
    
    if (self.maxTitleRight) {
        
        if (_titleLabel.frame.origin.x+_titleLabel.frame.size.width+28.6>self.maxTitleRight) {
            
            [_titleLabel changeWidth:self.maxTitleRight-_titleLabel.frame.origin.x-28.6];
            
        }
        
    }else
    {
        
        if (_titleLabel.frame.size.width>MSW-100) {
            
            [_titleLabel changeWidth:MSW-100];
            
        }
        
    }
    
    _titleLabel.center = CGPointMake(self.frame.size.width/2, _titleLabel.center.y);
    
    [_arrowImg changeLeft:_titleLabel.frame.origin.x+_titleLabel.frame.size.width+8];
    
}

-(void)setType:(TitleButtonType)type
{
    
    _type = type;
    
    _arrowImg.hidden = _type == TitleButtonTypePull;
    
    _pullImg.hidden = _type == TitleButtonTypeDown;
    
}

-(void)didClick
{
    
    _pullImg.transform = CGAffineTransformMakeRotation(_isTransformed?0:M_PI);
    
    _isTransformed = !_isTransformed;
    
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
        
        _numLabel.layer.cornerRadius = _numLabel.frame.size.width/2;
        
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
        
        _imgView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        
        _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        
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
    
    UILabel *_titleLabel;
    
    TitleButton *_titleButton;
    
    NumView *_numView;
    
    NaviButton *_rightSubButton;
    
    UIView *_line;
    
}

@property(nonatomic,strong)NaviButton *rightButton;

@property(nonatomic,strong)NaviButton *leftButton;

@property(nonatomic,assign)BOOL shadowHidden;

@property(nonatomic,strong)UIImage *leftImg;

@property(nonatomic,strong)UIColor *titleColor;

@property(nonatomic,strong)UIColor *rightColor;

@property(nonatomic,strong)UIColor *leftColor;

@end

@implementation MONaviView


-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = NaviColor;
        
        _line = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1, frame.size.width, 1)];
        
        _line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_line];
        
        _numView = [[NumView alloc]initWithFrame:CGRectMake(MSW-25, 28, 22, 22)];
        
        [self addSubview:_numView];
        
        _leftButton = [[NaviButton alloc]initWithFrame:CGRectMake(0, 20, 48, 48)];
        
        [self addSubview:_leftButton];
        
        _rightButton = [[NaviButton alloc]initWithFrame:CGRectMake(MSW-48, 20, 48, 48)];
        
        [_rightButton setTitleColor:kMainColor forState:UIControlStateNormal];
        
        [self addSubview:_rightButton];
        
        _rightSubButton = [[NaviButton alloc]initWithFrame:CGRectMake(MSW-101, 20, 48, 48)];
        
        _rightSubButton.hidden = YES;
        
        _titleButton = [[TitleButton alloc]initWithFrame:CGRectMake(_leftButton.frame.origin.x+_leftButton.frame.size.width+10, 20, MSW-_leftButton.frame.size.width*2-20, 44)];
        
        [_titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_titleButton];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_leftButton.frame.origin.x+_leftButton.frame.size.width+10, 20, MSW-_leftButton.frame.size.width*2-20, 44)];
        
        _titleLabel.textColor = NaviTitleColor;
        
        _titleLabel.font = NaviFont;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_titleLabel];
        
        self.titleType = MONaviTitleTypeLabel;
        
        [self bringSubviewToFront:_rightButton];
        
        [self bringSubviewToFront:_leftButton];
        
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
        
        _titleButton.type = _titleType == MONaviTitleTypeButton?TitleButtonTypeDown:TitleButtonTypePull;
        
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
            
            [_rightButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypePage:
            
            _leftButton.image = [UIImage imageNamed:@"navi_page"];
            
            [_rightButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeClose:
            
            _leftButton.image = [UIImage imageNamed:@"navi_close"];
            
            [_rightButton changeWidth:48];
            
            [_leftButton addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviLeftTypeTitle:
            
            [_leftButton setImage:nil];
            
            [_leftButton changeWidth:70];
            
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
            
            _maxTitleRight = _rightSubButton.frame.origin.x;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_search"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
        
        case MONaviRightSubTypeNO:
            
            _maxTitleRight = _rightButton.frame.origin.x;
            
            [_rightSubButton setImage:nil];
            
            [_rightSubButton removeTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            _rightSubButton.hidden = YES;
            
            [_rightSubButton removeFromSuperview];
            
            break;
    
        case MONaviRightSubTypeShare:
            
            _maxTitleRight = _rightSubButton.frame.origin.x;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_share"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
            
        case MONaviRightSubTypeEdit:
            
            _maxTitleRight = _rightSubButton.frame.origin.x;
            
            [_rightSubButton setImage:[UIImage imageNamed:@"navi_edit"]];
            
            [_rightSubButton addTarget:self action:@selector(rightSubClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [self addSubview:_rightSubButton];
            
            [self bringSubviewToFront:_rightSubButton];
            
            _rightSubButton.hidden = NO;
            
            break;
            
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
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_edit"]];
            
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
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_edit_disabled"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
            
        case MONaviRightTypeTrash:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_trash"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeShare:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_share"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
            break;
        case MONaviRightTypeCheck:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_check"]];
            
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
            
        case MONaviRightTypeSetting:
            
            [_rightButton setImage:[UIImage imageNamed:@"navi_setting"]];
            
            [_rightButton changeLeft:MSW-48];
            
            [_rightButton changeWidth:48];
            
            [_rightButton addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
            
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

-(void)setLeftColor:(UIColor *)leftColor
{
    
    _leftColor = leftColor;
    
    [_leftButton setTitleColor:leftColor forState:UIControlStateNormal];
    
}

-(void)setRightTitle:(NSString *)rightTitle
{
    
    _rightTitle = rightTitle;
    
    if (_rightTitle.length&&_rightType != MONaviRightTypeTitle) {
        
        self.rightType = MONaviRightTypeTitle;
        
    }
    
    _rightButton.title = rightTitle;
    
}

-(void)setLeftTitle:(NSString *)leftTitle
{
    
    _leftTitle = leftTitle;
    
    if (_leftTitle.length && _leftType != MONaviLeftTypeTitle) {
        
        self.leftType = MONaviLeftTypeTitle;
        
    }
    
    _leftButton.title = leftTitle;
    
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
    
    if (_titleButton.type == TitleButtonTypePull) {
        
        [_titleButton didClick];
        
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
    
    MONaviView *_navi;
    
    MBProgressHUD *_defaultHUD;
    
    BOOL _haveChanged;
    
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
    
    if (_navi.frame.origin.y != 0) {
        
        [_navi changeTop:0];
        
    }
    
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

-(void)setLeftTitle:(NSString *)leftTitle
{
    
    _navi.leftTitle = leftTitle;
    
}

-(void)setLeftColor:(UIColor *)leftColor
{
    
    _leftColor = leftColor;
    
    _navi.leftColor = leftColor;
    
}

-(void)setRightColor:(UIColor *)rightColor
{
    
    _rightColor = rightColor;
    
    _navi.rightColor = rightColor;
    
}

-(void)hudShow:(BOOL)show
{
    
    if (show) {
        
        [_defaultHUD showAnimated:YES];
        
    }else
    {
        
        [_defaultHUD hideAnimated:YES];
        
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

-(void)setRightButtonEnable:(BOOL)rightButtonEnable
{
    
    _rightButtonEnable = rightButtonEnable;
    
    _navi.rightButton.userInteractionEnabled = _rightButtonEnable;
    
}

-(void)setLeftButtonEnable:(BOOL)leftButtonEnable
{
    
    _leftButtonEnable = leftButtonEnable;
    
    _navi.leftButton.userInteractionEnabled = _leftButtonEnable;
    
}

-(void)viewWillLayoutSubviews
{
    
    [super viewWillLayoutSubviews];
    
    if (self.view.frame.size.height != MSH) {
        
        _haveChanged = YES;
        
    }else if(self.view.frame.size.height == MSH){
        
        if (_haveChanged) {
            
            for (UIView *subView in self.view.subviews) {
                
                [subView changeTop:subView.frame.origin.y];
                
            }
            
            _haveChanged = NO;
            
        }
        
    }
    
}

-(void)popToViewControllerName:(NSString *)vcname isReloadData:(BOOL)isReload
{
    
    for (UIViewController *vc in self.navigationController.viewControllers) {
        
        if ([vcname isEqualToString:NSStringFromClass([vc class])]) {
            
            [self.navigationController popToViewController:vc animated:YES];
            
            if (isReload && [vc isKindOfClass:[MOViewController class]]) {
                
                [(MOViewController*)vc reloadData];
                
            }
            
            break;
            
        }
        
    }
    
}

-(void)popViewControllerAndReloadData
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.navigationController.visibleViewController isKindOfClass:[MOViewController class]]) {
        
        [((MOViewController*)self.navigationController.visibleViewController) reloadData];
        
    }
    
}

-(void)showNoPermissionAlert
{
    
    [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该功能权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
    
}

@end
