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
@synthesize bgHightedImageView=_bgHightedImageView;
@synthesize delegate=_delegate;


-(void)dealloc{
    [_contentImageView release];
    [_bgImageView release];
    [_bgHightedImageView release];
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(id)initFrameWithCirclePoint:(CGPoint)circlePoint  contenView:(UIImage*)contentImage normalBgImage:(UIImage*)normalBgImage selectedBgImage:(UIImage*)selectedBgImage Frame:(CGRect)frame parentTag:(int)tag{
    self = [super initWithFrame:frame];
    if (self) {
        _parentTag=tag;
        self.center=circlePoint;
        _contentImageView=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [_contentImageView setImage:contentImage forState:UIControlStateNormal];
        
        _contentImageView.layer.cornerRadius=frame.size.height/2;
        _contentImageView.layer.masksToBounds=YES;
        [_contentImageView addTarget:self action:@selector(selectContentView:) forControlEvents:UIControlEventTouchUpInside];
        self.bgImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        self.bgImageView.image=normalBgImage;
        
        _bgHightedImageView=[[UIImageView alloc] initWithFrame:CGRectMake(-14, -14, frame.size.width+28, frame.size.height+28)];
        _bgHightedImageView.image=selectedBgImage;
      
        _bgHightedImageView.hidden=YES;
        _normalImage=normalBgImage;
        _selectImage=selectedBgImage;
        
        
        [self addSubview:_contentImageView];
        [self addSubview:_bgImageView];
        [self addSubview:_bgHightedImageView];
    
    }
    return self;



}
-(void)selectContentView:(id)sender{
  
   
    if (_delegate!=nil) {
        
    
    [_delegate selectItemWithIndex:self.tag parentTag:_parentTag];
    }
    

}
-(void)setBgImageViewSelected:(BOOL)isSelected{

    if(isSelected){
   
        _bgHightedImageView.hidden=NO;
       
    }
    else 
    {
        
        _bgHightedImageView.hidden=YES;
        
    }

}

@end
