//
//  MenuItemView.m
//  ARDemo
//
//  Created by  xu on 21/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "MenuItemView.h"
#import <QuartzCore/QuartzCore.h>
@implementation MenuItemView
@synthesize circlePoint=_circlePoint;
@synthesize contentImageView = _contentImageView;
@synthesize bgImageView=_bgImageView;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initFrameWithCirclePoint:(CGPoint)circlePoint  contenView:(UIImage*)contentImage normalBgImage:(UIImage*)normalBgImage selectedBgImage:(UIImage*)selectedBgImage Frame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
        self.center=circlePoint;
        _contentImageView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_contentImageView setImage:contentImage forState:UIControlStateNormal];
       
        _contentImageView.layer.cornerRadius=frame.size.height/2;
        _contentImageView.layer.masksToBounds=YES;
        [_contentImageView addTarget:self action:@selector(selectContentView:) forControlEvents:UIControlEventTouchUpInside];
        self.bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.bgImageView.image=normalBgImage;
      
        
        _normalImage=normalBgImage;
        _selectImage=selectedBgImage;
        
        
        [self addSubview:_contentImageView];
        [self addSubview:_bgImageView];
    
    }
    return self;



}
-(void)selectContentView:(id)sender{
    NSLog(@"tag:%d",self.tag);

}
-(void)setBgImageViewSelected:(BOOL)isSelected{

    if(isSelected){
   
       //self.bgImageView.image=[UIImage imageNamed:@"ar_avatar_highlighted"];
       
    }
    else 
    {
        
       //self.bgImageView.image=[UIImage imageNamed:@"ar_avatar_highlighted"];
        
    }

}
-(void)dealloc{
    
    [_contentImageView release];
    [_bgImageView release];
    [super dealloc];

}
@end
