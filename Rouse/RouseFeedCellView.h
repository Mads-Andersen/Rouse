//
//  RouseFeedCellView.h
//  Rouse
//
//  Created by Mads Andersen on 11/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@interface RouseFeedCellView : UIView
{
    Feed *feed;
    CGFloat xPosition;
    CGFloat yPosition;
}
@property (nonatomic, retain) Feed *feed;
@property (nonatomic) CGFloat xPosition;
@property (nonatomic) CGFloat yPosition;

- (id)initWithFeed:(Feed*)feedVar animation:(BOOL)animation;
- (void)beginWiggle;
- (void)endWiggle;
- (void)setPosition:(CGFloat)x y:(CGFloat)y;
- (void)move:(CGFloat)x y:(CGFloat)y;

@end
