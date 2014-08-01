//
//  AlphaColorView.h
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphaColorView : UIView

@end

@interface UIView(AlphaColorView)

-(void) makeAlphaView;
-(void) makeAlphaViewWithColor:(UIColor*) color;
-(void) removeAlphaView;

@property (nonatomic, weak, readwrite) AlphaColorView *alphaView;

@end