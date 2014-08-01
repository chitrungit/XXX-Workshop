//
//  KeyboardUtility.m
//  SmartGuide
//
//  Created by MacMini on 11/02/2014.
//  Copyright (c) 2014 Redbase. All rights reserved.
//

#import "KeyboardUtility.h"

static KeyboardUtility *_keyboardUtility=nil;
@implementation KeyboardUtility

+(KeyboardUtility *)shareInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _keyboardUtility=[[KeyboardUtility alloc] init];
    });
    
    return _keyboardUtility;
}

- (id)init
{
    self = [super init];
    if (self) {
        _keyboardState=KEYBOARD_STATE_HIDDEN;
    }
    return self;
}

+(void)load
{
    [[KeyboardUtility shareInstance] registerNotification];
}

-(void) registerNotification
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHide:) name:UIKeyboardDidHideNotification object:nil];
}

-(void) keyboardWillShow:(NSNotification*) notification
{
    _keyboardState=KEYBOARD_STATE_WILL_SHOW;
    _keyboardFrame=[[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
}

-(void) keyboardWillHide:(NSNotification*) notification
{
    _keyboardState=KEYBOARD_STATE_WILL_HIDDEN;
}

-(void) keyboardDidHide:(NSNotification*) notification
{
    _keyboardState=KEYBOARD_STATE_HIDDEN;
}

-(void) keyboardDidShow:(NSNotification*) notification
{
    _keyboardState=KEYBOARD_STATE_SHOWED;
    _keyboardFrame=[[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
}

-(bool)isKeyboardVisible
{
    return _keyboardState==KEYBOARD_STATE_SHOWED||_keyboardState==KEYBOARD_STATE_WILL_SHOW;
}

@end
