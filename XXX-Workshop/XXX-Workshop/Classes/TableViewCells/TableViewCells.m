//
//  TableViewCells.m
//  XXX-Workshop
//
//  Created by XXX on 8/14/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "TableViewCells.h"

@implementation EmptyCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    self.backgroundColor=[UIColor clearColor];
    self.contentView.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    
    self.autoresizesSubviews=false;
    
    return self;
}

-(void)layoutSubviews
{
    
}

+(NSString *)reuseIdentifier
{
    return @"EmptyCell";
}

@end

@implementation UITableView(EmptyCell)

-(void)registerEmptyCell
{
    [self registerClass:[EmptyCell class] forCellReuseIdentifier:[EmptyCell reuseIdentifier]];
}

-(EmptyCell *)emptyCell
{
    return [self dequeueReusableCellWithIdentifier:[EmptyCell reuseIdentifier]];
}

@end

@implementation LoadingCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        frame.origin=CGPointZero;
        UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithFrame:frame];
        indicator.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self.contentView addSubview:indicator];
        
        _activityIndicator=indicator;
        
        self.backgroundColor=[UIColor clearColor];
        self.contentView.backgroundColor=[UIColor clearColor];
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [_activityIndicator startAnimating];
}

+(NSString *)reuseIdentifier
{
    return @"LoadingCell";
}

@end

@implementation UITableView(LoadingCell)

-(void)registerLoadingCell
{
    [self registerClass:[LoadingCell class] forCellReuseIdentifier:[LoadingCell reuseIdentifier]];
}

-(LoadingCell *)loadingCell
{
    return [self dequeueReusableCellWithIdentifier:[LoadingCell reuseIdentifier]];
}

@end

#import <objc/runtime.h>

static char TableView_LoadingView_Key;
@implementation UITableView(LoadingView)

-(UIView *)loadingView
{
    return objc_getAssociatedObject(self, &TableView_LoadingView_Key);
}

-(void)setLoadingView:(UIView *)loadingView
{
    objc_setAssociatedObject(self, &TableView_LoadingView_Key, loadingView, OBJC_ASSOCIATION_ASSIGN);
}

-(UIView *)showLoadingView
{
    if(self.loadingView)
    {
        UIActivityIndicatorView *indicator=(id)[self.loadingView viewWithTag:0];
        
        [indicator startAnimating];
        
        return self.loadingView;
    }
    
    float loadingViewHeight=80;
    
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, self.contentSize.height, self.frame.size.width, loadingViewHeight)];
    view.backgroundColor=[UIColor clearColor];
    
    view.userInteractionEnabled=false;
    
    CGRect rect=self.frame;
    rect.origin=CGPointZero;
    
    UIActivityIndicatorView *indicator=[[UIActivityIndicatorView alloc] initWithFrame:rect];
    indicator.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    indicator.tag=0;
    
    [view addSubview:indicator];
    
    [indicator startAnimating];
    
    UIEdgeInsets edgeInsets=self.contentInset;
    
    edgeInsets.bottom=loadingViewHeight;
    
    self.contentInset=edgeInsets;
    
    self.loadingView=view;
    
    return self.loadingView;
}

-(void)removeLoadingView
{
    if(self.loadingView)
    {
        UIEdgeInsets edgeInsets=self.contentInset;
        
        edgeInsets.bottom-=self.loadingView.frame.size.height;
        
        [((UIActivityIndicatorView*)[self.loadingView viewWithTag:0]) stopAnimating];
        [self.loadingView removeFromSuperview];
        self.loadingView=nil;
    }
}

@end