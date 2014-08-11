//
//  LinearPartitionGallery.m
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LinearPartitionGallery.h"
#import "LoadingView.h"

@interface LinearPartitionGallery()
{
    __weak UIActivityIndicatorView *indicator;
}

@end

@implementation LinearPartitionGallery

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    LinearPartitionCollectionLayout *linearPartitionLayout=(id)self.collectionViewLayout;
    if(![linearPartitionLayout isKindOfClass:[LinearPartitionCollectionLayout class]])
    {
        LinearPartitionCollectionLayout *linearPartitionLayout=[LinearPartitionCollectionLayout new];
        
        self.collectionViewLayout=linearPartitionLayout;
    }
    
    linearPartitionLayout.delegate=self.layoutDelegate;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self alignLoadingMore];
}

-(void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    
    [self alignLoadingMore];
}

-(LinearPartitionCollectionLayout *)linearParititonLayout
{
    return (id)self.collectionViewLayout;
}

-(void)showLoadMoreWithHeight:(float)height
{
    UIEdgeInsets insets=self.contentInset;
    insets.bottom=height;
    
    self.contentInset=insets;
    
    [self showLoadingWithRect:CGRectMake(0, self.contentSize.height, self.frame.size.width, height)];
    
    [self alignLoadingMore];
}

-(void)hideLoadMore
{
    [self removeLoading];
    [self alignLoadingMore];
}

-(void) alignLoadingMore
{
    if(self.loadingView)
    {
        bool needLayout=false;
        
        UIEdgeInsets insets=self.contentInset;
        
        if(!needLayout)
            needLayout=insets.bottom!=self.loadingView.frame.size.height;
        
        insets.bottom=self.loadingView.frame.size.height;
        
        self.contentInset=insets;
        
        CGRect rect=self.loadingView.frame;
        
        if(!needLayout)
            needLayout=rect.origin.y!=self.contentSize.height;
        
        rect.origin.y=self.contentSize.height;
        self.loadingView.frame=rect;
        
        if(needLayout)
            [self setNeedsLayout];
    }
    else
    {
        UIEdgeInsets insets=self.contentInset;
        
        bool needLayout=insets.bottom!=0;
        insets.bottom=0;
        
        self.contentInset=insets;
        
        if(needLayout)
            [self setNeedsLayout];
    }
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    if(self.loadingView)
    {
        float offsetY=contentOffset.y+self.frame.size.height;
        float lY=self.loadingView.frame.origin.y;
        
        if(offsetY-lY>0)
            [self.dataSource linearPartitionGalleryLoadMore:self];
    }
}

@end
