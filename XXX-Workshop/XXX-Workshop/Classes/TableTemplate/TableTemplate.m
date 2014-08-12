//
//  TableLoadMore.m
//  XXX-Workshop
//
//  Created by XXX on 8/12/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "TableTemplate.h"

@interface TableTemplate()

@end

@implementation TableTemplate

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(_canLoadMore)
    {
        self.contentInset=UIEdgeInsetsMake(0, 0, 80, 0);
        self.scrollIndicatorInsets=self.contentInset;
    }
}

-(void)markFinishedLoadMore:(bool)canLoadMore
{
    _loadingMore=false;
    _canLoadMore=canLoadMore;
    
    [self reloadData];
}

@end
