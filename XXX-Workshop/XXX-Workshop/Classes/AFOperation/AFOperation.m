//
//  AFOperation.m
//  XXX-Workshop
//
//  Created by XXX on 8/11/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "AFOperation.h"

@implementation AFOperation

-(instancetype)initWithRequest:(NSURLRequest *)urlRequest
{
    self=[super initWithRequest:urlRequest];
    
    self.parameters=[NSMutableDictionary dictionary];
    self.storeData=[NSMutableDictionary dictionary];
    
    return self;
}

-(id)copyWithZone:(NSZone *)zone
{
    AFOperation *ope=[super copyWithZone:zone];
    
    ope.parameters=[self.parameters copy];
    ope.storeData=[self.storeData copy];
    
    return ope;
}

-(void) finishedWithResponseObject:(id) responseObject error:(NSError*) error
{
    [self finishedLoading];
    [self.delegate afOperationFinished:self error:error];
}

-(void)finishedLoading
{
    
}

-(void)addToQueue
{
    [[AFOperationManager shareInstance] addAFOperation:self];
}

-(void)start
{
    __weak AFOperation *wSelf=self;
    [self setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if(wSelf)
            [wSelf finishedWithResponseObject:responseObject error:nil];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if(wSelf)
            [wSelf finishedWithResponseObject:nil error:error];
    }];
    
    [super start];
}

- (void)dealloc
{
    self.storeData=nil;
    self.parameters=nil;
    self.delegate=nil;
}

@end

static AFOperationManager* _afOperationManager=nil;
@implementation AFOperationManager

+(AFOperationManager *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _afOperationManager=[AFOperationManager manager];
    });
    
    return _afOperationManager;
}

+(instancetype)manager
{
    AFOperationManager *manager=[super manager];
    
    return manager;
}

-(instancetype)initWithBaseURL:(NSURL *)url
{
    self=[super initWithBaseURL:url];
    
    _jsonRequestSerializer=[AFJSONRequestSerializer serializer];
    
    return self;
}

-(AFHTTPRequestSerializer *)httpRequestSerializer
{
    return self.requestSerializer;
}

-(void)addAFOperation:(AFOperation *)operation
{
    [self.operationQueue addOperation:operation];
}

-(AFOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
{
    AFOperation *operation = [[AFOperation alloc] initWithRequest:request];
    operation.responseSerializer = self.responseSerializer;
    operation.shouldUseCredentialStorage = self.shouldUseCredentialStorage;
    operation.credential = self.credential;
    operation.securityPolicy = self.securityPolicy;
    
    operation.completionQueue = self.completionQueue;
    operation.completionGroup = self.completionGroup;
    
    return operation;
}

-(AFOperation *)GET:(NSString *)URLString parameters:(id)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"GET" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

-(AFOperation *)HEAD:(NSString *)URLString parameters:(id)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"HEAD" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

-(AFOperation *)POST:(NSString *)URLString parameters:(id)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

-(AFOperation *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block
{
    NSMutableURLRequest *request = [self.requestSerializer multipartFormRequestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters constructingBodyWithBlock:block error:nil];
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

-(AFOperation *)PUT:(NSString *)URLString parameters:(id)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"PUT" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

-(AFOperation *)PATCH:(NSString *)URLString parameters:(id)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"PATCH" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

-(AFOperation *)DELETE:(NSString *)URLString parameters:(id)parameters
{
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"DELETE" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];
    AFOperation *operation = [self HTTPRequestOperationWithRequest:request];
    
    return operation;
}

@end