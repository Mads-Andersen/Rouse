//
//  RouseImageCellView.h
//  Rouse
//
//  Created by Mads Andersen on 12/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface RouseImageCellView : UIView
{
    Photo *photo;
}
@property (nonatomic, retain) Photo *photo;

- (id)initWith:(Photo*)photoVar;
- (id)initWith:(Photo*)photoVar x:(CGFloat)x y:(CGFloat)y animation:(BOOL)animation;
- (void)setPositionX:(CGFloat)x y:(CGFloat)y;

@end
