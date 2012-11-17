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
@end

@implementation RouseFeedCellView
@synthesize feed;
@synthesize xPosition;
@synthesize yPosition;
@synthesize deleteImageView;
@synthesize imageView;

- (id)initWithFeed:(Feed *)feedVar
{
    self.xPosition = 0;
    self.yPosition = 0;
    self.feed = feedVar;
    
    self = [super initWithFrame:CGRectMake(0, 0, FeedCellWidth, FeedCellHeight)];
    if(self == [super init])
    {
        [self createView];
    }
    
    return self;
}

- (id)initWithFeed:(Feed*)feedVar xPos:(CGFloat)x yPos:(CGFloat)y animation:(BOOL)animation
{
    self.xPosition = x;
    self.yPosition = y;
    self.feed = feedVar;
    
    self = [super initWithFrame:CGRectMake(x, y, FeedCellWidth, FeedCellHeight)];
    if(self)
    {
        [self createView];
        if(animation) [self animate];
    }
    
    return self;
}

- (void)createView
{
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
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, infoY, FeedCellWidth, FeedCellInformationHeight/2)];
    UILabel *urlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, infoY+FeedCellInformationHeight/2, FeedCellWidth, FeedCellInformationHeight/2)];
    [nameLabel setBackgroundColor:[UIColor clearColor]];
    [nameLabel setText:self.feed.name];
    [nameLabel setFont:[[RouseConstants instance] FeedCellNameFont]];
    [nameLabel setTextColor:[UIColor whiteColor]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
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
    [self addSubview:nameLabel];
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
        RSSParser *parser = [[RSSParser alloc]init];
        NSMutableArray *photos = [parser getImages:self.feed.url];
        if(photos.count > 0)
        {
            Photo *photo = [photos objectAtIndex:0];
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

- (void)deleteTap:(UITapGestureRecognizer *)recognizer
{
    [UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^
     {
         self.transform = CGAffineTransformMakeScale(0, 0);
     }
     completion:^(BOOL finished)
     {
         [[NSNotificationCenter defaultCenter] postNotificationName:@"FeedCellDeleted" object:self];
         [self removeFromSuperview];
     }];
}

- (void) beginWobble
{
    float delay = [RouseUtility randFloatBetween:0.0 and:0.15];
    [self performSelector:@selector(beginWobbleImpl) withObject:self afterDelay:delay];
    
}

- (void) beginWobbleImpl
{
    self.deleteImageView.hidden = NO;
    
    #define RADIANS(degrees) ((degrees * M_PI) / 180.0)
    CGAffineTransform leftWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(-2.0));
    CGAffineTransform rightWobble = CGAffineTransformRotate(CGAffineTransformIdentity, RADIANS(2.0));
    
    self.transform = leftWobble;
    [UIView beginAnimations:@"wobble" context:(__bridge void *)(self)];
    [UIView setAnimationRepeatAutoreverses:YES];
    [UIView setAnimationRepeatCount:INFINITY];
    [UIView setAnimationDuration:0.15];
    [UIView setAnimationDelegate:self];
    self.transform = rightWobble;
    
    [UIView commitAnimations];
}

- (void) endWobble
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
    self.xPosition = x;
    self.yPosition = y;
    
    [UIView beginAnimations:nil context:NULL];
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);
    [UIView setAnimationDuration:0.3];
    [UIView commitAnimations];
}

@end
