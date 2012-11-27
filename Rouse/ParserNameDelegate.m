//
//  ParserNameDelegate.m
//  Rouse
//
//  Created by Mads Andersen on 26/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "ParserNameDelegate.h"

@interface ParserNameDelegate()
@property (nonatomic) BOOL isTitleTag;
@property (nonatomic) BOOL nameIsFound;
@end

@implementation ParserNameDelegate
@synthesize name;

-(id)init
{
    if(self == [super init])
    {
        self.name = @"";
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict
{
    if([elementName isEqualToString:@"title"])
    {
        self.isTitleTag = YES;
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if(self.isTitleTag && !self.nameIsFound)
    {
        self.name = string;
        self.nameIsFound = YES;
    }
}


@end
