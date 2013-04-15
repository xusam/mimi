//
//  ARShowView.h
//  ARDemo
//
//  Created by  xu on 19/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
@interface ARShowView : UIView<CLLocationManagerDelegate>

{

    NSArray * _dataList;
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
    UIView * _cellView;
    int  _isDisplayBrandView;

}
@end
