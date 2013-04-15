//
//  ARShowView.h
//  ARDemo
//
//  Created by  xu on 19/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import "MenuItemView.h"
@interface ARShowView : UIView<CLLocationManagerDelegate,MenuItemDelegate>

{
    
    NSArray * _dataList;
    BOOL _isOpenUserInfo;//是否打开用户
    NSMutableArray * _displayDataList; // 显示的数据
    NSMutableArray * _leftDisplayDataList;//左边的数据
    NSMutableArray * _rightDisplayDataList;//左边的数据
    CLLocationManager * _locationManager;
    BOOL _isworking;//否是在加载
    UILabel * _left_lalcount;//左边数字
    UILabel * _right_lalcount;//右边数字
    UIButton * _btnType;//分类按钮
    int   _SelectedType;//分类
    UIView  * _brandView;//公告栏
    UILabel *_brandName;//公告名称
    UILabel *_brandInfo;//公告题目
    UILabel *_brandContent;//公告内容
    UIImageView * _line;//距离线
    
    UIView * _playView;
    UIView * _friendview;
    
    NSMutableArray * _cellViewFristArr;//朋友第一环数据
    NSMutableArray * _cellViewSecondArr;//朋友第二环数据
    NSMutableArray * _cellViewThirdArr;//朋友第三环数据
    

    NSMutableArray * _cellPlayViewFristArr;//好玩第一环数据
    NSMutableArray * _cellPlayViewSecondArr;//好玩第二环数据
    NSMutableArray * _cellPlayViewThirdArr;//好玩第三环数据
    
    
    UIView * _infoView;//显示用户详细信息
    UIImageView * _headImageView;//用户详细信息头像
    UIImageView * _sexImageView;//用户详细信息性别
    UILabel * _lalnickename;//用户详细信息昵称
    UIButton * _btnSayHi;//用户详细信息sayhi
    UIImageView * _tipView;//提示画面
    UIButton    *_btnTipClose;//提示界面关闭
    BOOL    _isOpenTipView;//打开提示界面
    float _RepeatDirection;//重复的方向
    BOOL  _isFristRequest;//第一次访问;
    UIView *_loadingView;//加载界面
    UIImageView *_loadingImageView;//加载条
    UILabel *_loadingTitl;
    CMMotionManager  *_motionManager;
    UIImagePickerController *_parentViewControlle;
    
    
    
  
    
    
}
- (id)initWithFrame:(CGRect)frame selectType:(int)type parent:(UIImagePickerController*)parentViewController;

@end
