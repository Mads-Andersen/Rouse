//
//  FeedManager.m
//  Rouse
//
//  Created by Mads Andersen on 19/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "FeedManager.h"
#import "Feed.h"
#import "Photo.h"
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
    
    Feed *feed1 = [[Feed alloc]initWithName:@"Flickr.com" Url:@"http://api.flickr.com/services/feeds/photos_public.gne"];
    Feed *feed2 = [[Feed alloc]initWithName:@"9gag.com" Url:@"feeds.feedburner.com/9gag?format=xml"];
    Feed *feed3 = [[Feed alloc]initWithName:@"FFFFOUND" Url:@"http://feeds.feedburner.com/ffffound/everyone"];
    Feed *feed4 = [[Feed alloc]initWithName:@"daily" Url:@"http://www.nydailynews.com/cmlink/NYDN.Article.rss"];
    Feed *feed5 = [[Feed alloc]initWithName:@"Imgur" Url:@"http://feeds.feedburner.com/ImgurGallery?format=xml"];
    Feed *feed6 = [[Feed alloc]initWithName:@"FIFA" Url:@"http://livelaughnom.com/feed/"];
    Feed *feed7 = [[Feed alloc]initWithName:@"nasa" Url:@"http://www.nasa.gov/rss/lg_image_of_the_day.rss"];
    Feed *feed8 = [[Feed alloc]initWithName:@"Rihanna" Url:@"http://feeds.gettyimages.com/channels/RecentPhotos.rss?searchPhrase=rihanna"];

    
    
    
    
    
    [feeds addObject:[[Feed alloc]initWithName:@"FIFA" Url:@"http://feeds.feedburner.com/DigitalPhotographySchool"]];
    [feeds addObject:[[Feed alloc]initWithName:@"FIFA" Url:@"http://feeds.feedburner.com/jmg-galleries"]];
    [feeds addObject:[[Feed alloc]initWithName:@"FIFA" Url:@"http://feeds.feedburner.com/alphatracks/mxdo"]];
    [feeds addObject:[[Feed alloc]initWithName:@"FIFA" Url:@"http://feeds.feedburner.com/EarthShots"]];
    [feeds addObject:[[Feed alloc]initWithName:@"FIFA" Url:@"http://feeds.feedburner.com/MotsEnImages"]];
    
    [feeds addObject:feed1];
    [feeds addObject:feed2];
    [feeds addObject:feed3];
    [feeds addObject:feed4];
    [feeds addObject:feed5];
    [feeds addObject:feed6];
    [feeds addObject:feed7];
    [feeds addObject:feed8];
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
