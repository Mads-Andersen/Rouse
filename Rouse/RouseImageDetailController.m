//
//  RouseImageDetailController.m
//  Rouse
//
//  Created by Mads Andersen on 13/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseImageDetailController.h"
#import "RSSParser.h"

@interface RouseImageDetailController ()
@property (nonatomic, retain) UIImageView *imageView;
@end

@implementation RouseImageDetailController
@synthesize photo;

- (id)initWith:(Photo*)photoVar
{
    if(self == [super init])
    {
        self.photo = photoVar;
        self.imageView = [[UIImageView alloc]init];
        self.imageView.userInteractionEnabled = YES;
        self.imageView.image = photoVar.thumbnailImage;
        self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    
    dispatch_async(dispatch_get_global_queue(0,0), ^
    {
        UIImage *image = [RSSParser getFullImage:self.photo];
        dispatch_async(dispatch_get_main_queue(), ^
        {
            self.imageView.image = image;
            //self.view.superview.bounds = CGRectMake(100, 100, image.size.width, image.size.height);
            CGSize bounds = self.view.superview.bounds.size;
            [self.imageView setFrame:CGRectMake(5, 5, bounds.width-2*5, bounds.height-2*5)];
            [self.view addSubview:self.imageView];
        });
    });
    
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
    [self.imageView addGestureRecognizer:tap];
    
    
    
}

- (void)setImage
{
    if(self.photo.thumbnailImage)
    {
        self.imageView.image = self.photo.thumbnailImage;
        return;
    }
    else
    {
        //UIImage *image = [[RouseConstants instance]LoadingImage];
        //[self.imageView setImage:image];
    }
    
    dispatch_async(dispatch_get_global_queue(0,0), ^
    {
        // UIImage *image = [RSSParser getThumbnailImage:self.photo];
         dispatch_async(dispatch_get_main_queue(), ^
         {
                //self.imageView.image = image;
         });
    });
}

- (UIView*)createImageViewPortrait
{
    return self.view;
}

- (UIView*)createImageViewLandscape
{
    return self.view;
}

- (void)imageTap:(UITapGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
