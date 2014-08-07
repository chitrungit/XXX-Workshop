//
//  LinearPartitionGalleryViewController.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LinearPartitionGallery;

@interface LinearPartitionGalleryViewController : UIViewController
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet LinearPartitionGallery* gallery;
}

@end

@interface ImageCell : UICollectionViewCell

-(void) loadWithURL:(NSURL*) url;

@property (nonatomic, weak, readonly) UIImageView *imgv;
@property (nonatomic, weak, readonly) UILabel *lbl;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end