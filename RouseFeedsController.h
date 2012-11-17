//
//  RouseFeedsController.h
//  Rouse
//
//  Created by Mads Andersen on 28/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "FeedManager.h"
#import <UIKit/UIKit.h>

@interface RouseFeedsController : UIViewController
{
    FeedManager *feedManager;
    NSMutableArray *cells;
}
@property (nonatomic, retain) FeedManager *feedManager;
@property (nonatomic, retain) NSMutableArray *cells;

@end
