//
//  GoogleSearchImage.m
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "GoogleSearchImage.h"

@interface GoogleSearchImage()<NSURLConnectionDataDelegate>
{
    NSURLConnection *_conn;
}

@end

@implementation GoogleSearchImage

-(GoogleSearchImage *)initWithKeyword:(NSString *)keyword completionBlock:(GoogleSearchImageCompletionBlock)completionBlock
{
    self=[super init];
    
    _keyword=keyword;
    _completionBlock=[completionBlock copy];
    
    NSString *text=[keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&rsz=8&as_filetype=jpg",text]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    _conn=[NSURLConnection connectionWithRequest:request delegate:self];
    
    return self;
}

-(void)start
{
    [_conn start];
}

-(void)cancel
{
    [_conn cancel];
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if(!_data)
        _data=[NSMutableData dataWithData:data];
    else
        [_data appendData:data];
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error=nil;
    NSDictionary *json=[NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingAllowFragments|NSJSONReadingMutableContainers|NSJSONReadingMutableLeaves error:&error];
    NSArray *images=json[@"responseData"][@"results"];
    
    _result=[NSMutableArray array];
    for(NSDictionary *dict in images)
    {
        [_result addObject:[GoogleImageObject makeWithDictionary:dict]];
    }
    
    [self finish:nil];
}

-(void) finish:(NSError*) error
{
    if(_completionBlock)
        _completionBlock(self,error);
    
    _completionBlock=nil;
    
    _conn=nil;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self finish:error];
}

-(void)dealloc
{
    _completionBlock=nil;
    
    if(_conn)
    {
        [_conn cancel];
        _conn=nil;
    }
}

@end

@implementation GoogleImageObject

+(GoogleImageObject *)makeWithDictionary:(NSDictionary *)dict
{
    GoogleImageObject *obj=[GoogleImageObject new];
    obj.thumbnailURL=dict[@"tbUrl"];
    obj.thumbnailSize=CGSizeMake([dict[@"tbWidth"] floatValue], [dict[@"tbHeight"] floatValue]);
    obj.imageURL=dict[@"Url"];
    obj.imageSize=CGSizeMake([dict[@"Width"] floatValue], [dict[@"Height"] floatValue]);
    
    return obj;
}

@end