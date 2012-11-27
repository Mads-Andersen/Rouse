//
//  RSSParser.h
//  Rouse
//
//  Created by Mads Andersen on 01/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"
#import "Image.h"

@interface RSSParser : NSObject

+(NSString*)getName:(NSString*)rssURLString;
+(NSMutableArray*)getImages:(NSString*)rssURLString;
+(UIImage*)getThumbnailImage:(Image*)photo;
+(UIImage*)getFullImage:(Image*)photo;

@end
