//
//  RouseImageCellView.m
//  Rouse
//
//  Created by Mads Andersen on 12/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseConstants.h"
#import "RouseUtility.h"
#import "RouseImageCellView.h"
#import "RSSParser.h"
#import "Image.h"

@interface RouseImageCellView()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation RouseImageCellView
@synthesize image;

- (id)initWith:(Image*)imageVar
{
    self.image = imageVar;
    int margin = ImageCellMargin;
    int width = ImageCellWidth-2*margin;
    int height = ImageCellHeight-2*margin;
    
    self = [super initWithFrame:CGRectMake(0, 0, ImageCellWidth, ImageCellHeight)];
    if(self)
    {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, width, height)]; 
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage];
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (id)initWith:(Image*)imageVar x:(CGFloat)x y:(CGFloat)y animation:(BOOL)animation
{
    self.image = imageVar;
    int margin = ImageCellMargin;
    int width = ImageCellWidth-2*margin;
    int height = ImageCellHeight-2*margin;
    float rotation = [RouseUtility randFloatBetween:-0.05 and:0.05];
    
    self = [super initWithFrame:CGRectMake(x, y, ImageCellWidth, ImageCellHeight)];
    if(self)
    {
        CGAffineTransform transform = CGAffineTransformRotate(self.transform, rotation);
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(margin, margin, width, height)];
        self.transform = transform;
        
        [self setBackgroundColor:[UIColor whiteColor]];
        [self setImage];
        [self addSubview:self.imageView];
    }
    
    return self;
}

- (void)setImage
{
    if(self.image.thumbnailImage)
    {
        self.imageView.image = self.image.thumbnailImage;
        return;
    }
    else
    {
        UIImage *img = [[RouseConstants instance]LoadingImage];
        [self.imageView setImage:img];
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^
    {
        UIImage *img = [RSSParser getThumbnailImage:self.image];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.imageView.image = img;
        });
    });
}

- (void)setPositionX:(CGFloat)x y:(CGFloat)y
{
    self.transform = CGAffineTransformIdentity;
    self.frame = CGRectMake(x, y, self.frame.size.width, self.frame.size.height);

    float rotation = [RouseUtility randFloatBetween:-0.05 and:0.05];
    CGAffineTransform transform = CGAffineTransformRotate(self.transform, rotation);
    self.transform = transform;
}

@end
