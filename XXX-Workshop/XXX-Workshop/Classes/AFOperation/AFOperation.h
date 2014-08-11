//
//  AFOperation.h
//  XXX-Workshop
//
//  Created by XXX on 8/11/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "AFURLConnectionOperation.h"
#import "AFHTTPRequestOperationManager.h"

enum AFOPERATION_METHOD_TYPE
{
    AFOPERATION_METHOD_TYPE_GET=0,
    AFOPERATION_METHOD_TYPE_POST=1,
};

@class AFOperation;

@protocol AFOperationDelegate <NSObject>

-(void) afOperationFinished:(AFOperation*) operation error:(NSError*) error;

@end

@interface AFOperation : AFHTTPRequestOperation

-(void) finishedLoading;
-(void) addToQueue;

@property (nonatomic, weak) id<AFOperationDelegate> delegate;
@property (nonatomic, strong) NSMutableDictionary *parameters;
@property (nonatomic, strong) NSMutableDictionary *storeData;

@end

@interface AFOperationManager : AFHTTPRequestOperationManager

+(AFOperationManager*) shareInstance;

-(void) addAFOperation:(AFOperation*) operation;

-(AFOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request;
-(AFOperation *)GET:(NSString *)URLString parameters:(id)parameters;
-(AFOperation *)HEAD:(NSString *)URLString parameters:(id)parameters;
-(AFOperation *)POST:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id<AFMultipartFormData>))block;
-(AFOperation *)POST:(NSString *)URLString parameters:(id)parameters;
-(AFOperation *)PUT:(NSString *)URLString parameters:(id)parameters;
-(AFOperation *)PATCH:(NSString *)URLString parameters:(id)parameters;
-(AFOperation *)DELETE:(NSString *)URLString parameters:(id)parameters;

-(AFHTTPRequestSerializer*) httpRequestSerializer;
@property (nonatomic, readonly, strong) AFJSONRequestSerializer *jsonRequestSerializer;

@end