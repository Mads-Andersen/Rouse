//
//  RSSParser.m
//  Rouse
//
//  Created by Mads Andersen on 01/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RSSParser.h"
#import "ParserImagesDelegate.h"
#import "ParserNameDelegate.h"

@interface RSSParser() <NSXMLParserDelegate>
@end

@implementation RSSParser

-(id)init
{
    self = [super init];
    return self;
}

+(NSString*)getName:(NSString*)rssURLString
{
    NSString *escapedURL = [rssURLString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSURL *rssURL = [NSURL URLWithString:escapedURL];
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    ParserNameDelegate *delegate = [[ParserNameDelegate alloc]init];
    [rssParser setDelegate:delegate];
	[rssParser parse];
    return delegate.name;
}

+(NSMutableArray*)getImages:(NSString*)rssURLString
{
	NSString *escapedURL = [rssURLString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSURL *rssURL = [NSURL URLWithString:escapedURL];
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    ParserImagesDelegate *delegate = [[ParserImagesDelegate alloc]init];
    [rssParser setDelegate:delegate];
	[rssParser parse];
    return delegate.images;
}

+(UIImage*)getThumbnailImage:(Image*)photo
{
    NSString *url = photo.thumbnailURL;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: url]];
    return [UIImage imageWithData: imageData];
}


+(UIImage*)getFullImage:(Image*)photo
{
    NSString *url = photo.fullContentURL;
    UIImage *image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:url]]];
    return image;
}

@end
