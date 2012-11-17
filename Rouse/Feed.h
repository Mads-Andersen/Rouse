#import <Foundation/Foundation.h>

@interface Feed : NSObject
{
    NSString* name;
    NSMutableArray* images;
    NSURL* url;
}

@property (retain) NSString* name;
@property (retain) NSMutableArray* images;
@property (retain) NSURL* url;

- (id) init;
- (void) update;

@end
