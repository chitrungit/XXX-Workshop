//
//  LoadingView.h
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoadingView : UIView
{
}

@property (nonatomic, weak) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, weak) UIView *centerView;
@property (nonatomic, weak) UILabel *label;
@property (nonatomic, assign) float labelMaxWidth;

@end

@interface UIView(LoadingView)

-(void) showLoading;
-(void) showLoadingWithTitle:(NSString*) title;
-(void) updateLoadingTitle:(NSString*) title;
-(void) removeLoading;

@property (nonatomic, weak, readwrite) LoadingView *loadingView;

@end