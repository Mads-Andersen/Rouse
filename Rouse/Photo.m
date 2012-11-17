//
//  Photo.m
//  Rouse
//
//  Created by Mads Andersen on 27/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "Photo.h"
#import "RSSParser.h"

@implementation Photo
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
        
        /*
        dispatch_async(dispatch_get_global_queue(0,0), ^
        {
            UIImage *image = [RSSParser getFullImage:self];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                self.fullContentImage = image;
            });
        });
        
        dispatch_async(dispatch_get_global_queue(0,0), ^
        {
            UIImage *image = [RSSParser getThumbnailImage:self];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                NSLog(@"NEJ");
                self.thumbnailImage = image;
            });
       });
         */
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

        /*
        dispatch_async(dispatch_get_global_queue(0,0), ^
        {
            UIImage *image = [RSSParser getFullImage:self];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                NSLog(@"JA");
                self.thumbnailImage = image;
                self.fullContentImage = image;
            });
        });
         */
    }
    return self;
}

@end
