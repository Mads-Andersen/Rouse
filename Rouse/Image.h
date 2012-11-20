//
//  Photo.h
//  Rouse
//
//  Created by Mads Andersen on 27/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Image : NSObject
{
    NSString *thumbnailURL;
    NSString *fullContentURL;
    UIImage *thumbnailImage;
    UIImage *fullContentImage;
}

@property (retain) NSString *fullContentURL;
@property (retain) NSString *thumbnailURL;
@property (retain) UIImage *thumbnailImage;
@property (retain) UIImage *fullContentImage;

-(id)initWithContent:(NSString*)contentUrl: (NSString*)thumbnailUrl;
-(id)initWithUrl:(NSString*)contentUrl;

@end
