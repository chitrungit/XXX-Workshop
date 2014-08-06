//
//  LinearPartitionGallery.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LinearPartitionCollectionLayout.h"

@class LinearPartitionGallery;

@protocol LinearPartitionGalleryDelegate <NSObject>

-(void) linearPartitionGalleryRequestLoadMore:(LinearPartitionGallery*) lGallery;

@end

@interface LinearPartitionGallery : UIView<LinearPartitionCollectionLayoutDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

-(void) markFinishLoadMore:(bool) canLoadMore items:(NSArray*) items;

@property (nonatomic, readonly) bool loadingMore;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, weak, readonly) UICollectionView *collectionView;
@property (nonatomic, weak) id<LinearPartitionGalleryDelegate> delegate;

@end
