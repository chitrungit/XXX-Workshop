//
//  GoogleSearchGallery.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LinearPartitionGallery.h"
#import "LoadingView.h"

@interface GoogleSearchGallery : LinearPartitionGallery

-(void) searchImage:(NSString*) keyword;

@end

@interface GoogleSearchGalleryCell : UICollectionViewCell
{
    __weak UIImageView *imgvImage;
}

-(void) loadWithURL:(NSURL*) url;

+(NSString *)reuseIdentifier;

@end

@interface GoogleSearchGalleryLoadMoreCell : UICollectionViewCell

+(NSString *)reuseIdentifier;

@end