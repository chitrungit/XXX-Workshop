//
//  PerspectivePageViewController.h
//  XXX-Workshop
//
//  Created by XXX on 8/5/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PerspectivePageView;

@interface PerspectivePageViewController : UIViewController
{
    __weak IBOutlet PerspectivePageView *perspectiveView;
    __weak IBOutlet UITableView *tableRear;
    __weak IBOutlet UITableView *tableFront;
}

@end
