//
//  PerspectivePageView.m
//  XXX-Workshop
//
//  Created by XXX on 8/5/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "PerspectivePageView.h"

#define CATransform3DPerspective(t, x, y) (CATransform3DConcat(t, CATransform3DMake(1, 0, 0, x, 0, 1, 0, y, 0, 0, 1, 0, 0, 0, 0, 1)))
#define CATransform3DMakePerspective(x, y) (CATransform3DPerspective(CATransform3DIdentity, x, y))
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

@interface PerspectivePageView()
{
}

@end

@implementation PerspectivePageView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.clipsToBounds=true;
    
    [self commonInit];
}

-(void) commonInit
{
}

-(void)showRearViewWithAnimation:(enum PERSPECTIVE_VIEW_TYPE)viewType
{
    float duration=0.4f;
    
    switch (viewType) {
        case PERSPECTIVE_VIEW_TYPE_AIRBNB_EFFECT:
        {
            CGRect frontRect=self.frontView.frame;
            
            self.frontView.center=CGPointMake(self.frontView.frame.size.width/2, self.frontView.frame.size.height/2);
            self.rearView.center=CGPointMake(-self.rearView.frame.size.width/2, self.rearView.frame.size.height/2);
            
            [UIView animateWithDuration:duration animations:^{
                
                CATransform3D transform=CATransform3DPerspective(CATransform3DIdentity, -0.002, 0);
                
                transform=CATransform3DRotate(transform, 45.f*M_PI/180, 0, 1, 0);
                transform=CATransform3DTranslate(transform, frontRect.size.width, 0, frontRect.size.width);
                
                self.frontView.layer.transform=transform;
                self.frontView.layer.shouldRasterize=true;
                self.frontView.layer.rasterizationScale=[UIScreen mainScreen].scale;
            }];
        }
            break;
            
        case PERSPECTIVE_VIEW_TYPE_NO_ANIMATION:
        {
            self.frontView.layer.shouldRasterize=false;
            self.frontView.layer.rasterizationScale=[UIScreen mainScreen].scale;
            
            [UIView animateWithDuration:duration animations:^{
                self.frontView.layer.transform=CATransform3DIdentity;
                self.frontView.center=CGPointMake(self.frontView.frame.size.width/2, self.frontView.frame.size.height/2);
                self.frontView.alpha=1;
            }];
        }
            break;
            
        default:
            break;
    }
}

-(void) abc
{
    self.frontView.alpha=0.4f;
    
    CATransform3D transform=CATransform3DIdentity;
    
    transform.m34 = -1.f / 20000;
    float rotate=-45.f*M_PI/180.f;
    
    transform=CATransform3DRotate(transform, rotate, 0.f, 1.f, 0.f);
    transform=CATransform3DTranslate(transform, self.frontView.layer.frame.size.width, 0, 0);
    transform=CATransform3DScale(transform, 1, 0.8f, 1);
    
    self.frontView.layer.transform=transform;
    
    self.frontView.layer.shouldRasterize=true;
    self.frontView.layer.rasterizationScale=[[UIScreen mainScreen] scale];
//    self.center=CGPointMake(self.frame.size.width, self.center.y);
    
//	CATransform3D transform = CATransform3DIdentity;
//	transform.m34 = 1.0 / -500;
//    float rotation=15.f;
//    transform = CATransform3DRotate(transform, rotation * M_PI / 180.0f, 0.0f, -1.0f, 0.0f);
//    transform = CATransform3DScale(transform, 1, 0.8f, 1);
//
//	self.frontView.layer.transform = transform;
//    self.frontView.alpha=0.4f;
}

@end
