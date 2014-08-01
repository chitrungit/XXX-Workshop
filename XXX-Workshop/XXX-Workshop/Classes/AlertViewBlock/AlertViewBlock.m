//
//  AlertViewBlock.m
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "AlertViewBlock.h"

@interface AlertViewBlock()<UIAlertViewDelegate>
{
    void(^_onTapped)(AlertViewBlock *alertView, NSUInteger buttonIndex);
}

@end

@implementation AlertViewBlock

-(void)showWithDelegate:(id)delegate
{
    self.delegate=delegate;
    [self show];
}

-(void)showWithBlock:(void (^)(AlertViewBlock *, NSUInteger))onTap
{
    if(onTap)
        _onTapped=[onTap copy];
    
    self.delegate=self;
    
    [self show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(_onTapped)
    {
        _onTapped(self, buttonIndex);
        _onTapped=nil;
    }
}

@end
