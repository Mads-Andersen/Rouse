//
//  FeedManager.m
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "FeedManager.h"
#import "Feed.h"
#import "Image.h"
#import "RouseUtility.h"

@interface FeedManager () <NSCoding, NSXMLParserDelegate>

@end

@implementation FeedManager

@synthesize feeds;

-(id)init
{
    if (self = [super init])
    {
    }
    return self;
}

-(void)load
{
    feeds = [[NSMutableArray alloc] init];
    
    
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://api.flickr.com/services/feeds/photos_public.gne"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/ffffound/everyone"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://www.nasa.gov/rss/lg_image_of_the_day.rss"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/ImgurGallery?format=xml"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/EarthShots"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/MotsEnImages"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/DigitalPhotographySchool"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/jmg-galleries"]];
    [feeds addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/alphatracks/mxdo"]];
    
    /*
    [feeds addObject:[[Feed alloc]initWithName:@"Uploads from everyone" Url:@"http://api.flickr.com/services/feeds/photos_public.gne"]];
    [feeds addObject:[[Feed alloc]initWithName:@"FFFFOUND! / EVERYONE" Url:@"http://feeds.feedburner.com/ffffound/everyone"]];
    [feeds addObject:[[Feed alloc]initWithName:@"NASA Image of the Day (Large)" Url:@"http://www.nasa.gov/rss/lg_image_of_the_day.rss"]];
    [feeds addObject:[[Feed alloc]initWithName:@"imgur: the simple image sharer" Url:@"http://feeds.feedburner.com/ImgurGallery?format=xml"]];
    [feeds addObject:[[Feed alloc]initWithName:@"Earth Shots - Photo of the Day Contest" Url:@"http://feeds.feedburner.com/EarthShots"]];
    [feeds addObject:[[Feed alloc]initWithName:@"Gino Caron Photographe" Url:@"http://feeds.feedburner.com/MotsEnImages"]];
    [feeds addObject:[[Feed alloc]initWithName:@"DigitalPhotographySchool" Url:@"http://feeds.feedburner.com/DigitalPhotographySchool"]];
    [feeds addObject:[[Feed alloc]initWithName:@"JMG-Galleries - Jim M. Goldstein Photography" Url:@"http://feeds.feedburner.com/jmg-galleries"]];
    [feeds addObject:[[Feed alloc]initWithName:@"Alphatracks" Url:@"http://feeds.feedburner.com/alphatracks/mxdo"]];
     */
}

+(FeedManager*)loadFromDevice
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"RouseData"];
    
    FeedManager *test = [[FeedManager alloc]init];
    [test load];
    return test;
    
    if ([fileManager fileExistsAtPath:filename])
    {
        FeedManager *feedManager = [NSKeyedUnarchiver unarchiveObjectWithFile:filename];
        return feedManager;
    }
    
    return [[FeedManager alloc]init];
}

-(BOOL)saveToDevice
{
    NSString *docsPath = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *filename = [docsPath stringByAppendingPathComponent:@"RouseData"];
    return [NSKeyedArchiver archiveRootObject:self toFile:filename];
}

-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.feeds forKey:@"Feeds"];
}

-(id)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    if (self)
    {
        self.feeds = [coder decodeObjectForKey:@"Feeds"];
    }
    return self;
}

@end
