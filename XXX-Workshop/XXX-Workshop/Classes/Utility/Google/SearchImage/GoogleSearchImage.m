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

-(GoogleSearchImage *)initWithKeyword:(NSString *)keyword pageSize:(NSUInteger)pageSize page:(NSUInteger)page
{
    self=[super init];
    
    NSString *query=[keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&rsz=%i&as_filetype=jpg&start=%i",query,pageSize,page]];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    
    _conn=[NSURLConnection connectionWithRequest:request delegate:self];
    
    return self;
}

-(void)start
{
    _result=[NSMutableArray array];
    _data=nil;
    _canLoadMore=true;
    
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
    _data=nil;
    
    id responseData=json[@"responseData"];
    
    if(!responseData || [responseData isKindOfClass:[NSNull class]])
    {
        _canLoadMore=false;
    }
    else
    {
        _canLoadMore=true;
        
        NSArray *images=responseData[@"results"];
        
        for(NSDictionary *dict in images)
        {
            GoogleImageObject *obj=[GoogleImageObject makeWithDictionary:dict];
            [_result addObject:obj];
        }
    }
    
    [self finish:nil];
}

-(void) finish:(NSError*) error
{
    _conn=nil;
    [self.delegate googleSearchImageFinished:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _canLoadMore=false;
    [self finish:error];
}

-(void)dealloc
{
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
    obj.imageURL=dict[@"url"];
    obj.imageSize=CGSizeMake([dict[@"width"] floatValue], [dict[@"height"] floatValue]);
    
    return obj;
}

@end