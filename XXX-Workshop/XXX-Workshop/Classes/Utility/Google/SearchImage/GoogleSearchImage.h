//
//  GoogleSearchImage.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GoogleSearchImage;

typedef void(^GoogleSearchImageCompletionBlock)(GoogleSearchImage* search, NSError* error);

@interface GoogleSearchImage : NSObject
{
    GoogleSearchImageCompletionBlock _completionBlock;
}

-(GoogleSearchImage*) initWithKeyword:(NSString*) keyword completionBlock:(GoogleSearchImageCompletionBlock) completionBlock;

-(void) start;
-(void) cancel;

@property (nonatomic, strong, readonly) NSString *keyword;
@property (nonatomic, strong) NSMutableArray *result;
@property (nonatomic, strong, readonly) NSMutableData *data;

@end

@interface GoogleImageObject : NSObject

+(GoogleImageObject*) makeWithDictionary:(NSDictionary*) dict;

@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, assign) CGSize thumbnailSize;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, assign) CGSize imageSize;

@end