//
//  ARShowView.m
//  ARDemo
//
//  Created by  xu on 19/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "ARShowView.h"
#import <QuartzCore/QuartzCore.h>
#import "MenuItemView.h"
#define toRad(X) (X/360*M_PI*2)
@implementation ARShowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _isDisplayBrandView=0;
        _displayDataList=[[NSMutableArray alloc] initWithCapacity:0];
        _rightDisplayDataList=[[NSMutableArray alloc] initWithCapacity:0];
        _leftDisplayDataList=[[NSMutableArray alloc] initWithCapacity:0];
        UIImageView * image=[[UIImageView alloc] init];
        image.frame=CGRectMake(0, 0, 300, 200);
        image.image=[UIImage imageNamed:@"Default"];
        // [self addSubview:image];
        _locationManager= [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        
        //显示人数图标
        UIImageView * left_count=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"left_count"]];
        UIImageView * right_count=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_count"]];
        left_count.frame=CGRectMake(320/2,0 , 90/2, 79/2);
        left_count.transform=CGAffineTransformMakeRotation(89.5f
                                                           );
        right_count.frame=CGRectMake(320/2, [UIScreen mainScreen].bounds.size.height-90/2, 90/2, 79/2);
        right_count.transform=CGAffineTransformMakeRotation(89.5f
                                                            );
        
        //显示人数字体
        _left_lalcount=[[UILabel alloc]init];
        _left_lalcount.frame=CGRectMake(320/2, 12, 90/2, 79/2);
        _left_lalcount.text=@"+12";
        _left_lalcount.backgroundColor=[UIColor clearColor];
        _left_lalcount.transform=CGAffineTransformMakeRotation(89.5f);
        _left_lalcount.textColor=[UIColor whiteColor];
        _left_lalcount.font=[UIFont systemFontOfSize:13];
        
        _right_lalcount=[[UILabel alloc]init];
        _right_lalcount.frame=CGRectMake(320/2, [UIScreen mainScreen].bounds.size.height-90/2+10, 90/2, 79/2);
        _right_lalcount.text=@"+12";
        _right_lalcount.backgroundColor=[UIColor clearColor];
        _right_lalcount.transform = CGAffineTransformMakeRotation(89.5f);
        
        _right_lalcount.textColor=[UIColor whiteColor];
        _right_lalcount.font=[UIFont systemFontOfSize:13];
        
        //关闭按钮
        
        UIButton * btnclose=[[UIButton alloc] initWithFrame:CGRectMake(320-46, [UIScreen mainScreen].bounds.size.height-45, 85/2, 80/2)];
        
        [btnclose setImage:[UIImage imageNamed:@"ar_cancel.png"] forState:UIControlStateNormal];
        
        [btnclose addTarget:self action:@selector(selectedClose:) forControlEvents:UIControlEventTouchUpInside];
        
        //左下标签
        
        UIImageView * leftBan=[[UIImageView alloc] initWithFrame:CGRectMake(-2, [UIScreen mainScreen].bounds.size.height-87/2, 118/2, 87/2)];
        leftBan.image=[UIImage imageNamed:@"ar_right_ban"];
      leftBan.transform= CGAffineTransformMakeRotation(89.5f);
        leftBan.alpha=0.1;
        //右下标签
        UIImageView * rightBan=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 102/2, 87/2)];
        rightBan.image=[UIImage imageNamed:@"ar_left_ban"];
        rightBan.transform= CGAffineTransformMakeRotation(89.5f);
        rightBan.alpha=0.1;
        
        
        //类型
        _btnType=[[UIButton alloc] initWithFrame:CGRectMake(320-46, 7, 78/2, 79/2)];
        [_btnType addTarget:self action:@selector(selectedType:) forControlEvents:UIControlEventTouchUpInside];
        [_btnType setImage:[UIImage imageNamed:@"ar_search_other.png"] forState:UIControlStateNormal];
         _btnType.transform= CGAffineTransformMakeRotation(89.5f);
        _SelectedType=1;
        
        //公告栏
        _brandView=[[UIView alloc] initWithFrame:CGRectMake(0,0 , 328.0f/2, 214.0f/2)];
        UIImageView * brandImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ar_display_main.png"]];
        brandImageView.frame=CGRectMake(0, 0, 214.0f/2, 328.0f/2);
        [_brandView addSubview:brandImageView];
        _brandView.center=CGPointMake(320   , ([UIScreen mainScreen].bounds.size.height-20)/2);
        
        
        
        
        [self addSubview:leftBan];
        [self addSubview:rightBan];
        [self addSubview:btnclose];
        [self addSubview:_btnType];
        [self addSubview:left_count];
        [self addSubview:right_count];
        [self addSubview:_brandView];
        [self addSubview:_left_lalcount];
        [self addSubview:_right_lalcount];
   
        

        
        NSDictionary * dic0=[[NSDictionary alloc] initWithObjectsAndKeys:@"0",@"direction",@"Default.png",@"image", nil];
        NSDictionary * dic1=[[NSDictionary alloc] initWithObjectsAndKeys:@"10",@"direction",@"Default.png",@"image", nil];
        NSDictionary * dic2=[[NSDictionary alloc] initWithObjectsAndKeys:@"20",@"direction",@"c_2.jpg",@"image", nil];
        NSDictionary * dic3=[[NSDictionary alloc] initWithObjectsAndKeys:@"30",@"direction",@"c_3.jpg",@"image", nil];
        NSDictionary * dic4=[[NSDictionary alloc] initWithObjectsAndKeys:@"40",@"direction",@"c_4.jpg",@"image", nil];
        NSDictionary * dic5=[[NSDictionary alloc] initWithObjectsAndKeys:@"50",@"direction",@"c_5.jpg",@"image", nil];
        NSDictionary * dic6=[[NSDictionary alloc] initWithObjectsAndKeys:@"60",@"direction",@"c_6.jpg",@"image", nil];
        NSDictionary * dic7=[[NSDictionary alloc] initWithObjectsAndKeys:@"70",@"direction",@"c_7.jpg",@"image", nil];
        NSDictionary * dic8=[[NSDictionary alloc] initWithObjectsAndKeys:@"80",@"direction",@"c_8.jpg",@"image", nil];
        NSDictionary * dic9=[[NSDictionary alloc] initWithObjectsAndKeys:@"90",@"direction",@"c_9.jpg",@"image", nil];
        NSDictionary * dic10=[[NSDictionary alloc] initWithObjectsAndKeys:@"100",@"direction",@"c_10.jpg",@"image", nil];
        NSDictionary * dic11=[[NSDictionary alloc] initWithObjectsAndKeys:@"110",@"direction",@"c_11.jpg",@"image", nil];
        NSDictionary * dic12=[[NSDictionary alloc] initWithObjectsAndKeys:@"120",@"direction",@"c_12.jpg",@"image", nil];
        NSDictionary * dic13=[[NSDictionary alloc] initWithObjectsAndKeys:@"130",@"direction",@"c_13.jpg",@"image", nil];
        NSDictionary * dic14=[[NSDictionary alloc] initWithObjectsAndKeys:@"140",@"direction",@"c_14.jpg",@"image", nil];
        NSDictionary * dic15=[[NSDictionary alloc] initWithObjectsAndKeys:@"150",@"direction",@"c_15.jpg",@"image", nil];
        NSDictionary * dic16=[[NSDictionary alloc] initWithObjectsAndKeys:@"160",@"direction",@"c_16.jpg",@"image", nil];
        NSDictionary * dic17=[[NSDictionary alloc] initWithObjectsAndKeys:@"170",@"direction",@"c_17.jpg",@"image", nil];
        NSDictionary * dic18=[[NSDictionary alloc] initWithObjectsAndKeys:@"180",@"direction",@"c_18.jpg",@"image", nil];
        NSDictionary * dic19=[[NSDictionary alloc] initWithObjectsAndKeys:@"190",@"direction",@"c_19.jpg",@"image", nil];
        NSDictionary * dic20=[[NSDictionary alloc] initWithObjectsAndKeys:@"200",@"direction",@"c_20.jpg",@"image", nil];
        NSDictionary * dic21=[[NSDictionary alloc] initWithObjectsAndKeys:@"210",@"direction",@"c_21.jpg",@"image", nil];
        NSDictionary * dic22=[[NSDictionary alloc] initWithObjectsAndKeys:@"220",@"direction",@"c_22.jpg",@"image", nil];
        NSDictionary * dic23=[[NSDictionary alloc] initWithObjectsAndKeys:@"230",@"direction",@"c_23.jpg",@"image", nil];
        NSDictionary * dic24=[[NSDictionary alloc] initWithObjectsAndKeys:@"240",@"direction",@"c_24.jpg",@"image", nil];
        NSDictionary * dic25=[[NSDictionary alloc] initWithObjectsAndKeys:@"250",@"direction",@"c_25.jpg",@"image", nil];
        NSDictionary * dic26=[[NSDictionary alloc] initWithObjectsAndKeys:@"260",@"direction",@"c_26.jpg",@"image", nil];
        NSDictionary * dic27=[[NSDictionary alloc] initWithObjectsAndKeys:@"270",@"direction",@"c_27.jpg",@"image", nil];
        NSDictionary * dic28=[[NSDictionary alloc] initWithObjectsAndKeys:@"280",@"direction",@"c_28.jpg",@"image", nil];
        NSDictionary * dic29=[[NSDictionary alloc] initWithObjectsAndKeys:@"290",@"direction",@"c_29.jpg",@"image", nil];
        NSDictionary * dic30=[[NSDictionary alloc] initWithObjectsAndKeys:@"300",@"direction",@"c_30.jpg",@"image", nil];
        NSDictionary * dic31=[[NSDictionary alloc] initWithObjectsAndKeys:@"310",@"direction",@"c_31.jpg",@"image", nil];
        NSDictionary * dic32=[[NSDictionary alloc] initWithObjectsAndKeys:@"320",@"direction",@"c_32.jpg",@"image", nil];
        NSDictionary * dic33=[[NSDictionary alloc] initWithObjectsAndKeys:@"330",@"direction",@"c_33.jpg",@"image", nil];
        NSDictionary * dic34=[[NSDictionary alloc] initWithObjectsAndKeys:@"340",@"direction",@"c_34.jpg",@"image", nil];
        NSDictionary * dic35=[[NSDictionary alloc] initWithObjectsAndKeys:@"350",@"direction",@"c_35.jpg",@"image", nil];
        NSDictionary * dic36=[[NSDictionary alloc] initWithObjectsAndKeys:@"360",@"direction",@"c_36.jpg",@"image", nil];
        _dataList=[[NSArray alloc] initWithObjects:dic1,dic2,dic3,dic4,dic5,dic6,dic7,dic8,dic9,dic10,dic11,dic12,dic13,dic14,dic15,dic16,dic17,dic18,dic19,dic20,dic21,dic22,dic23,dic24,dic25,dic26,dic27,dic28,dic29,dic30,dic31,dic32,dic33,dic34,dic35,dic36, nil];
       [self makeCell:_dataList];
    

        if ([CLLocationManager headingAvailable]) {
            //设置精度
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            //设置滤波器不工作
            _locationManager.headingFilter = kCLHeadingFilterNone;
            //开始更新
            [_locationManager startUpdatingHeading];
            
        }
        
    }
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    [_locationManager stopUpdatingHeading];
    float self_direction=newHeading.magneticHeading;
