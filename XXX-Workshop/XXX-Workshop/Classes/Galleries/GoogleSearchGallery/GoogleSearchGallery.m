//
//  GoogleSearchGallery.m
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "GoogleSearchGallery.h"
#import "GoogleSearchImage.h"

@interface GoogleSearchGallery()<GoogleSearchImageDelegate>
{
    GoogleSearchImage *_search;
    
    NSMutableArray *_images;
}

@end

@implementation GoogleSearchGallery

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [self.collectionView registerClass:[GoogleSearchGalleryCell class] forCellWithReuseIdentifier:[GoogleSearchGalleryCell reuseIdentifier]];
    [self.collectionView registerClass:[GoogleSearchGalleryLoadMoreCell class] forCellWithReuseIdentifier:[GoogleSearchGalleryLoadMoreCell reuseIdentifier]];
}

-(void)searchImage:(NSString *)keyword
{
    if(_search)
    {
        [_search cancel];
        _search=nil;
    }
    
    _search=[[GoogleSearchImage alloc] initWithKeyword:keyword];
    _search.delegate=self;
    
    [_search start];
    
    [self showLoadingWithTitle:@"Search..."];
}

-(void)googleSearchImageFinished:(GoogleSearchImage *)search
{
    [self removeLoading];
    
    _images=search.result;
    
    if(_search.page==0)
        [self.collectionView reloadData];
    else
    {
        NSArray *items=[_search.result filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"page==%i",_search.page]];
        
        [self markFinishLoadMore:true items:items];
    }
}

-(void)markFinishLoadMore:(bool)canLoadMore items:(NSArray *)items
{
    [super markFinishLoadMore:canLoadMore items:items];

    [self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    
    return 2;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if(section==0)
        return _images.count;
    else
        return 1;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        GoogleSearchGalleryCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[GoogleSearchGalleryCell reuseIdentifier] forIndexPath:indexPath];
        GoogleImageObject *obj=_images[indexPath.item];
        
        [cell loadWithURL:[NSURL URLWithString:obj.thumbnailURL]];
        
        return cell;
    }
    else
    {
        GoogleSearchGalleryLoadMoreCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:[GoogleSearchGalleryLoadMoreCell reuseIdentifier] forIndexPath:indexPath];
        
        return cell;
    }
}

-(CGSize)linearPartition:(LinearPartitionCollectionLayout *)layout sizeAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0)
    {
        GoogleImageObject *obj=_images[indexPath.item];
        
        return obj.thumbnailSize;
    }
    else
        return CGSizeMake(self.collectionView.frame.size.width, 80);
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}

@end

#import "UIImageView+WebCache.h"

@implementation GoogleSearchGalleryCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    UIImageView *imgv=[[UIImageView alloc] initWithFrame:(CGRect){CGPointZero,frame.size}];
    
    imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin;
    
    [self addSubview:imgv];
    
    imgvImage=imgv;
    
    return self;
}

-(void)loadWithURL:(NSURL *)url
{
    [imgvImage sd_setImageWithURL:url];
}

+(NSString *)reuseIdentifier
{
    return @"GoogleSearchGalleryCell";
}

@end

@implementation GoogleSearchGalleryLoadMoreCell

-(id)initWithFrame:(CGRect)frame
{
    self=[super initWithFrame:frame];
    
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self showLoading];
}

+(NSString *)reuseIdentifier
{
    return @"GoogleSearchGalleryLoadMoreCell";
}

@end