//
//  LinearPartitionGalleryViewController.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoogleSearchGallery;

@interface LinearPartitionGalleryViewController : UIViewController
{
    __weak IBOutlet UITextField *txt;
    __weak IBOutlet GoogleSearchGallery* gallery;
}

@end