//    NSLog(@"self_direction:%f",self_direction);
    
//    float min_x=self_direction>30?self_direction-30:360-(30-self_direction);
//    float max_x=self_direction<330?self_direction+30:30-(360-self_direction);
//    float center_x=self_direction>180?self_direction+180-360:self_direction+180;
    
    NSLog(@"%f",self_direction);
    [UIView     animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             _cellView.transform =CGAffineTransformMakeRotation(((self_direction)/360*M_PI*2+2*M_PI/4));
                         }
                         completion:^(BOOL finished) {
                             
                         }];
   
        
   
        for(int i=0;i<_dataList.count;i++){
            
            NSDictionary *dic=[_dataList objectAtIndex:i];
            float x=[[dic objectForKey:@"direction"] floatValue];
            if(x+2>360-self_direction&&x-2<360-self_direction){
                
                NSLog(@"--------1--------");
            
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.1];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                
                _brandView.center=CGPointMake(320   , ([UIScreen mainScreen].bounds.size.height-20)/2);
                [UIView commitAnimations];
                
               
                
                
                
            }else{
                
                NSLog(@"--------2--------");
              
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:0.1];
                [UIView setAnimationCurve:UIViewAnimationCurveLinear];
                
                _brandView.center=CGPointMake(320 +200  , ([UIScreen mainScreen].bounds.size.height-20)/2);
                [UIView commitAnimations];
                
            }
            
        }

    
    

    
    [_locationManager startUpdatingHeading];
}
-(void)configIsWork:(BOOL)status{
    
    _isworking=status;
}
-(BOOL)checkIsWork{
    return _isworking;
    
}

