//
//  LoadingViewController.m
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import "LoadingViewController.h"
#import "LoadingView.h"

@interface LoadingViewController ()
{
    CGPoint _startPoint;
    CGRect _dragViewFrame;
    
    int _count;
}

@end

@implementation LoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _count=0;
    [dragView showLoading];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _dragViewFrame=dragView.frame;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint pnt=[touch locationInView:self.view];
    
    _startPoint=pnt;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch=[touches anyObject];
    CGPoint pnt=[touch locationInView:self.view];
    
    CGRect rect=dragView.frame;
    rect.origin=pnt;
    rect.size=CGSizeMake(_dragViewFrame.size.width+(pnt.x-_startPoint.x), _dragViewFrame.size.height+(pnt.y-_startPoint.y));
    dragView.frame=rect;
    
    [dragView updateLoadingTitle:[NSString stringWithFormat:@"Loading Loading %i",_count++]];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endDrag];
    [dragView updateLoadingTitle:@""];
    _count=0;
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self endDrag];
}

-(void) endDrag
{
    dragView.frame=_dragViewFrame;
}

@end
