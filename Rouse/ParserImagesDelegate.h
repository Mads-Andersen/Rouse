//
//  ParserImagesDelegate.h
//  Rouse
//
//  Created by Mads Andersen on 26/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserImagesDelegate : NSObject <NSXMLParserDelegate>
{
    NSMutableArray *images;
}

@property (retain) NSMutableArray *images;

@end
