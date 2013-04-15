//
//  MenuItemView.h
//  ARDemo
//
//  Created by  xu on 21/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuItemDelegate <NSObject>

-(void)selectItemWithIndex:(int)index parentTag:(int)tag;

@end
@interface MenuItemView : UIView
{
   UIImage * _normalImage;//未选中边框
   UIImage * _selectImage;//选中边框
    int   _parentTag;//上级

}
@property(nonatomic,assign)CGPoint * circlePoint;  //在圆上的坐标
@property(nonatomic,retain)UIButton * contentImageView;//头像
@property(nonatomic,retain)UIImageView * bgImageView;//边框
@property(nonatomic,retain)UIImageView * bgHightedImageView;//高光
@property(nonatomic,assign)id<MenuItemDelegate>  delegate;

-(id)initFrameWithCirclePoint:(CGPoint)circlePoint  contenView:(UIImage*)contentImage normalBgImage:(UIImage*)normalBgImage selectedBgImage:(UIImage*)selectedBgImage Frame:(CGRect)frame parentTag:(int)tag;
-(void)setBgImageViewSelected:(BOOL)isSelected;
@end
