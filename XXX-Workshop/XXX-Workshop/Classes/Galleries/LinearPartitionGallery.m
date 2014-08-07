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
}

-(void)hideLoadMore
{
    [self removeLoading];
    
}

-(void)setContentOffset:(CGPoint)contentOffset
{
//    if(self.loadingView)
//    {
//        NSLog(@"%f",contentOffset.y-self.loadingView.frame.origin.y);
//    }
    
    [super setContentOffset:contentOffset];
}

@end
