//
//  RouseFeedsController.m
//  Rouse
//
//  Created by Mads Andersen on 28/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseConstants.h"
#import "RouseFeedsController.h"
#import "RouseFeedController.h"
#import "RouseUtility.h"
#import "Image.h"
#import "Feed.h"
#import "RouseFeedsManagerViewController.h"
#import "FeedManager.h"
#import "RSSParser.h"
#import "RouseFeedCellView.h"

@interface RouseFeedsController () <UIScrollViewDelegate>

@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic) BOOL deletionState;

-(IBAction)pageControlValueChanged:(id)sender;

@end

@implementation RouseFeedsController
@synthesize feedManager;
@synthesize cells;

- (void)viewDidLoad
{
    self.feedManager = [FeedManager loadFromDevice];
    [super viewDidLoad];
    [self setupBackground];    
    [self setupView];
    [self setupNotifications];
    [self createCells];
    [self showCells];
}

- (void)setupBackground
{
    
    self.title = @"Feeds";
    self.view.backgroundColor = [UIColor colorWithPatternImage:[[RouseConstants instance] BackgroundImage]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Add Feed" style:UIBarButtonItemStylePlain target:self action:@selector(infoButtonTapped:)];
    self.navigationItem.rightBarButtonItem.target = self;
    self.navigationItem.rightBarButtonItem.action = @selector(refreshButtonTapped);
}

-(void)setupView
{
    CGFloat count = [feedManager.feeds count];
    CGFloat numPages = ceilf(count/MaxFeedsPerPage);
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(controllerTap:)];
    
    [self.pageControl setNumberOfPages:numPages];
    [self.pageControl setCurrentPage:0];
    [self.pageControl setUserInteractionEnabled:NO];
    [self.scrollView setPagingEnabled:YES];
    [self.scrollView addGestureRecognizer:tap];
}

-(void)setupNotifications
{
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(orientationChanged:) name:@"UIDeviceOrientationDidChangeNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedDeleted:) name:@"FeedCellDeleted" object:nil];
}

-(void)createCells
{
    self.cells = [[NSMutableArray alloc] init];
    
    int count = [feedManager.feeds count];
    for (int i = 0; i < count; i++)
    {
        Feed *feed = [feedManager.feeds objectAtIndex:i];
        [self createCell:feed];
    }
}

-(void)createCell:(Feed*)feed
{
    RouseFeedCellView *cell = [[RouseFeedCellView alloc]initWithFeed:feed];
    UITapGestureRecognizer *tap =[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(feedTap:)];
    UILongPressGestureRecognizer *press = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPress:)];
    press.minimumPressDuration = 1.0;
    [cell addGestureRecognizer:tap];
    [cell addGestureRecognizer:press];
    [self.cells addObject:cell];
    [self.scrollView addSubview:cell];
}

- (void)controllerTap:(id)object
{
    if(self.deletionState)
    {
        int count = [self.cells count];
        for (int i = 0; i < count; i++)
        {
            RouseFeedCellView *cell = [self.cells objectAtIndex:i];
            [cell endWiggle];
        }
        self.deletionState = NO;
    }
}

- (void)showCells
{    
    UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
    if(interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[[RouseConstants instance] BackgroundImage90]];
        [self showFeedsViewPortrait];
    }
    if(interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
        self.view.backgroundColor = [UIColor colorWithPatternImage:[[RouseConstants instance] BackgroundImage]];
        [self showFeedsViewLandscape];
    }
    
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * self.pageControl.currentPage;
    [self.scrollView scrollRectToVisible:frame animated:NO];
    
    CGFloat count = [feedManager.feeds count];
    CGFloat numPages = ceilf(count/MaxFeedsPerPage);
    [self.pageControl setNumberOfPages:numPages];
}

-(void)showFeedsViewLandscape
{
    CGSize frame = [RouseUtility currentSize];
    int viewWidth = frame.width;
    int viewHeight = frame.height - self.navigationController.navigationBar.frame.size.height - self.pageControl.frame.size.height;
    int space = 30;
    int margin = 30;
    
    int count = [cells count];
    int pages = count / MaxFeedsPerPage;
    self.scrollView.contentSize = CGSizeMake(viewWidth*(pages+1), viewHeight);
    
    for (int i = 0; i < count; i++)
    {
        int page = i / MaxFeedsPerPage;
        int detract = page * MaxFeedsPerPage;
        int xPos = page*viewWidth;
        int yPos = 0;
        if(i % 3 == 0) xPos += margin;
        if(i % 3 == 1) xPos += (viewWidth/2)-(FeedCellWidth/2);
        if(i % 3 == 2) xPos += viewWidth - margin - FeedCellWidth;
        if(i-detract >= 0) yPos = margin;
        if(i-detract >= 3) yPos = viewHeight - margin - FeedCellHeight;
        
        RouseFeedCellView *cell = [cells objectAtIndex:i];
        [cell setPosition:xPos y:yPos];
    }
}

