//
//  RouseImageDetailController.h
//  Rouse
//
//  Created by Mads Andersen on 13/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Image.h"

@interface RouseImageDetailController : UIViewController
{
    Image *image;
}
@property (nonatomic, retain) Image *image;

- (id)initWith:(Image*)imageVar;

@end
