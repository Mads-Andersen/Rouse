//
//  ParserNameDelegate.h
//  Rouse
//
//  Created by Mads Andersen on 26/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ParserNameDelegate : NSObject <NSXMLParserDelegate>
{
    NSString *name;
}

@property (retain) NSString *name;

@end