-(void)showFeedsViewPortrait
{
    CGSize frame = [RouseUtility currentSize];
    int viewWidth = frame.width;
    int viewHeight = frame.height - self.navigationController.navigationBar.frame.size.height - self.pageControl.frame.size.height;
    int space = 30;
    int margin = 30;
    
    int count = [cells count];
    int pages = count / MaxFeedsPerPage;
    self.scrollView.contentSize = CGSizeMake(viewWidth*(pages+1), viewHeight);
    
    for (int i = 0; i < count; i++)
    {

        int page = i / MaxFeedsPerPage;
        int detract = page * MaxFeedsPerPage;
        int xPos = page*viewWidth;
        int yPos = 0;
        if(i % 2 == 0) xPos += margin*2;
        if(i % 2 == 1) xPos += viewWidth - margin*2 - FeedCellWidth;
        if(i-detract >= 0) yPos = margin;
        if(i-detract >= 2) yPos = margin + FeedCellHeight + space;
        if(i-detract >= 4) yPos = margin + FeedCellHeight*2 + space*2;
        
        RouseFeedCellView *cell = [cells objectAtIndex:i];
        [cell setPosition:xPos y:yPos];
    }
}

- (void)orientationChanged:(id)object
{
    [self showCells];
}

- (void)createFeed:(id)object
{
    Feed *feed = [[Feed alloc]initWithName:@"" Url:@"url"];
    [self.feedManager.feeds addObject:feed];
    [self.feedManager saveToDevice];
    [self createCell:feed];
    [self showCells];
    
}

- (void)feedDeleted:(id)object
{
    NSLog(@"hej");
    RouseFeedCellView *cell = [object object];
    int index = [self.cells indexOfObject:cell];
    int count = [self.cells count];
    
    for (int i  = count - 1; i >= 0; i--)
    {
        if(i > index)
        {
            RouseFeedCellView *current = [self.cells objectAtIndex:i];
            RouseFeedCellView *previous = [self.cells objectAtIndex:i-1];
            int x = previous.xPosition;
            int y = previous.yPosition;
            [current move:x y:y];
        }
    }
    [self.cells removeObject:cell];
    [self.feedManager.feeds removeObject:cell.feed];
    [self.feedManager saveToDevice];
    [self showCells];
    NSLog(@"hej2");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    float roundedValue = round(scrollView.contentOffset.x / frame.size.width);
    self.pageControl.currentPage = roundedValue;
}

-(void)handleLongPress:(UILongPressGestureRecognizer *)recognizer
{
    if(self.deletionState) return;
    if (recognizer.state == UIGestureRecognizerStateBegan)
    {
        int count = [self.cells count];
        for (int i = 0; i < count; i++)
        {
            RouseFeedCellView *cell = [self.cells objectAtIndex:i];
            [cell beginWiggle];
        }
        self.deletionState = YES;
    }
    
}

- (void)feedTap:(UITapGestureRecognizer *)recognizer
{
    RouseFeedCellView *cell = (RouseFeedCellView*)recognizer.view;
    RouseFeedController *feedController = [self.storyboard instantiateViewControllerWithIdentifier:@"RouseFeedController"];
    [feedController setupWith:cell.feed];
    [self checkStopWobble];
    [self.navigationController pushViewController:feedController animated:YES];
}

- (void)infoButtonTapped:(id)sender
{
    [self checkStopWobble];
    [self performSegueWithIdentifier:@"ShowFeedsManager" sender:@"test"];
    
}

- (void)checkStopWobble
{
    if(self.deletionState)
    {
        int count = [self.cells count];
        for (int i = 0; i < count; i++)
        {
            RouseFeedCellView *cell = [self.cells objectAtIndex:i];
            [cell endWiggle];
        }
        self.deletionState = NO;
        return;
    }
}


@end
