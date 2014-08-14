//
//  TableLoadMore.m
//  XXX-Workshop
//
//  Created by XXX on 8/12/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "TableTemplates.h"

@interface TableTemplate()
{
    UIRefreshControl *_refreshControl;
}

@end

@implementation TableTemplate

-(void) refresh:(UIRefreshControl*) refreshControl
{
    _loadingMore=true;

//    [self.dataSource tableTemplateRefresh:self];
}

-(void)setContentOffset:(CGPoint)contentOffset
{
    [super setContentOffset:contentOffset];
    
    NSLog(@"%@ %i",_refreshControl,_refreshControl.refreshing);
}

-(void)addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    [super addObserver:observer forKeyPath:keyPath options:options context:context];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIEdgeInsets edgeInsets=self.contentInset;
    
    if(_canRefresh)
    {
        edgeInsets.top=0;
        
        if(!_refreshControl)
        {
            UIRefreshControl *refresh=[[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 60)];
            [refresh addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
            
            [self addSubview:refresh];
            
            _refreshControl=refresh;
        }
    }
    
    if(_canLoadMore)
    {
        edgeInsets.bottom=80;
    }
    
//    self.contentInset=edgeInsets;
}

-(void)markFinishedLoadMore:(bool)canLoadMore
{
    _loadingMore=false;
    _canLoadMore=canLoadMore;
    
    [self reloadData];
}

-(void)markFinishedRefresh:(bool)canRefresh
{
    _refreshing=false;
    _canRefresh=canRefresh;
    
    [self reloadData];
}

@end
