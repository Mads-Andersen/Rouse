//
//  FeedManager.m
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "FeedManager.h"

@implementation FeedManager

@synthesize feeds;

-(id)init
{
    if (self = [super init])
    {
        
    }
    [self load];
    return self;
}

-(void)load
{
    feeds = [[NSMutableArray alloc] initWithObjects:@"mads", @"lol", @"test2", @"test3", nil];
}

-(void)save
{
    
}

@end
