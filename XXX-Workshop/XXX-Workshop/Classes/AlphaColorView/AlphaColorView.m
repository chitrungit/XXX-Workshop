//
//  AlphaColorView.m
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "AlphaColorView.h"

@implementation AlphaColorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        self.backgroundColor=[UIColor darkGrayColor];
        self.alpha=0;
    }
    return self;
}

@end

#import <objc/runtime.h>

static char AlphaColorViewKey;
@implementation UIView(AlphaColorView)

-(AlphaColorView *)alphaView
{
    return objc_getAssociatedObject(self, &AlphaColorViewKey);
}

-(void)setAlphaView:(AlphaColorView *)alphaView
{
    objc_setAssociatedObject(self, &AlphaColorViewKey, alphaView, OBJC_ASSOCIATION_ASSIGN);
}

-(void)makeAlphaView
{
    if(self.alphaView)
        return;
    
    AlphaColorView *view=[[AlphaColorView alloc] initWithFrame:(CGRect){CGPointZero, self.frame.size}];
    [self addSubview:view];
    
    self.alphaView=view;
}

-(void)makeAlphaViewWithColor:(UIColor *)color
{
    [self makeAlphaView];
    self.alphaView.backgroundColor=color;
}

-(void)removeAlphaView
{
    if(self.alphaView)
    {
        [self.alphaView removeFromSuperview];
        self.alphaView=nil;
    }
}

@end