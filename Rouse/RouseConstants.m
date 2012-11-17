//
//  RouseConstants.m
//  Rouse
//
//  Created by Mads Andersen on 11/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseConstants.h"

UIImage *const BackgroundImage;
UIImage *const ClipImage;
UIImage *const PlaceHolderImage;
UIImage *const CloseImage;
UIImage *const RefreshImage;
UIImage *const ToolbarImage;

int const FeedCellClipMargin = 20;
int const FeedCellImageMargin = 20;
int const FeedCellPictureHolderWidth = 260;
int const FeedCellPictureHolderHeight = 200;
int const FeedCellInformationHeight = 45;
int const FeedCellWidth = FeedCellPictureHolderWidth;
int const FeedCellHeight = FeedCellPictureHolderHeight + FeedCellInformationHeight + FeedCellClipMargin;

int const ImageCellMargin = 5;
int const ImageCellWidth = 175;
int const ImageCellHeight = 175;

int const MaxFeedsPerPage = 6;

@implementation RouseConstants

@synthesize BackgroundImage;
@synthesize BackgroundImage90;
@synthesize ClipImage;
@synthesize PlaceHolderImage;
@synthesize CloseImage;
@synthesize RefreshImage;
@synthesize ToolbarImage;
@synthesize LoadingImage;
@synthesize FeedCellNameFont;
@synthesize FeedCellUrlFont;

+ (id)instance
{
    static RouseConstants *rouseConstants = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
    {
        rouseConstants = [[self alloc] init];
    });
    return rouseConstants;
}

- (id)init
{
    if (self = [super init])
    {
        BackgroundImage = [UIImage imageNamed:@"bg"];
        BackgroundImage90 = [UIImage imageNamed:@"bg-90"];
        ClipImage = [UIImage imageNamed:@"clip"];
        PlaceHolderImage = [UIImage imageNamed:@"pictureholder"];
        CloseImage = [UIImage imageNamed:@"close-button"];
        RefreshImage = [UIImage imageNamed:@"refresh-icon"];
        ToolbarImage = [UIImage imageNamed:@"toolbar"];
        LoadingImage = [UIImage imageNamed:@"bg"];
        FeedCellNameFont = [UIFont fontWithName:@"Arial-BoldMT" size:20];
        FeedCellUrlFont = [UIFont fontWithName:@"Arial" size:16];
    }
    return self;
}

@end
