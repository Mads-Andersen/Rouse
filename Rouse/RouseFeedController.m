//
//  RouseViewController.m
//  Rouse
//
//  Created by Mads Andersen on 27/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseConstants.h"
#import "RouseFeedController.h"
#import "Image.h"
#import "RouseUtility.h"
#import "RSSParser.h"
#import "RouseImageCellView.h"
#import "RouseImageDetailController.h"

@interface RouseFeedController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic) CGFloat scrollX;
@property (nonatomic) CGFloat scrollY;

@end

@implementation RouseFeedController
@synthesize feed;
@synthesize images;
@synthesize cells;

- (void) setupWith:(Feed*)feedVar;
{
    RSSParser *parser = [[RSSParser alloc] init];
    self.feed = feedVar;
    self.title = [self.feed name];
    self.images = [parser getImages:self.feed.url];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupBackground];
    [self setupNotications];
    [self createCells];
    [self showView];
}

- (void)setupBackground
{
    UIImage *background = [[RouseConstants instance] BackgroundImage];
    UIImage *refreshImage = [[RouseConstants instance] RefreshImage];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:background];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:refreshImage style:UIBarButtonItemStylePlain target:self action:@selector(refresh:)];
}

- (void)setupNotications
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
}

- (void)createCells
{
    self.cells = [[NSMutableArray alloc]init];
    
    int count = [self.images count];
    for (int i = 0; i < count; i++)
    {
        Image *photo = [self.images objectAtIndex:i];
        RouseImageCellView *cell = [[RouseImageCellView alloc]initWith:photo];
        UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageTap:)];
        [cell addGestureRecognizer:tap];
        [self.cells addObject:cell];
        [self.scrollView addSubview:cell];
    }
}

- (void)showView
{  
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[[RouseConstants instance] BackgroundImage90]];
        [self showFeedViewPortrait];
        CGRect frame = self.scrollView.frame;
        frame.origin.y = self.scrollX;
        frame.origin.x = 0;
        [self.scrollView scrollRectToVisible:frame animated:NO];
    }
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[[RouseConstants instance] BackgroundImage]];
        [self showFeedViewLandscape];
        CGRect frame = self.scrollView.frame;
        frame.origin.x = self.scrollY;
        frame.origin.y = 0;
        [self.scrollView scrollRectToVisible:frame animated:NO];
    }
}

- (void)orientationChanged:(id)object
{
    [self showView];
}

-(void)showFeedViewLandscape
{
    CGSize frame = [RouseUtility currentSize];
    int viewHeight = frame.height - self.navigationController.navigationBar.frame.size.height;
    int space = 50;
    int margin = 40;
    
    int count = [self.cells count];
    int cols = ceil(count/3.0);
    int width = margin * 2 + ((cols-1)*space) + cols*ImageCellWidth;
    self.scrollView.contentSize = CGSizeMake(width, viewHeight);
    
    for (int i = 0; i < count; i++)
    {
        int xPos = 0;
        int yPos = 0;
        
        if(i % 3 == 0) yPos += margin;
        if(i % 3 == 1) yPos += viewHeight/2 - ImageCellHeight/2;
        if(i % 3 == 2) yPos += viewHeight - margin - ImageCellHeight;
        
        int col = i / 3;
        xPos = margin + ImageCellWidth*col + space*col;
        
        RouseImageCellView *view = [self.cells objectAtIndex:i];
        [view setPositionX:xPos y:yPos];
    }
}

-(void)showFeedViewPortrait
{
    CGSize frame = [RouseUtility currentSize];
    int viewWidth = frame.width;
    int space = 50;
    int margin = 40;
    
    int count = [self.cells count];
    int rows = ceil(count/3.0);
    int height = margin * 2 + ((rows-1)*space) + rows*ImageCellHeight;
    self.scrollView.contentSize = CGSizeMake(viewWidth, height);
    
    for (int i = 0; i < count; i++)
    {
        int xPos = 0;
        int yPos = 0;
        
        if(i % 3 == 0) xPos += margin;
        if(i % 3 == 1) xPos += viewWidth/2 - ImageCellWidth/2;
        if(i % 3 == 2) xPos += viewWidth - margin - ImageCellWidth;
        
        int row = i / 3;
        yPos = margin + ImageCellHeight*row + space*row;
        
        RouseImageCellView *view = [self.cells objectAtIndex:i];
        [view setPositionX:xPos y:yPos];
    }
}

- (void)imageTap:(UITapGestureRecognizer *)recognizer
{
    RouseImageCellView *cell = (RouseImageCellView*)recognizer.view;
    RouseImageDetailController *viewController = [[RouseImageDetailController alloc]initWith:cell.image];
    viewController.modalPresentationStyle = UIModalPresentationFormSheet;
    viewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:viewController animated:YES completion:nil];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.scrollX = self.scrollView.contentOffset.x;
    self.scrollY = self.scrollView.contentOffset.y;
}

- (void)refresh:(id)sender
{
    for (int i = 0; i < [self.cells count]; i++)
    {
        RouseImageCellView *view = [self.cells objectAtIndex:i];
        [view removeFromSuperview];
    }
    
    RSSParser *parser = [[RSSParser alloc] init];
    self.images = [parser getImages:self.feed.url];
    [self createCells];
    [self showView];
}


@end
