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

@optional
-(void) tableTemplateLoadMore:(TableTemplate*) table;
-(void) tableTemplateRefresh:(TableTemplate*) table;

@end

@interface TableTemplate : UITableView

-(void) markFinishedLoadMore:(bool) canLoadMore;
-(void) markFinishedRefresh:(bool) canRefresh;

@property (nonatomic, assign) unsigned int pageSize;
@property (nonatomic, assign) unsigned int page;
@property (nonatomic, assign) bool canLoadMore;
@property (nonatomic, assign) bool canRefresh;
@property (nonatomic, readonly) bool loadingMore;
@property (nonatomic, readonly) bool refreshing;
@property (nonatomic, weak) id<TableTemplateDataSource> dataSource;

@end
