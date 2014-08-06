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

-(GoogleSearchImage *)initWithKeyword:(NSString *)keyword
{
    self=[super init];
    
    _keyword=[keyword stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];;
    
    return self;
}

-(void) request
{
    NSURL *url=[NSURL URLWithString:[NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&rsz=8&as_filetype=jpg&start=%i",_keyword,_page*8]];
    
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    _conn=[NSURLConnection connectionWithRequest:request delegate:self];
    
    [_conn start];
}

-(void)start
{
    _result=[NSMutableArray array];
    _page=0;
    _data=nil;
    _canLoadMore=true;
    _loadingMore=false;
    
    [self request];
}

-(void)cancel
{
    [_conn cancel];
}

-(void)loadNext
{
    if(_loadingMore || !_canLoadMore)
        return;
    
    _page++;
    _loadingMore=true;
    
    [self request];
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
            obj.page=_page;
            [_result addObject:obj];
        }
    }
    
    _loadingMore=false;
    _conn=nil;
    
    [self finish:nil];
}

-(void) finish:(NSError*) error
{
    [self.delegate googleSearchImageFinished:self];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _conn=nil;
    _canLoadMore=false;
    _loadingMore=false;
    
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
    obj.imageURL=dict[@"Url"];
    obj.imageSize=CGSizeMake([dict[@"Width"] floatValue], [dict[@"Height"] floatValue]);
    
    return obj;
}

@end