//
//  TableLoadMore.m
//  XXX-Workshop
//
//  Created by XXX on 8/12/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "TableTemplates.h"

@interface TableTemplate()

@end

@implementation TableTemplate

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    UIEdgeInsets edgeInsets=self.contentInset;
    
    if(_canRefresh)
    {
        edgeInsets.top=80;
    }

    if(_canLoadMore)
    {
        edgeInsets.bottom=80;
    }
    
    self.contentInset=edgeInsets;
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
