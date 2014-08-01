//
//  Utility.h
//  XXX-Workshop
//
//  Created by XXX on 8/1/14.
//  Copyright (c) 2014 XXX. All rights reserved.
//

#import <Foundation/Foundation.h>

CGSize CGSizeResizeToWidth(float width, CGSize size);
CGSize CGSizeResizeToHeight(float width, CGSize size);

NSString *documentPath();
NSString *UUID();

UIColor *color255(float r, float g, float b, float a);

@interface NSString(Utility)

+(NSString*) makeString:(id) obj;
-(NSString*) ASIString;

@end

@interface NSDate(Utility)

-(NSString*) stringValueWithFormat:(NSString*) format;
-(int) year;
-(int) month;
-(int) day;
-(int) minute;
+(NSDate*) endDateOfYear:(int) year;

@end

@interface UIImageView(Utility)

-(CGRect) imageFrameWithContentMode:(UIViewContentMode) mode;
-(CGRect) imageFrame;
-(bool) isImageBigger;
-(bool) isImageSmaller;

@end

@interface UIImage(Utility)

- (UIImage *)resizedImage:(CGSize)newSize
     interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)thumbnailImage:(NSInteger)thumbnailSize
          transparentBorder:(NSUInteger)borderSize
               cornerRadius:(NSUInteger)cornerRadius
       interpolationQuality:(CGInterpolationQuality)quality;
- (UIImage *)resizedImageWithContentMode:(UIViewContentMode)contentMode
                                  bounds:(CGSize)bounds
                    interpolationQuality:(CGInterpolationQuality)quality;

@end

@interface UIButton (Utility)

-(void) sizeToFitTitle;

@end

@interface NSArray(Utility)

-(NSArray*) objectsAtRange:(NSRange) range;
+(NSArray*) makeArray:(id) obj;

@end

@interface NSNumber(Utility)

+(NSNumber*) makeNumber:(id) obj;

@end

@interface NSObject(Utility)

-(bool) hasData;

@end

@interface UIDevice(Utility)

- (NSString *)platformRawString;

@end

@interface UITableView(Utility)

-(UITableViewCell*) emptyCell;


@end

@interface UITableView(ReloadAnimation)

-(void) beginUpdatesAnimationWithDuration:(float) duration;
-(void) performUpdateWithAction:(void(^)()) action completion:(void(^)()) completed;
-(void) endUpdatesAnimation;

@end