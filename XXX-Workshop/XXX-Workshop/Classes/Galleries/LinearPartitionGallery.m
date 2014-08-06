//
//  LinearPartitionGallery.m
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LinearPartitionGallery.h"

@interface LinearPartitionGallery()
{
    __weak UIActivityIndicatorView *indicator;
}

@end

@implementation LinearPartitionGallery

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    LinearPartitionCollectionLayout *linearPartitionLayout=[LinearPartitionCollectionLayout new];
    linearPartitionLayout.delegate=self;
    UICollectionView *view=[[UICollectionView alloc] initWithFrame:(CGRect){CGPointZero, self.frame.size} collectionViewLayout:linearPartitionLayout];
    
    view.dataSource=self;
    view.delegate=self;
    
    [self addSubview:view];
    
    _collectionView=view;
}

-(void)markFinishLoadMore:(bool)canLoadMore items:(NSArray *)items
{
    _loadingMore=false;
    _canLoadMore=canLoadMore;
}

#pragma mark LinearPartitionCollectionLayoutDelegate

-(CGSize)linearPartition:(LinearPartitionCollectionLayout *)layout sizeAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeZero;
}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 0;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 0;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [UICollectionViewCell new];
}

#pragma mark UICollectionViewDelegate

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

@end
