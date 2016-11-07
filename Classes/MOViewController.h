//
//  MOViewController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MONaviShadowTypeDefault,
    MONaviShadowTypeLine,
} MONaviShadowType;

typedef enum : NSUInteger {
    MONaviLeftTypeNO,
    MONaviLeftTypeBack,
    MONaviLeftTypePage,
    MONaviLeftTypeClose,
    MONaviLeftTypeTitle,
} MONaviLeftType;

typedef enum : NSUInteger {
    MONaviRightTypeNO,
    MONaviRightTypeRing,
    MONaviRightTypeAdd,
    MONaviRightTypeEdit,
    MONaviRightTypeEditDisable,
    MONaviRightTypeTrash,
    MONaviRightTypeShare,
    MONaviRightTypeTitle,
    MONaviRightTypeCheck,
    MONaviRightTypeMore,
    MONaviRightTypeSearch,
    MONaviRightTypeSetting,
} MONaviRightType;

typedef enum : NSUInteger {
    MONaviRightSubTypeNO,
    MONaviRightSubTypeSearch,
    MONaviRightSubTypeShare,
    MONaviRightSubTypeEdit,
} MONaviRightSubType;

typedef enum : NSUInteger {
    MONaviTitleTypeLabel,
    MONaviTitleTypeButton,
    MONaviTitleTypePull,
} MONaviTitleType;

@protocol MONaviDelegate <NSObject>

@optional

-(void)naviLeftClick;

-(void)naviRightClick;

-(void)naviTitleClick;

-(void)naviRightSubClick;

@end

@interface MONaviView : UIView

@property(nonatomic,copy)NSString *title;

@property(nonatomic,assign)MONaviLeftType leftType;

@property(nonatomic,assign)MONaviRightType rightType;

@property(nonatomic,assign)MONaviTitleType titleType;

@property(nonatomic,assign)MONaviRightSubType rightSubType;

@property(nonatomic,copy)NSString *rightTitle;

@property(nonatomic,copy)NSString *leftTitle;

@property(nonatomic,assign)NSInteger msgNum;

@property(nonatomic,assign)CGFloat maxTitleRight;

@property(nonatomic,assign)UIViewController<MONaviDelegate>* delegate;

@end

@interface MOViewController : UIViewController<MONaviDelegate>

@property(nonatomic,strong)UIImage *unselectImg;

@property(nonatomic,strong)UIImage *selectedImg;

@property(nonatomic,assign)MONaviLeftType leftType;

@property(nonatomic,assign)MONaviRightType rightType;

@property(nonatomic,assign)MONaviRightSubType rightSubType;

@property(nonatomic,assign)MONaviTitleType titleType;

@property(nonatomic,assign)MONaviShadowType shadowType;

@property(nonatomic,strong)UIImage *leftImg;

@property(nonatomic,strong)UIColor *navigationBarColor;

@property(nonatomic,strong)UIColor *navigationTitleColor;

@property(nonatomic,assign)NSInteger rightNum;

@property(nonatomic,copy)NSString *rightTitle;

@property(nonatomic,strong)UIColor *rightColor;

@property(nonatomic,copy)NSString *leftTitle;

@property(nonatomic,strong)UIColor *leftColor;

@property(nonatomic,assign)BOOL navigationBarHidden;

@property(nonatomic,assign)BOOL rightButtonEnable;

@property(nonatomic,assign)BOOL leftButtonEnable;

-(void)hudShow:(BOOL)show;

-(void)reloadData;

-(void)popToViewControllerName:(NSString*)vcname isReloadData:(BOOL)isReload;

-(void)popViewControllerAndReloadData;

-(void)showNoPermissionAlert;

@end
