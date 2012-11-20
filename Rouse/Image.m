//
//  Photo.m
//  Rouse
//
//  Created by Mads Andersen on 27/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "Image.h"
#import "RSSParser.h"

@implementation Image
@synthesize thumbnailURL;
@synthesize thumbnailImage;
@synthesize fullContentURL;
@synthesize fullContentImage;


-(id)initWithContent:(NSString*)contentUrl: (NSString*)thumbnailUrl
{
    self = [super init];
    if (self)
    {
        [self setFullContentURL:contentUrl];
        [self setThumbnailURL:thumbnailUrl];
    }
    return self;
}

-(id)initWithUrl:(NSString*)contentUrl
{
    self = [super init];
    if (self)
    {
        [self setFullContentURL:contentUrl];
        [self setThumbnailURL:contentUrl];
    }
    return self;
}

@end
