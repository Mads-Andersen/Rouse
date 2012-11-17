//
//  RouseConstants.h
//  Rouse
//
//  Created by Mads Andersen on 11/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <Foundation/Foundation.h>

FOUNDATION_EXPORT int const FeedCellClipMargin;
FOUNDATION_EXPORT int const FeedCellImageMargin;
FOUNDATION_EXPORT int const FeedCellWidth;
FOUNDATION_EXPORT int const FeedCellHeight;
FOUNDATION_EXPORT int const FeedCellPictureHolderWidth;
FOUNDATION_EXPORT int const FeedCellPictureHolderHeight;
FOUNDATION_EXPORT int const FeedCellInformationHeight;

FOUNDATION_EXPORT int const ImageCellMargin;
FOUNDATION_EXPORT int const ImageCellWidth;
FOUNDATION_EXPORT int const ImageCellHeight;

FOUNDATION_EXPORT int const MaxFeedsPerPage;

@interface RouseConstants : NSObject
{
    UIImage *BackgroundImage;
    UIImage *BackgroundImage90;
    UIImage *ClipImage;
    UIImage *PlaceHolderImage;
    UIImage *CloseImage;
    UIImage *RefreshImage;
    UIImage *ToolbarImage;
    UIImage *LoadingImage;
    UIFont *FeedCellNameFont;
    UIFont *FeedCellUrlFont;
}

@property (nonatomic, retain) UIImage *BackgroundImage;
@property (nonatomic, retain) UIImage *BackgroundImage90;
@property (nonatomic, retain) UIImage *ClipImage;
@property (nonatomic, retain) UIImage *PlaceHolderImage;
@property (nonatomic, retain) UIImage *CloseImage;
@property (nonatomic, retain) UIImage *RefreshImage;
@property (nonatomic, retain) UIImage *ToolbarImage;
@property (nonatomic, retain) UIImage *LoadingImage;
@property (nonatomic, retain) UIFont *FeedCellNameFont;
@property (nonatomic, retain) UIFont *FeedCellUrlFont;

+ (id)instance;

@end
