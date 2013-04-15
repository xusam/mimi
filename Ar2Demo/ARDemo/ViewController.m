//
//  ViewController.m
//  ARDemo
//
//  Created by  xu on 19/3/13.
//  Copyright (c) 2013 Seven. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)selectShow:(id)sender{
    UIImagePickerController *imagePickerController=[[UIImagePickerController alloc] init];
    imagePickerController.delegate=self;
    imagePickerController.sourceType=UIImagePickerControllerSourceTypeCamera;
    imagePickerController.showsCameraControls=NO;
   
    imagePickerController.wantsFullScreenLayout=NO;
    //imagePicker.cameraViewTransform = cameraTransform;

   imagePickerController.cameraViewTransform=CGAffineTransformScale(imagePickerController.cameraViewTransform, 1.3f, 1.3f);
    _arShowView=[[ARShowView alloc] initWithFrame:CGRectMake(0, 0, 320, [UIScreen mainScreen].bounds.size.height) selectType:1 parent:imagePickerController];
    imagePickerController.cameraOverlayView=_arShowView;
  
    [self presentViewController:imagePickerController animated:YES completion:nil ];
    [imagePickerController release];
    
   
    
   
}



@end
