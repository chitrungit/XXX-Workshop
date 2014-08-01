//
//  DLog.h
//  Infory
//
//  Created by XXX on 6/27/14.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#define DLOG_EMERG(dFormat, ...) DLogEmerg(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_ALERT(dFormat, ...) DLogAlert(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_CRIT(dFormat, ...) DLogCrit(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_ERROR(dFormat, ...) DLogError(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_WARNING(dFormat, ...) DLogWarning(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_NOTICE(dFormat, ...) DLogNotice(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_INFO(dFormat, ...) DLogInfo(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})
#define DLOG_DEBUG(dFormat, ...) DLogDebug(^NSString *{ return DLOG_STRING_FORMAT(dFormat, ##__VA_ARGS__);})



NSString* DLOG_STRING_FORMAT(NSString* format, ...);
void DLogEmerg(NSString*(^)());
void DLogAlert(NSString*(^)());
void DLogCrit(NSString*(^)());
void DLogError(NSString*(^)());
void DLogWarning(NSString*(^)());
void DLogNotice(NSString*(^)());
void DLogInfo(NSString*(^)());
void DLogDebug(NSString*(^)());