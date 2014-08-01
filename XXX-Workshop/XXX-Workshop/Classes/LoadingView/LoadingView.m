//
//  LoadingView.m
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LoadingView.h"

@interface LoadingView()
{
    NSString *_title;
}

@end

@implementation LoadingView

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.backgroundColor=[[UIColor lightGrayColor] colorWithAlphaComponent:0.5f];
    self.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.clipsToBounds=true;
    self.autoresizesSubviews=false;
    
    [self createCenterView];
    [self createActivityIndicator];
    [self createTitle];
    
    self.labelMaxWidth=0;
    
    return self;
}

-(void) createCenterView
{
    UIView *centerView=[[UIView alloc] initWithFrame:CGRectZero];
    centerView.backgroundColor=[UIColor blackColor];
    centerView.userInteractionEnabled=false;
    centerView.autoresizingMask=UIViewAutoresizingNone;
    centerView.layer.cornerRadius=4;
    centerView.layer.masksToBounds=true;
    
    [self addSubview:centerView];
    
    self.centerView=centerView;
}

-(void) createActivityIndicator
{
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithFrame:CGRectZero];
    
    CGSize activityIndicatorSize=[indicator.subviews[0] frame].size;
    indicator.frame=(CGRect){CGPointZero,activityIndicatorSize};
    
    indicator.autoresizingMask=UIViewAutoresizingNone;
    [self  addSubview:indicator];
    
    self.activityIndicator=indicator;
}

-(void) createTitle
{
    UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectZero];
    
    lbl.font=[UIFont fontWithName:@"AvenirNext-Regular" size:12];
    lbl.textColor=[UIColor whiteColor];
    lbl.backgroundColor=[UIColor clearColor];
    lbl.lineBreakMode=NSLineBreakByTruncatingTail;
    
    [self addSubview:lbl];
    
    self.label=lbl;
    _title=nil;
}

-(void)layoutSubviews
{
    self.frame=(CGRect){CGPointZero,self.superview.frame.size};
    
    if(self.frame.size.width==0 || self.frame.size.height==0)
        return;
    
    [self alignTitle];
    [self alignActivityIndicator];
    [self alignCenterView];
    
    if(!self.activityIndicator.isAnimating)
        [self.activityIndicator startAnimating];
}

-(void) alignTitle
{
    bool willResizeLabel=false;
    
    if(!_title)
    {
        willResizeLabel=true;
        _title=self.label.text;
    }
    else if(![_title isEqualToString:self.label.text])
    {
        _title=self.label.text;
        willResizeLabel=true;
    }
    
    if(willResizeLabel)
    {
        [self.label sizeToFit];
        
        if(self.labelMaxWidth>0 && self.label.frame.size.width>self.labelMaxWidth)
        {
            CGRect rect=self.label.frame;
            rect.size.width=self.labelMaxWidth;
            self.label.frame=rect;
        }
    }
    
    self.label.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2+self.label.frame.size.height);
}

-(void) alignActivityIndicator
{
    float y=0;
    
    if(self.label.text.length>0)
        y=self.label.frame.size.height/2;
    
    self.activityIndicator.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2-y);
}

-(void) alignCenterView
{
    CGSize activityIndicatorSize=[self.activityIndicator.subviews[0] frame].size;
    
    CGRect centerRect=CGRectZero;
    float alignCenterSize=20;
    
    centerRect.size.width=MAX(MAX(self.label.frame.size.width,activityIndicatorSize.width),
                              self.label.frame.size.height+activityIndicatorSize.height)+alignCenterSize;
    centerRect.size.height=centerRect.size.width;
    
    centerRect.origin=CGPointMake(self.frame.size.width/2-centerRect.size.width/2, self.frame.size.height/2-centerRect.size.height/2);
    
    self.centerView.frame=centerRect;
}

@end

#import <objc/runtime.h>

static char LoadingViewKey;
@implementation UIView(LoadingView)

-(LoadingView *)loadingView
{
    return objc_getAssociatedObject(self, &LoadingViewKey);
}

-(void)setLoadingView:(LoadingView *)loadingView
{
    objc_setAssociatedObject(self, &LoadingViewKey, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

-(void) showLoading
{
    if(self.loadingView)
    {
        [self.loadingView setNeedsLayout];
        return;
    }
    
    LoadingView *view=[[LoadingView alloc] initWithFrame:(CGRect){CGPointZero,self.frame.size}];

    [self addSubview:view];
    
    self.loadingView=view;
}

-(void)showLoadingWithTitle:(NSString *)title
{
    [self showLoading];
    [self updateLoadingTitle:title];
}

-(void)updateLoadingTitle:(NSString *)title
{
    self.loadingView.label.text=title;
    [self.loadingView setNeedsLayout];
}

-(void)removeLoading
{
    if(self.loadingView)
    {
        [self.loadingView removeFromSuperview];
        self.loadingView=nil;
    }
}

@end