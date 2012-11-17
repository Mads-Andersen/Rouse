//
//  FeedManager.h
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RouseUtility.h"

@interface FeedManager : NSObject
{
    NSMutableArray* feeds;
}

@property (retain) NSMutableArray* feeds;

-(id)init;
-(void)load;
-(void)save;

@end
