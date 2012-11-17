//
//  Feed.m
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "Feed.h"

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
