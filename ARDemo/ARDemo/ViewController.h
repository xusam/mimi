//
//  ViewController.h
//  ARDemo
//
//  Created by  xu on 19/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ARShowView.h"
@interface ViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    ARShowView * _arShowView;

}

-(IBAction)selectShow:(id)sender;
@end
