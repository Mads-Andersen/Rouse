//
//  RSSParser.h
//  Rouse
//
//  Created by Mads Andersen on 01/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
#import "Photo.h"

@interface RSSParser : NSObject
{
    NSMutableArray *photos;
}

-(id)init;
-(NSMutableArray*)getImages:(NSString*)rssURLString;
+(UIImage*)getThumbnailImage:(Photo*)photo;
+(UIImage*)getFullImage:(Photo*)photo;

@end
