//
//  RouseViewController.h
//  Rouse
//
//  Created by Mads Andersen on 27/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@interface RouseFeedController : UIViewController
{
    Feed *feed;
    NSMutableArray *images;
    NSMutableArray *cells;
}
@property (nonatomic, strong) Feed *feed;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *cells;

- (void) setupWith:(Feed*)feedVar;

@end
