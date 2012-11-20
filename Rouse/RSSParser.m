//
//  RSSParser.m
//  Rouse
//
//  Created by Mads Andersen on 01/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RSSParser.h"

@interface RSSParser() <NSXMLParserDelegate>
@property (nonatomic, retain) NSMutableArray *photos;
@property (nonatomic, retain) Image *currentPhoto;
@property (nonatomic) BOOL saveTitle;
@end

@implementation RSSParser
@synthesize photos;

-(id)init
{
    self = [super init];
    return self;
}

-(NSMutableArray*)getImages:(NSString*)rssURLString
{
    self.photos = [[NSMutableArray alloc] init];
	NSString *escapedURL = [rssURLString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
	NSURL *rssURL = [NSURL URLWithString:escapedURL];
    NSXMLParser *rssParser = [[NSXMLParser alloc] initWithContentsOfURL:rssURL];
    [rssParser setDelegate:self];
	[rssParser parse];
    return self.photos;
}

- (void)parser:(NSXMLParser *)parser
    didStartElement:(NSString *)elementName
    namespaceURI:(NSString *)namespaceURI
    qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"])
    {
        self.currentPhoto = [[Image alloc]init];
    }
    
    
    if([elementName isEqualToString:@"enclosure"])
    {
        NSString *currentString = [attributeDict objectForKey:@"url"];
        if([currentString length] > 0)
        {
            NSString* escapedURL = [currentString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            self.currentPhoto.fullContentURL = escapedURL;
            self.currentPhoto.thumbnailURL = escapedURL;
        }
    }
    
    if([elementName isEqualToString:@"link"])
    {
        NSString *currentString = [attributeDict objectForKey:@"href"];
		if([currentString length] > 0)
        {
            NSString* escapedURL = [currentString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            self.currentPhoto.fullContentURL = escapedURL;
            self.currentPhoto.thumbnailURL = escapedURL;
        }
    }
    
    if([elementName isEqualToString:@"media:content"])
    {
        NSString *currentString = [attributeDict objectForKey:@"url"];
		if([currentString length] > 0)
        {
            NSString* escapedURL = [currentString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            self.currentPhoto.fullContentURL = escapedURL;
            self.currentPhoto.thumbnailURL = escapedURL;
        }
    }
    
    if([elementName isEqualToString:@"media:thumbnail"])
    {
        NSString *currentString = [attributeDict objectForKey:@"url"];
		if([currentString length] > 0)
        {
            NSString* escapedURL = [currentString stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
            self.currentPhoto.fullContentURL = escapedURL;
            self.currentPhoto.thumbnailURL = escapedURL;
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    BOOL item = [elementName isEqualToString:@"item"];
    BOOL entry = [elementName isEqualToString:@"entry"];
    if(item || entry)
    {
        [self.photos addObject:self.currentPhoto];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if([self string:string contains:@"src"])
    {
        NSError* error = nil;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"src=[\"'](.+?)[\"'].+?" options:0 error:&error];
        NSArray* matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        for ( NSTextCheckingResult* match in matches )
        {
            NSString* matchText = [string substringWithRange:[match range]];
            if ([[matchText pathExtension] isEqualToString:@"jpg\" "])
            {
                NSString *ss = [matchText substringWithRange:NSMakeRange(5, matchText.length-7)];
                self.currentPhoto.fullContentURL = ss;
                self.currentPhoto.thumbnailURL = ss;
            }
        }
    }
    
    if([self string:string contains:@"url"])
    {
        NSError* error = nil;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"url=[\"'](.+?)[\"'].+?" options:0 error:&error];
        NSArray* matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        for ( NSTextCheckingResult* match in matches )
        {
            NSString* matchText = [string substringWithRange:[match range]];
            if ([[matchText pathExtension] isEqualToString:@"jpg\" "])
            {
                NSString *ss = [matchText substringWithRange:NSMakeRange(5, matchText.length-7)];
                self.currentPhoto.fullContentURL = ss;
                self.currentPhoto.thumbnailURL = ss;
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock
{
    
    NSString *string = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    if([self string:string contains:@"src"])
    {
        NSError* error = nil;
        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:@"src=[\"'](.+?)[\"'].+?" options:0 error:&error];
        NSArray* matches = [regex matchesInString:string options:0 range:NSMakeRange(0, [string length])];
        for ( NSTextCheckingResult* match in matches )
        {
            NSString* matchText = [string substringWithRange:[match range]];
            if ([[matchText pathExtension] isEqualToString:@"jpg\" "])
            {
                NSString *ss = [matchText substringWithRange:NSMakeRange(5, matchText.length-7)];
                self.currentPhoto.fullContentURL = ss;
                self.currentPhoto.thumbnailURL = ss;
            }
        }
    }
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

- (BOOL)string:(NSString*)input contains:(NSString*)search
{
    NSRange range = [input rangeOfString:search];
    
    if (range.length > 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

@end
