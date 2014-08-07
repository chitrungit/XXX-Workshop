//
//  DLog.m
//  Infory
//
//  Created by XXX on 6/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "DLog.h"

typedef NS_OPTIONS(NSUInteger, DLOG_TYPE)
{
    DLOG_TYPE_EMERG = 1 << 0,
    DLOG_TYPE_ALERT = 1 << 1,
    DLOG_TYPE_CRIT = 1 << 2,
    DLOG_TYPE_ERR = 1 << 3,
    DLOG_TYPE_WARNING = 1 << 4,
    DLOG_TYPE_NOTICE = 1 << 5,
    DLOG_TYPE_INFO = 1 << 6,
    DLOG_TYPE_DEBUG = 1 << 7,
    DLOG_TYPE_DOWNLOAD = 1 << 8,
};

const DLOG_TYPE DLOG_CURRENT_LEVEL=DLOG_TYPE_DEBUG | DLOG_TYPE_INFO | DLOG_TYPE_DOWNLOAD;

NSString* DLOG_STRING_FORMAT(NSString* format, ...)
{
    va_list args;
    va_start(args, format);
    
    NSString *str=[[NSString alloc] initWithFormat:format arguments:args];
    
    va_end(args);
    
    return str;
}

void DLog(DLOG_TYPE logLevel, NSString*(^logString)())
{
#if DEBUG
    if(DLOG_CURRENT_LEVEL & logLevel)
    {
        NSLog(@"%@",logString());
    }
#endif
    
    logString=nil;
}

void DLogAlert(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogCrit(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogError(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogWarning(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogNotice(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogInfo(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogDebug(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DEBUG, logString);
}

void DLogDownload(NSString*(^logString)())
{
    DLog(DLOG_TYPE_DOWNLOAD, logString);
}