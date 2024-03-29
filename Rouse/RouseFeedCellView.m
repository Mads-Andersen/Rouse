//
//  RouseFeedCellView.m
//  Rouse
//
//  Created by Mads Andersen on 11/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RouseConstants.h"
#import "RouseFeedsController.h"
#import "RouseFeedCellView.h"
#import "RouseUtility.h"
#import "Feed.h"
#import "RSSParser.h"

@interface RouseFeedCellView()
@property (nonatomic, retain) UIImageView *deleteImageView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UILabel *nameLabel;
@end

@implementation RouseFeedCellView
@synthesize feed;
@synthesize xPosition;
@synthesize yPosition;
@synthesize deleteImageView;
@synthesize imageView;

- (id)initWithFeed:(Feed *)feedVar animation:(BOOL)animation
{
    self.xPosition = 0;
    self.yPosition = 0;
    self.feed = feedVar;
    
    self = [super initWithFrame:CGRectMake(0, 0, FeedCellWidth, FeedCellHeight)];
    if(self == [super init])
    {
        [self createView];
        if(animation) [self animate];
    }
    
    return self;
}

- (void)createView
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedNameDownloaded:) name:@"FeedNameDownloaded" object:nil];
    
    int topMargin = FeedCellClipMargin;
    int margin = FeedCellImageMargin;
    int infoY = FeedCellPictureHolderHeight + topMargin;
    UIImage *clip = [[RouseConstants instance] ClipImage];
    UIImage *delete = [[RouseConstants instance] CloseImage];
    
    
    UIImageView *holderImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, topMargin, FeedCellPictureHolderWidth, FeedCellPictureHolderHeight)];
    UIImageView *clipView = [[UIImageView alloc] initWithFrame:CGRectMake(FeedCellWidth/2-clip.size.width/2, 0, clip.size.width, clip.size.height)];
    [holderImageView setImage:[[RouseConstants instance] PlaceHolderImage]];
    [clipView setImage:clip];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(margin, margin+topMargin, FeedCellPictureHolderWidth-2*margin, FeedCellPictureHolderHeight-2*margin)];
    self.deleteImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-25, -10, delete.size.width*1.3, delete.size.height*1.3)];
    self.deleteImageView.hidden = YES;
    
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, infoY, FeedCellWidth, FeedCellInformationHeight/2)];
    UILabel *urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, infoY+FeedCellInformationHeight/2, FeedCellWidth, FeedCellInformationHeight/2)];
    [self.nameLabel setBackgroundColor:[UIColor clearColor]];
    [self.nameLabel setText:self.feed.name];
    [self.nameLabel setFont:[[RouseConstants instance] FeedCellNameFont]];
    [self.nameLabel setTextColor:[UIColor whiteColor]];
    [self.nameLabel setTextAlignment:NSTextAlignmentCenter];
    [urlLabel setBackgroundColor:[UIColor clearColor]];
    [urlLabel setText:self.feed.url];
    [urlLabel setFont:[[RouseConstants instance] FeedCellUrlFont]];
    [urlLabel setTextColor:[UIColor whiteColor]];
    [urlLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(deleteTap:)];
    [self addSubview:holderImageView];
    [self addSubview:self.imageView];
    [self addSubview:clipView];
    [self addSubview:self.deleteImageView];
    [self addSubview:self.nameLabel];
    [self addSubview:urlLabel];
    [self.deleteImageView setImage:delete];
    [self.deleteImageView setUserInteractionEnabled:YES];
    [self.deleteImageView addGestureRecognizer:tap];
    
    [self setImage];
}

- (void)setImage
{
    dispatch_async(dispatch_get_global_queue(0,0), ^
    {
        NSMutableArray *photos = [RSSParser getImages:self.feed.url];
        if(photos.count > 0)
        {
            Image *photo = [photos objectAtIndex:0];
            UIImage *image = [RSSParser getThumbnailImage:photo];
            dispatch_async(dispatch_get_main_queue(), ^
            {
                [self.imageView setImage:image];
            });
        }
    });
}

- (void)animate
{
    self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.transform = CGAffineTransformIdentity;
     }
     completion:^(BOOL finished)
     {
     }];
}

- (void)feedNameDownloaded:(NSNotification*)notification
{
    if(self.feed == notification.object)
    {
        [self.nameLabel setText:self.feed.name];
    }

}

- (void)deleteTap:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.transform = CGAffineTransformMakeScale(0, 0);
     }
     completion:^(BOOL finished)
     {
         [self removeFromSuperview];
         [[NSNotificationCenter defaultCenter] postNotificationName:@"FeedCellDeleted" object:self];
     }];
}

- (void) beginWiggle
{
    float delay = [RouseUtility randFloatBetween:0.0 and:0.15];
    [self performSelector:@selector(beginWiggleImpl) withObject:self afterDelay:delay];
    
}

- (void) beginWiggleImpl
{
    self.deleteImageView.hidden = NO;
    
    #define RADIANS(degrees) ((degrees * M_PI) / 180.0)
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-2.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(2.0));
    
    self.transform = leftWobble;
    [UIView beginAnimations:@"wiggle" context:(__bridge void *)(self)];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:INFINITY];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    self.transform = rightWobble;
    
    [UIView commitAnimations];
}

- (void) endWiggle
{
    [self.layer removeAllAnimations];
    self.deleteImageView.hidden = YES;
    self.transform = CGAffineTransformIdentity;
}

- (void)setPosition:(CGFloat)x y:(CGFloat)y
{
    self.xPosition = x;
    self.yPosition = y;
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
}

- (void) move:(CGFloat)x y:(CGFloat)y
{
    self.transform = CGAffineTransformIdentity;
    self.xPosition = x;
    self.yPosition = y;
    
    [UIView beginAnimations:nil context:NULL];
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
    
    [self beginWiggle];
    
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
