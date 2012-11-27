#import <Foundation/Foundation.h>

@interface Feed : NSObject
{
    NSString* name;
    NSString* url;
}

@property (retain) NSString* name;
@property (retain) NSString* url;

- (id) initWithName:(NSString*)Name Url:(NSString*)Url;
- (id) initWithUrl:(NSString*)Url;

@end
