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
#define toRed(X) (X*M_PI/180.0)
@implementation ARShowView


-(void)dealloc{
    [_motionManager release];
    [super dealloc];
}
- (id)initWithFrame:(CGRect)frame selectType:(int)type parent:(UIImagePickerController *)parentViewController
{
    self = [super initWithFrame:frame];
    if (self) {
        //初始化对象
        _parentViewControlle=parentViewController;
        _isFristRequest=YES;
        _isOpenUserInfo=NO;
        _isOpenTipView=YES;
        _SelectedType=type;
        _displayDataList=[[NSMutableArray alloc] initWithCapacity:0];
        _rightDisplayDataList=[[NSMutableArray alloc] initWithCapacity:0];
        _leftDisplayDataList=[[NSMutableArray alloc] initWithCapacity:0];
        _cellViewFristArr=[[NSMutableArray alloc] initWithCapacity:0];
        _cellViewSecondArr=[[NSMutableArray alloc] initWithCapacity:0];
        _cellViewThirdArr=[[NSMutableArray alloc] initWithCapacity:0];
        UIImageView * image=[[UIImageView alloc] init];
        image.frame=CGRectMake(0, 0, 300, 200);
        image.image=[UIImage imageNamed:@"Default"];
        // [self addSubview:image];
        _locationManager= [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        
        //显示人数图标
        UIImageView * left_count=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ar_letfarrow.png"]];
        UIImageView * right_count=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ar_rightarrow.png"]];
        left_count.frame=CGRectMake(320/2,0 , 19/2, 45/2);
        left_count.transform=CGAffineTransformMakeRotation(89.5f
                                                           );
        right_count.frame=CGRectMake(320/2, [UIScreen mainScreen].bounds.size.height-90/2, 22/2, 46/2);
        right_count.transform=CGAffineTransformMakeRotation(89.5f
                                                            );
        
        //        //显示人数字体
        //        _left_lalcount=[[UILabel alloc]init];
        //        _left_lalcount.frame=CGRectMake(320/2, 12, 90/2, 79/2);
        //        _left_lalcount.text=@"+12";
        //        _left_lalcount.backgroundColor=[UIColor clearColor];
        //        _left_lalcount.transform=CGAffineTransformMakeRotation(89.5f);
        //        _left_lalcount.textColor=[UIColor whiteColor];
        //        _left_lalcount.font=[UIFont systemFontOfSize:13];
        //
        //        _right_lalcount=[[UILabel alloc]init];
        //        _right_lalcount.frame=CGRectMake(320/2, [UIScreen mainScreen].bounds.size.height-90/2+10, 90/2, 79/2);
        //        _right_lalcount.text=@"+12";
        //        _right_lalcount.backgroundColor=[UIColor clearColor];
        //        _right_lalcount.transform = CGAffineTransformMakeRotation(89.5f);
        //
        //        _right_lalcount.textColor=[UIColor whiteColor];
        //        _right_lalcount.font=[UIFont systemFontOfSize:13];
        
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
        
        
        //公告栏
        _brandView=[[UIView alloc] initWithFrame:CGRectMake(0,0 , 328.0f/2, 214.0f/2)];
        UIImageView * brandImageView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ar_display_main.png"]];
        brandImageView.frame=CGRectMake(0, 0, 214.0f/2, 328.0f/2);
        [_brandView addSubview:brandImageView];
        _brandView.center=CGPointMake(300   , ([UIScreen mainScreen].bounds.size.height-20)/2);
        
        _brandInfo=[[UILabel alloc] initWithFrame:CGRectMake(-50, 70, 328.0f/2, 20)];
        _brandInfo.text=@"xxxxxxxxxxxxxxxxxxxxxxxxxxx";
        _brandInfo.backgroundColor=[UIColor clearColor];
        _brandInfo.transform= CGAffineTransformMakeRotation(M_PI/2);
        _brandInfo.textColor=[UIColor whiteColor];
        _brandInfo.textAlignment=NSTextAlignmentCenter;
        _brandInfo.font=[UIFont systemFontOfSize:15];
        _brandInfo.textColor=[UIColor orangeColor];
        _brandName=[[UILabel alloc] initWithFrame:CGRectMake(5, 70,328.0f/2, 20)];
        _brandName.font=[UIFont boldSystemFontOfSize:17];
        _brandName.text=@"本色";
        _brandName.backgroundColor=[UIColor clearColor];
        _brandName.transform= CGAffineTransformMakeRotation(M_PI/2);
        _brandName.textColor=[UIColor whiteColor];
        _brandName.textAlignment=NSTextAlignmentCenter;
        [_brandView addSubview:_brandName];
        [_brandView addSubview:_brandInfo];
        
        _infoView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320,[UIScreen mainScreen].bounds.size.height )];
        _infoView.backgroundColor=[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:0.8f];
        _infoView.hidden=YES;
           //------------用户资料
        UIImageView * bgInfo=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 500.0f/2, 369.0f/2)];
        bgInfo.image=[UIImage imageNamed:@"ar_bginfo.png"];
        bgInfo.transform= CGAffineTransformMakeRotation(M_PI/2);
        bgInfo.center=CGPointMake(180, [UIScreen mainScreen].bounds.size.height/2);
        
        UIButton * btninfoclose=[[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60/2, 62/2)];
        [btninfoclose setImage:[UIImage imageNamed:@"ar-infoclose.png"] forState:UIControlStateNormal];
        btninfoclose.center=CGPointMake(270, [UIScreen mainScreen].bounds.size.height/2+bgInfo.frame.size.width/2+25);
        [btninfoclose addTarget:self action:@selector(selectInfoClose:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView * headbg1=[[UIImageView alloc] initWithFrame:CGRectMake(bgInfo.frame.size.width/2-20, 7, 224/2, 224/2)];
        headbg1.image=[UIImage imageNamed:@"ar_avatar_highlighted.png"];
        
  
        UIImageView * headbg2=[[UIImageView alloc] initWithFrame:CGRectMake(bgInfo.frame.size.width/2-7, 21, 166/2, 166/2)];
        headbg2.image=[UIImage imageNamed:@"ar_avatar_circle.png"];
        
        _headImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 166/2, 166/2)];
    
        _lalnickename=[[UILabel alloc] initWithFrame:CGRectMake(3, 112, bgInfo.frame.size.height, 20)];
        _lalnickename.backgroundColor=[UIColor clearColor];
        _lalnickename.text=@"xxxxx";
        _lalnickename.textAlignment=NSTextAlignmentCenter;
        _lalnickename.font=[UIFont systemFontOfSize:15];
        _sexImageView=[[UIImageView alloc] init];
        
        _btnSayHi=[[UIButton alloc] initWithFrame:CGRectMake(14, 135, 442/2, 81/2)];
        [_btnSayHi setImage:[UIImage imageNamed:@"ar_infosayhi.png"] forState:UIControlStateNormal];
        
        [_infoView addSubview:bgInfo];
        [bgInfo addSubview:headbg1];
        [bgInfo addSubview:headbg2];
        [bgInfo addSubview:_btnSayHi];
        [bgInfo addSubview:_headImageView];
        [bgInfo addSubview:_lalnickename];
        [bgInfo addSubview:_sexImageView];
        [_infoView addSubview:btninfoclose];
        
           //------------距离线
        _line=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0,960/2,373/2)];
        _line.image=[UIImage imageNamed:@"ar_line"];
        _line.transform= CGAffineTransformMakeRotation(M_PI/2);
        _line.center=CGPointMake(373/2/2, [UIScreen mainScreen].bounds.size.height/2);
        
        
        
        NSDictionary * dic1=[[NSDictionary alloc] initWithObjectsAndKeys:@"10",@"direction",@"Default.png",@"image",@"本色2",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic2=[[NSDictionary alloc] initWithObjectsAndKeys:@"20",@"direction",@"c_2.jpg",@"image",@"本色3",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic3=[[NSDictionary alloc] initWithObjectsAndKeys:@"30",@"direction",@"c_3.jpg",@"image",@"本色4",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic4=[[NSDictionary alloc] initWithObjectsAndKeys:@"40",@"direction",@"c_4.jpg",@"image",@"本色5",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic5=[[NSDictionary alloc] initWithObjectsAndKeys:@"50",@"direction",@"c_5.jpg",@"image",@"本色6",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic6=[[NSDictionary alloc] initWithObjectsAndKeys:@"60",@"direction",@"c_6.jpg",@"image",@"本色7",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic7=[[NSDictionary alloc] initWithObjectsAndKeys:@"70",@"direction",@"c_7.jpg",@"image",@"本色8",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic8=[[NSDictionary alloc] initWithObjectsAndKeys:@"80",@"direction",@"c_8.jpg",@"image",@"本色9",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic9=[[NSDictionary alloc] initWithObjectsAndKeys:@"90",@"direction",@"c_9.jpg",@"image",@"本色10",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic10=[[NSDictionary alloc] initWithObjectsAndKeys:@"100",@"direction",@"c_10.jpg",@"image",@"本色11",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic11=[[NSDictionary alloc] initWithObjectsAndKeys:@"110",@"direction",@"c_11.jpg",@"image",@"本色12",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic12=[[NSDictionary alloc] initWithObjectsAndKeys:@"120",@"direction",@"c_12.jpg",@"image",@"本色13",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic13=[[NSDictionary alloc] initWithObjectsAndKeys:@"130",@"direction",@"c_13.jpg",@"image",@"本色14",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic14=[[NSDictionary alloc] initWithObjectsAndKeys:@"140",@"direction",@"c_14.jpg",@"image",@"本色15",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic15=[[NSDictionary alloc] initWithObjectsAndKeys:@"150",@"direction",@"c_15.jpg",@"image", nil];
        NSDictionary * dic16=[[NSDictionary alloc] initWithObjectsAndKeys:@"160",@"direction",@"c_16.jpg",@"image", nil];
        NSDictionary * dic17=[[NSDictionary alloc] initWithObjectsAndKeys:@"170",@"direction",@"c_17.jpg",@"image",@"本色16",@"title",@"据说广州最好的酒吧",@"info", nil];
        NSDictionary * dic18=[[NSDictionary alloc] initWithObjectsAndKeys:@"180",@"direction",@"c_18.jpg",@"image",@"本色18",@"title",@"据说广州最好的酒吧",@"info", nil];
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
        
        
        
        
        
        
        
        //------------朋友cell
        _friendview=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1340, 1340)];
        _friendview.center=CGPointMake(-480, 240);
        _friendview.layer.cornerRadius=1340/2;
        _friendview.transform=CGAffineTransformMakeRotation(2*M_PI/4);
     
        [self makeCell:_dataList contentSize:CGSizeMake(122/2, 122/2) parentView:_friendview cellViewSzie:CGSizeMake(1340, 1340) circleRadii:660 Tag:1000 cellArr:_cellViewFristArr];
        [self makeCell:_dataList contentSize:CGSizeMake(142/2, 142/2) parentView:_friendview cellViewSzie:CGSizeMake(1340, 1340) circleRadii:620 Tag:2000 cellArr:_cellViewSecondArr];
        [self makeCell:_dataList contentSize:CGSizeMake(202/2, 202/2) parentView:_friendview cellViewSzie:CGSizeMake(1340, 1340) circleRadii:560 Tag:3000 cellArr:_cellViewThirdArr];
        
        
        
        
        //------------好玩cell
        _playView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 1340, 1340)];
        _playView.center=CGPointMake(-480, 240);
        _playView.layer.cornerRadius=1340/2;
     
        _playView.transform=CGAffineTransformMakeRotation(2*M_PI/4);
 
        [self makeCell:_dataList contentSize:CGSizeMake(122/2, 122/2) parentView:_playView cellViewSzie:CGSizeMake(1340, 1340) circleRadii:660 Tag:4000 cellArr:_cellPlayViewFristArr];
        [self makeCell:_dataList contentSize:CGSizeMake(142/2, 142/2) parentView:_playView cellViewSzie:CGSizeMake(1340, 1340) circleRadii:620 Tag:5000 cellArr:_cellPlayViewSecondArr];
        [self makeCell:_dataList contentSize:CGSizeMake(202/2, 202/2) parentView:_playView cellViewSzie:CGSizeMake(1340, 1340) circleRadii:560 Tag:6000 cellArr:_cellPlayViewThirdArr];
        
        if (_SelectedType==1) {
           _playView.alpha=0.0; 
        }else{
        
            _friendview.alpha=0.0;
        }
        
        
        
        //提示界面
        
        _tipView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
        
        if (_SelectedType==1) {
            _tipView.image=[UIImage imageNamed:@"ar_tip1.png"];
        }else{
            _tipView.image=[UIImage imageNamed:@"ar_tip2.png"];
        }
        
        _btnTipClose=[[UIButton alloc] initWithFrame:CGRectMake(320-46, [UIScreen mainScreen].bounds.size.height-45, 85/2, 80/2)];
        
        [_btnTipClose setImage:[UIImage imageNamed:@"ar_cancel.png"] forState:UIControlStateNormal];
        
        [_btnTipClose addTarget:self action:@selector(selectedClose:) forControlEvents:UIControlEventTouchUpInside];
        [_tipView addSubview:_btnTipClose];
        
        
        //loading界面
        
        _loadingView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height)];
        _loadingView.backgroundColor=[UIColor blackColor];
        UIImageView * loadingbg=[[UIImageView alloc] initWithFrame:CGRectMake(30, [UIScreen mainScreen].bounds.size.height/2-10, 519/2, 50/2)];
        
        loadingbg.transform=CGAffineTransformMakeRotation(M_PI/2);
        loadingbg.image=[UIImage imageNamed:@"ar_loadingbg.png"];
        _loadingImageView=[[UIImageView alloc] initWithFrame:CGRectMake(30, [UIScreen mainScreen].bounds.size.height/2-3, 519/2, 41/2)];
        UIImage * loadimage=[[UIImage imageNamed:@"ar_loading.png"] stretchableImageWithLeftCapWidth:20 topCapHeight:0];
        _loadingImageView.image=loadimage;
        _loadingImageView.transform=CGAffineTransformMakeRotation(M_PI/2);
        
        _loadingTitl=[[UILabel alloc] initWithFrame:CGRectMake(-10, [UIScreen mainScreen].bounds.size.height/2-10, 519/2, 20)];
        _loadingTitl.textAlignment=NSTextAlignmentCenter;
        _loadingTitl.backgroundColor=[UIColor clearColor];
        _loadingTitl.textColor=[UIColor whiteColor];
        _loadingTitl.font=[UIFont systemFontOfSize:15];
        _loadingTitl.transform=CGAffineTransformMakeRotation(M_PI/2);
        if (_SelectedType==1) {
            _loadingTitl.text=@"正在为你找朋友一起玩";
        }else{
             _loadingTitl.text=@"正在为你找好玩";
        }
        UIButton * btnLoadclose=[[UIButton alloc] initWithFrame:CGRectMake(320-46, [UIScreen mainScreen].bounds.size.height-45, 85/2, 80/2)];
        
        [btnLoadclose setImage:[UIImage imageNamed:@"ar_cancel.png"] forState:UIControlStateNormal];
        
        [btnLoadclose addTarget:self action:@selector(selectedClose:) forControlEvents:UIControlEventTouchUpInside];
        [_loadingView addSubview:_loadingTitl];
        [_loadingView addSubview:_loadingImageView];
        [_loadingView addSubview:loadingbg];
        [_loadingView addSubview:btnLoadclose];
        [self addSubview:_line];
        [self addSubview:_playView];
        [self addSubview:_friendview];
        [self addSubview:leftBan];
        [self addSubview:rightBan];
        [self addSubview:btnclose];
        [self addSubview:_btnType];
        [self addSubview:left_count];
        [self addSubview:right_count];
        [self addSubview:_brandView];
        [self addSubview:_infoView];
        [self addSubview:_loadingView];
        [self addSubview:_tipView];
        
        
        
        //        [self addSubview:_left_lalcount];
        //        [self addSubview:_right_lalcount];
        

        _motionManager = [[CMMotionManager alloc] init];
        if (!_motionManager.accelerometerAvailable) {
            // fail code // 检查传感器到底在设备上是否可用
        }
        _motionManager.accelerometerUpdateInterval = 0.01; // 告诉manager，更新频率是100Hz
        
        
        
        [_motionManager startDeviceMotionUpdatesToQueue:[NSOperationQueue currentQueue] withHandler:^(CMDeviceMotion *latestDevice, NSError *error){
          
            if(_isFristRequest==YES){
                if([self isLeft]){
                    if(_isOpenTipView==YES){
                        _isOpenTipView=NO;
                        _isFristRequest=NO;
                        _tipView.hidden=YES;
                    }
                }
                else
                {
                    return;
                }
            }
            
            
            if(_isOpenUserInfo==YES){
                
                return ;
            }
            
            double yaw     = _motionManager.deviceMotion.attitude.yaw;
            
          
            
            yaw=yaw/M_PI*180;
            
            double center_x=yaw;
            
            if(_RepeatDirection+1>center_x&&_RepeatDirection-1<center_x){
                return ;
            }
            _RepeatDirection=center_x;
            
            
            
            
            [UIView     animateWithDuration:0.3
                                      delay:0.0
                                    options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction
                                 animations:^{
                                     if(_SelectedType==1){
                                         _friendview .transform =CGAffineTransformMakeRotation(((center_x)/360*M_PI*2+2*M_PI/4));
                                         
                                     }else{
                                         
                                         _playView .transform =CGAffineTransformMakeRotation(((center_x)/360*M_PI*2+2*M_PI/4));
                                         
                                         
                                         
                                     }
                                 }
                                 completion:^(BOOL finished) {
                                     
                                 }];
            
            
            if(center_x>0){
                
                center_x=360-center_x;
                
            }else{
                
                center_x=-center_x;
            }
            
            if(_SelectedType==1){
                
                [self requestFriendData:center_x];
            }else{
                
                [self requestPlayData:center_x];
            }
            
            
            
            
            
        }];
        
    }
    return self;
}

-(void)requestPlayData:(float)center_x{
    
    
    
    for(int i=0;i<_dataList.count;i++){
        
        
        NSDictionary *dic=[_dataList objectAtIndex:i];
        float x=[[dic objectForKey:@"direction"] floatValue];
        
        
        if(x+2>center_x&&x-2<center_x){
            
            _brandName.text=[dic objectForKey:@"title"];
            MenuItemView * item=[_cellPlayViewFristArr objectAtIndex:i];
            [item setBgImageViewSelected:YES];
            
            
        }else{
            
            MenuItemView * item=[_cellPlayViewFristArr objectAtIndex:i];
            [item setBgImageViewSelected:NO];
            
            
        }
        
    }
    
    
    for(int i=0;i<_dataList.count;i++){
        
        
        NSDictionary *dic=[_dataList objectAtIndex:i];
        float x=[[dic objectForKey:@"direction"] floatValue];
        
        
        if(x+2>center_x&&x-2<center_x){
            
            _brandName.text=[dic objectForKey:@"title"];
            MenuItemView * item=[_cellPlayViewSecondArr objectAtIndex:i];
            [item setBgImageViewSelected:YES];
            
            
        }else{
            
            MenuItemView * item=[_cellPlayViewSecondArr objectAtIndex:i];
            [item setBgImageViewSelected:NO];
            
            
        }
        
    }
    
    
    for(int i=0;i<_dataList.count;i++){
        
        
        NSDictionary *dic=[_dataList objectAtIndex:i];
        float x=[[dic objectForKey:@"direction"] floatValue];
        
        
        if(x+2>center_x&&x-2<center_x){
            
            _brandName.text=[dic objectForKey:@"title"];
            MenuItemView * item=[_cellPlayViewThirdArr objectAtIndex:i];
            [item setBgImageViewSelected:YES];
            
            
        }else{
            
            MenuItemView * item=[_cellPlayViewThirdArr objectAtIndex:i];
            [item setBgImageViewSelected:NO];
            
            
        }
        
    }
}
-(void)requestFriendData:(float)center_x{
    for(int i=0;i<_dataList.count;i++){
        
        
        NSDictionary *dic=[_dataList objectAtIndex:i];
        float x=[[dic objectForKey:@"direction"] floatValue];
        
        
        if(x+2>center_x&&x-2<center_x){
            
            _brandName.text=[dic objectForKey:@"title"];
            MenuItemView * item=[_cellViewFristArr objectAtIndex:i];
            [item setBgImageViewSelected:YES];
            
            
        }else{
            
            MenuItemView * item=[_cellViewFristArr objectAtIndex:i];
            [item setBgImageViewSelected:NO];
            
            
        }
        
    }
    for(int i=0;i<_dataList.count;i++){
        
        
        NSDictionary *dic=[_dataList objectAtIndex:i];
        float x=[[dic objectForKey:@"direction"] floatValue];
        
        
        if(x+2>center_x&&x-2<center_x){
            
            _brandName.text=[dic objectForKey:@"title"];
            MenuItemView * item=[_cellViewSecondArr objectAtIndex:i];
            [item setBgImageViewSelected:YES];
            
            
        }else{
            
            MenuItemView * item=[_cellViewSecondArr objectAtIndex:i];
            [item setBgImageViewSelected:NO];
            
            
        }
        
    }
    for(int i=0;i<_dataList.count;i++){
        
        
        NSDictionary *dic=[_dataList objectAtIndex:i];
        float x=[[dic objectForKey:@"direction"] floatValue];
        
        
        if(x+2>center_x&&x-2<center_x){
            
            _brandName.text=[dic objectForKey:@"title"];
            MenuItemView * item=[_cellViewThirdArr objectAtIndex:i];
            [item setBgImageViewSelected:YES];
            
            
        }else{
            
            MenuItemView * item=[_cellViewThirdArr objectAtIndex:i];
            [item setBgImageViewSelected:NO];
            
            
        }
        
    }
    
}


-(void)makeCell:(NSArray*)dataArr contentSize:(CGSize)contentSize parentView:(UIView*)parentView cellViewSzie:(CGSize)cellViewSzie circleRadii:(float)circleRadii Tag:(int)tag cellArr:(NSMutableArray*)cellArr {
    if(dataArr.count>0){
        
        for (int i=0; i<dataArr.count; i++) {
            NSDictionary * data=[dataArr objectAtIndex:i];
            
            CGPoint newPoint=CGPointMake(cellViewSzie.width/2 + circleRadii * sinf(([[data objectForKey:@"direction"] floatValue]/360)*M_PI*2),cellViewSzie.height/2 -circleRadii * cosf(([[data objectForKey:@"direction"] floatValue]/360)*M_PI*2));
            
            
            MenuItemView * item=[[MenuItemView alloc] initFrameWithCirclePoint:newPoint contenView:[UIImage imageNamed:[data objectForKey:@"image"]] normalBgImage:[UIImage imageNamed:@"ar_avatar_circle.png"] selectedBgImage:[UIImage imageNamed:@"ar_avatar_highlighted.png"] Frame:CGRectMake(0, 0,contentSize.width, contentSize.height) parentTag:tag];
            item.delegate=self;
            item.tag=tag+i;
            [cellArr addObject:item];
            [parentView addSubview:item];
        }
        
        
        
    }
    
}


-(void)selectedClose:(id)sender{
    
    [_parentViewControlle dismissModalViewControllerAnimated:YES];
    
}
-(void)selectedType:(id)sender{
    NSLog(@"OK");
    if(_SelectedType==1){
        _SelectedType=2;
        [_btnType setImage:[UIImage imageNamed:@"ar_search_other.png"] forState:UIControlStateNormal];
        [UIView beginAnimations:@"HideArrow1" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.5];
        _friendview.alpha=0.0f;
        [UIView commitAnimations];
        
        [UIView beginAnimations:@"HideArrow2" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5];
        
        _playView.alpha=1.0f;
        
        [UIView commitAnimations];
        
        
    }
    else
    {
        [_btnType setImage:[UIImage imageNamed:@"ar_search_play.png"] forState:UIControlStateNormal];
        _SelectedType=1;
        [UIView beginAnimations:@"HideArrow3" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
        [UIView setAnimationDuration:0.5];
        _friendview.alpha=1.0f;
        
        [UIView commitAnimations];
        
        
        [UIView beginAnimations:@"HideArrow4" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        [UIView setAnimationDuration:0.5];
        _playView.alpha=0.0f;
        [UIView commitAnimations];
        
        
    }
    
}


-(void)selectItemWithIndex:(int)index parentTag:(int)tag{
    index=index-tag;
    _infoView.hidden=NO;
    _isOpenUserInfo=YES;
    
    
}
-(void)selectInfoClose:(id)sender{
 _infoView.hidden=YES;
    _isOpenUserInfo=NO;

}
-(BOOL)isLeft{
    //取得當前Device的方向，來當作判斷敘述。（Device的方向型態為Integer）
     UIDevice *device = [UIDevice currentDevice] ;
    switch (device.orientation) {
      
   
            
        case UIDeviceOrientationLandscapeLeft:
            NSLog(@"螢幕向左橫置");
            return YES;
            
            
//        case UIDeviceOrientationLandscapeRight:
//            NSLog(@"螢幕向右橫置");
//            return YES;
            
            
              default:
            NSLog(@"無法辨識");
            break;
    }
    return NO;


}
@end
