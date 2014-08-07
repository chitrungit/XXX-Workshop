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

@protocol LinearPartitionGalleryDataSource <UICollectionViewDataSource>

-(void) linearPartitionGalleryLoadMore:(LinearPartitionGallery*) lGallery;

@end

@interface LinearPartitionGallery : UICollectionView

-(void) showLoadMoreWithHeight:(float) height;
-(void) hideLoadMore;

-(LinearPartitionCollectionLayout *)linearParititonLayout;
@property (nonatomic, weak) id <LinearPartitionGalleryDataSource> dataSource;
@property (nonatomic, weak) IBOutlet id<LinearPartitionCollectionLayoutDelegate> layoutDelegate;

@end
