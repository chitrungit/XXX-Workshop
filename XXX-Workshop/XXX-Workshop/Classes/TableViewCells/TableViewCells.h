//
//  TableViewCells.h
//  XXX-Workshop
//
//  Created by XXX on 8/14/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DefaultCell <NSObject>

+(NSString*) reuseIdentifier;

@end

@protocol DynamicHeightCell <NSObject>

-(float) calculatorHeight;
-(void) loadImages;

@end

@interface EmptyCell : UITableViewCell<DefaultCell>

@end

@interface UITableView(EmptyCell)

-(void) registerEmptyCell;
-(EmptyCell*) emptyCell;

@end

@interface LoadingCell : UITableViewCell<DefaultCell>

@property (nonatomic, weak, readonly) UIActivityIndicatorView *activityIndicator;

@end

@interface UITableView(LoadingCell)

-(void) registerLoadingCell;
-(LoadingCell*) loadingCell;

@end

@interface UITableView(LoadingView)

-(UIView*) showLoadingView;
-(void) removeLoadingView;

@property (nonatomic, weak, readwrite) UIView *loadingView;

@end