-(void)makeCell:(NSArray*)arry{
    if(_dataList.count>0){
        _cellView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1000, 1000)];
       _cellView.center=CGPointMake(-180, 240);
//        UIView * view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//        view.center=CGPointMake(160, 240);

        _cellView.tag=1;
        _cellView.backgroundColor=[UIColor clearColor];
       _cellView.transform=CGAffineTransformMakeRotation(2*M_PI/4);
        for (int i=0; i<_dataList.count; i++) {
            NSDictionary * data=[_dataList objectAtIndex:i];
            
            CGPoint newPoint=CGPointMake(500 + 300.0f * sinf(([[data objectForKey:@"direction"] floatValue]/360)*M_PI*2),500 -300 * cosf(([[data objectForKey:@"direction"] floatValue]/360)*M_PI*2));
           
            
            MenuItemView * item=[[MenuItemView alloc] initFrameWithCirclePoint:newPoint contenView:[UIImage imageNamed:[data objectForKey:@"image"]] normalBgImage:[UIImage imageNamed:@"ar_avatar_circle.png"] selectedBgImage:[UIImage imageNamed:@"ar_avatar_highlighted.png"] Frame:CGRectMake(0, 0,166/2, 166/2)];
            item.tag=i;
            
            [_cellView addSubview:item];
        }
        
        [self addSubview:_cellView];
        
    }
    
}


-(void)selectedClose:(id)sender{
 NSLog(@"OK");


}
-(void)selectedType:(id)sender{
    NSLog(@"OK");
    if(_SelectedType==1){
        _SelectedType=2;
            [_btnType setImage:[UIImage imageNamed:@"ar_search_play.png"] forState:UIControlStateNormal];
       
    
    }
    else
    {
        [_btnType setImage:[UIImage imageNamed:@"ar_search_other.png"] forState:UIControlStateNormal];
          _SelectedType=1;
    
    }

}
@end
