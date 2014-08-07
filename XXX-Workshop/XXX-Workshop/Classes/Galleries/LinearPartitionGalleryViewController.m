//
//  LinearPartitionGalleryViewController.m
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LinearPartitionGalleryViewController.h"
#import "LinearPartitionGallery.h"
#import "GoogleSearchImage.h"
#import "LoadingView.h"

@interface LinearPartitionGalleryViewController ()<UITextFieldDelegate,UICollectionViewDataSource,LinearPartitionGalleryDataSource,LinearPartitionCollectionLayoutDelegate,GoogleSearchImageDelegate>
{
    GoogleSearchImage *_search;
    int _page;
    bool _canLoadMore;
    NSMutableArray *_images;
    bool _loadingMore;
}

@end

@implementation LinearPartitionGalleryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
 
    _canLoadMore=false;
    _loadingMore=false;
    [gallery registerClass:[ImageCell class] forCellWithReuseIdentifier:@"cell"];
    
    _images=[NSMutableArray array];
    _page=0;
    [txt becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) searchWithKeyword:(NSString*) keyword
{
    if(_search)
    {
        [_search cancel];
        _search=nil;
    }
    
    _page=0;
    _images=[NSMutableArray array];

    [gallery deleteSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, gallery.numberOfSections)]];
    
    _search=[[GoogleSearchImage alloc] initWithKeyword:keyword pageSize:8 page:_page];
    _search.delegate=self;
    
    [_search start];
}

-(void) loadMore
{
    _search=[[GoogleSearchImage alloc] initWithKeyword:txt.text pageSize:8 page:_page];
    _search.delegate=self;
    
    [_search start];
}

-(void)googleSearchImageFinished:(GoogleSearchImage *)search
{
    _page++;
    _canLoadMore=search.canLoadMore;
    _loadingMore=false;
    
    [_images addObjectsFromArray:search.result];

    _search=nil;

    [gallery reloadData];
//    if(_page==1)
//    {
//        [gallery performBatchUpdates:^{
//            [gallery insertSections:[NSIndexSet indexSetWithIndex:0]];
//        } completion:^(BOOL finished) {
//            if(_canLoadMore)
//                [gallery showLoadMoreWithHeight:80];
//            else
//                [gallery hideLoadMore];
//        }];
//    }
//    else
//    {
//        NSMutableArray *array=[NSMutableArray array];
//        
//        for(int i=0;i<search.result.count;i++)
//        {
//            [array addObject:[NSIndexPath indexPathForItem:_images.count-search.result.count+1+i inSection:0]];
//        }
//        
//        [gallery insertItemsAtIndexPaths:array];
//    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.view endEditing:true];
    
    [self searchWithKeyword:textField.text];
    
    return true;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return MIN(1, _images.count);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ImageCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    GoogleImageObject *obj=_images[indexPath.item];
    
    cell.backgroundColor=[UIColor clearColor];
    [cell loadWithURL:[NSURL URLWithString:obj.thumbnailURL]];
    
    if(indexPath.row==_images.count-1)
    {
        if(!_loadingMore)
        {
            _loadingMore=true;
            
            [self loadMore];
        }
    }
    
    return cell;
}

-(CGSize)linearPartition:(LinearPartitionCollectionLayout *)layout sizeAtIndexPath:(NSIndexPath *)indexPath
{
    GoogleImageObject *obj=_images[indexPath.item];

    return obj.imageSize;
}

@end

#import "UIImageView+Webcache.h"

@implementation ImageCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        frame.origin=CGPointZero;
        UIImageView *imgv=[[UIImageView alloc] initWithFrame:frame];
        imgv.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        
        [self addSubview:imgv];
        
        _imgv=imgv;
    }
    return self;
}

-(void)loadWithURL:(NSURL *)url
{
    [self.imgv sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload];
}

@end