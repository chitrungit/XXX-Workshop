//
//  GoogleSearchImage.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoogleSearchImage;

@protocol GoogleSearchImageDelegate <NSObject>

-(void) googleSearchImageFinished:(GoogleSearchImage*) search;

@end

@class GoogleSearchImage;

@interface GoogleSearchImage : NSObject
{
}

-(GoogleSearchImage*) initWithKeyword:(NSString*) keyword;
-(void) loadNext;

-(void) start;
-(void) cancel;

@property (nonatomic, strong, readonly) NSString *keyword;
@property (nonatomic, strong) NSMutableArray *result;
@property (nonatomic, strong, readonly) NSMutableData *data;
@property (nonatomic, weak) id<GoogleSearchImageDelegate> delegate;
@property (nonatomic, assign, readonly) NSUInteger page;
@property (nonatomic, assign, readonly) bool canLoadMore;
@property (nonatomic, assign, readonly) bool loadingMore;

@end

@interface GoogleImageObject : NSObject

+(GoogleImageObject*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, assign) CGSize thumbnailSize;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, assign) CGSize imageSize;
@property (nonatomic, assign) NSUInteger page;

@end