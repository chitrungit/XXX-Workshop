//
//  GoogleSearchImage.h
//  XXX-Workshop
//
//  Created by XXX on 8/6/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoogleSearchImage : NSObject



@end

@interface GoogleImageObject : NSObject

@property (nonatomic, strong) NSString *thumbnailURL;
@property (nonatomic, assign) CGSize thumbnailSize;
//@property (nonatomic, strong) NSString *imageURL:

@end