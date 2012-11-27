//
//  Feed.m
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "Feed.h"
#import "RSSParser.h"

@interface Feed() <NSCoding>

@end

@implementation Feed

@synthesize name;
@synthesize url;

- (id) initWithName:(NSString*)Name Url:(NSString*)Url
{
    if(self = [super init])
    {
        self.name = Name;
        self.url = Url;
    }
    return self;
}

- (id) initWithUrl:(NSString*)Url
{
    if(self = [super init])
    {
        self.url = Url;
        dispatch_async(dispatch_get_global_queue(0,0), ^
        {
            self.name = [RSSParser getName:Url];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [[NSNotificationCenter defaultCenter] postNotificationName:@"FeedNameDownloaded" object:self];
            });
        });
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"Name"];
    [coder encodeObject:self.url forKey:@"Url"];
}

- (id)initWithCoder:(NSCoder *)coder
{
    NSString *nameVar = [coder decodeObjectForKey:@"Name"];
    NSString *urlVar = [coder decodeObjectForKey:@"Url"];
    
    return [[Feed alloc]initWithName:nameVar Url:urlVar];
}

@end
