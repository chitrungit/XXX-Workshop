//
//  TableViewCells.h
//  XXX-Workshop
//
//  Created by XXX on 8/14/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DefaultCell <NSObject>

+(void) registerCell:(UITableView*) table;
+(id) dequeueCell:(UITableView*) table;

+(NSString*) reuseIdentifier;

@end

@protocol DynamicHeightCell <NSObject>

-(float) calculatorHeight;
-(void) loadImages;

@end