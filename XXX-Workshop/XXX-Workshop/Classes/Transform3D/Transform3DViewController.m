//
//  Transform3DViewController.m
//  XXX-Workshop
//
//  Created by XXX on 8/5/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "Transform3DViewController.h"

CG_INLINE CATransform3D
CATransform3DMake(CGFloat m11, CGFloat m12, CGFloat m13, CGFloat m14,
				  CGFloat m21, CGFloat m22, CGFloat m23, CGFloat m24,
				  CGFloat m31, CGFloat m32, CGFloat m33, CGFloat m34,
				  CGFloat m41, CGFloat m42, CGFloat m43, CGFloat m44)
{
	CATransform3D t;
	t.m11 = m11; t.m12 = m12; t.m13 = m13; t.m14 = m14;
	t.m21 = m21; t.m22 = m22; t.m23 = m23; t.m24 = m24;
	t.m31 = m31; t.m32 = m32; t.m33 = m33; t.m34 = m34;
	t.m41 = m41; t.m42 = m42; t.m43 = m43; t.m44 = m44;
	return t;
}

@interface Transform3DViewController ()

@end

@implementation Transform3DViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    imgv.layer.transform=CATransform3DMake(1, 0, 0, 0
                                           , 0, 1, 0, 0
                                           , 0, 0, 1, 0
                                           , 0, 0, 0, 1);
    
    slider.minimumValue=0;
    slider.maximumValue=imgv.frame.size.width;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)sliderValueChanged:(id)sender
{
    CATransform3D transform=CATransform3DIdentity;
    
    transform=CATransform3DMake(1, 0, 0, 0
                                , 0, 1, 0, 0
                                , 0, 0, 1, 0
                                , 0, 0, 0, 1);
    
    imgv.layer.transform=transform;
}

@end
