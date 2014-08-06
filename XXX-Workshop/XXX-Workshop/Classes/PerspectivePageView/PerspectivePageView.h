//
//  PerspectivePageView.h
//  XXX-Workshop
//
//  Created by XXX on 8/5/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

enum PERSPECTIVE_VIEW_TYPE
{
    PERSPECTIVE_VIEW_TYPE_NO_ANIMATION=0,
    PERSPECTIVE_VIEW_TYPE_AIRBNB_EFFECT=1,
    PERSPECTIVE_VIEW_TYPE_MOVE_LEFT=2,
    PERSPECTIVE_VIEW_TYPE_ROTATE_LEFT=3,
    PERSPECTIVE_VIEW_TYPE_MOVE_DOWN=4,
    PERSPECTIVE_VIEW_TYPE_ROTATE_TOP=5,
    PERSPECTIVE_VIEW_TYPE_LAY_DOWN=6
};

@interface PerspectivePageView : UIView

-(void) showRearViewWithAnimation:(enum PERSPECTIVE_VIEW_TYPE) viewType;

@property (nonatomic, weak) IBOutlet UIView *rearView;
@property (nonatomic, weak) IBOutlet UIView *frontView;

@end
