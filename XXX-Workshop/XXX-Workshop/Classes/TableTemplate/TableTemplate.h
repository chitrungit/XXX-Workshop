//
//  TableLoadMore.h
//  XXX-Workshop
//
//  Created by XXX on 8/12/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TableTemplate;

@protocol TableTemplateDataSource <UITableViewDataSource>

-(void) tableTemplateLoadMore:(TableTemplate*) table;

@end

@interface TableTemplate : UITableView

-(void) markFinishedLoadMore:(bool) canLoadMore;

@property (nonatomic, assign) unsigned int pageSize;
@property (nonatomic, assign) unsigned int page;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, readonly) bool loadingMore;
@property (nonatomic, weak) id<TableTemplateDataSource> dataSource;

@end
