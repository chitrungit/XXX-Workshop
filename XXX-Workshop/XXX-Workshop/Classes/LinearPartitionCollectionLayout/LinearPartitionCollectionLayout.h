//
//  LinearPartitionCollectionLayout.h
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LinearPartitionCollectionLayout;

@protocol LinearPartitionCollectionLayoutDelegate<NSObject>

-(CGSize) linearPartition:(LinearPartitionCollectionLayout*) layout sizeAtIndexPath:(NSIndexPath*) indexPath;

@end

@interface LinearPartitionCollectionLayout : UICollectionViewLayout
{
    NSMutableDictionary *_layoutAttributes;
    CGSize _contentSize;
}

@property (nonatomic, weak) IBOutlet id<LinearPartitionCollectionLayoutDelegate> delegate;

@end
