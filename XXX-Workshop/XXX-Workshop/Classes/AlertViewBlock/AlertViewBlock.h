//
//  AlertViewBlock.h
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ALERT_VIEW_BLOCK_INIT(a_title,a_message,a_cancel,a_other,...) [[AlertViewBlock alloc] initWithTitle:a_title message:a_message delegate:nil cancelButtonTitle:a_cancel otherButtonTitles:a_other, ##__VA_ARGS__]

@interface AlertViewBlock : UIAlertView

-(void) showWithDelegate:(id) delegate;
-(void) showWithBlock:(void(^)(AlertViewBlock *alertView, NSUInteger buttonIndex)) onTap;

@end
