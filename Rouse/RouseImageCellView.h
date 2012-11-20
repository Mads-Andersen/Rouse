//
//  RouseImageCellView.h
//  Rouse
//
//  Created by Mads Andersen on 12/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"

@interface RouseImageCellView : UIView
{
    Image *image;
}
@property (nonatomic, retain) Image *image;

- (id)initWith:(Image*)imageVar;
- (id)initWith:(Image*)imageVar x:(CGFloat)x y:(CGFloat)y animation:(BOOL)animation;
- (void)setPositionX:(CGFloat)x y:(CGFloat)y;

@end
