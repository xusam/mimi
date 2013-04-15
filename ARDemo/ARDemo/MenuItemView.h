//
//  MenuItemView.h
//  ARDemo
//
//  Created by  xu on 21/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuItemView : UIView
{
   UIImage * _normalImage;//未选中边框
   UIImage * _selectImage;//选中边框

}
@property(nonatomic,assign)CGPoint * circlePoint;  //在圆上的坐标
@property(nonatomic,retain)UIButton * contentImageView;//头像
@property(nonatomic,retain)UIImageView * bgImageView;//边框


-(id)initFrameWithCirclePoint:(CGPoint)circlePoint  contenView:(UIImage*)contentImage normalBgImage:(UIImage*)normalBgImage selectedBgImage:(UIImage*)selectedBgImage Frame:(CGRect)frame;
-(void)setBgImageViewSelected:(BOOL)isSelected;
@end
