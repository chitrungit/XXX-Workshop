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
    
    NSString *mainBundlePath=[[NSBundle mainBundle] resourcePath];
    mainBundlePath=[mainBundlePath stringByAppendingPathComponent:@"Images"];

    NSError *error=nil;
    NSArray *images=[[NSFileManager defaultManager] contentsOfDirectoryAtPath:mainBundlePath error:&error];

    images=[images filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"SELF CONTAINS '.png'"]];
    
    for(NSString *img in images)
    {
        NSString *imgPath=[mainBundlePath stringByAppendingPathComponent:img];
        UIImage *uiImage=[UIImage imageWithContentsOfFile:imgPath];
        
        GoogleImageObject *obj=[GoogleImageObject new];
        obj.imagePath=imgPath;
        obj.imageSize=uiImage.size;
        
        [_images addObject:obj];
        
        NSLog(@"imgPath %@ %@",img,NSStringFromCGSize(uiImage.size));
    }
    
    [gallery reloadData];
}

-(void)linearPartitionGalleryLoadMore:(LinearPartitionGallery *)lGallery
{
    return;
    if(!_loadingMore)
    {
        NSLog(@"more");
        
        _loadingMore=true;
        
        [self loadMore];
    }
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

    if(_canLoadMore)
        [gallery showLoadMoreWithHeight:80];
    else
        [gallery hideLoadMore];
    
    [gallery reloadData];
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
    
    cell.indexPath=indexPath;
    [cell loadWithImagePath:obj.imagePath];
//    [cell loadWithURL:[NSURL URLWithString:obj.thumbnailURL]];
    
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
        imgv.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0.5 alpha:0.5];
        
        [self addSubview:imgv];
        
        UILabel *label=[[UILabel alloc] initWithFrame:frame];
        label.font=[UIFont systemFontOfSize:12];
        label.textColor=[UIColor redColor];
        label.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0.5 alpha:0.5];
        
        label.autoresizingMask=UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleBottomMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        label.textAlignment=NSTextAlignmentCenter;
        
        [self addSubview:label];
        
        _lbl=label;
        _imgv=imgv;
    }
    return self;
}

-(void)loadWithURL:(NSURL *)url
{
    [self.imgv sd_setImageWithURL:url placeholderImage:nil options:SDWebImageProgressiveDownload];
    self.lbl.text=[NSString stringWithFormat:@"%02i",_indexPath.item];
}

-(void)loadWithImagePath:(NSString *)path
{
    self.imgv.image=[UIImage imageWithContentsOfFile:path];
    self.lbl.text=[NSString stringWithFormat:@"%02i %ix%i",_indexPath.item,(int)self.imgv.image.size.width, (int)self.imgv.image.size.height];
}

@end