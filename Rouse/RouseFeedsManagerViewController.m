//
//  RouseFeedsManagerViewController.m
//  Rouse
//
//  Created by Mads Andersen on 29/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseFeedsManagerViewController.h"
#import "RouseSuggestionCell.h"
#import <QuartzCore/QuartzCore.h>

@interface RouseFeedsManagerViewController () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (weak) IBOutlet UITextField *textField;
@property (weak) IBOutlet UIView *backgroundView;
@property (weak) IBOutlet UIButton *addButton;
@property (retain) NSMutableArray *suggestions;

-(IBAction)cancel:(id)sender;
-(IBAction)addFeed:(id)sender;

@end

@implementation RouseFeedsManagerViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundView.layer.cornerRadius = 4;
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.opaque = NO;
    self.addButton.layer.cornerRadius = 4;
    self.addButton.layer.masksToBounds = YES;
    [self.view endEditing:YES];
    self.textField.delegate = self;
    
    self.suggestions = [[NSMutableArray alloc]init];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://api.flickr.com/services/feeds/photos_public.gne"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/ffffound/everyone"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://www.nasa.gov/rss/lg_image_of_the_day.rss"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/ImgurGallery?format=xml"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/EarthShots"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/MotsEnImages"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/DigitalPhotographySchool"]];
    [self.suggestions addObject:[[Feed alloc]initWithUrl:@"http://feeds.feedburner.com/jmg-galleries"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal
{
    return NO;
}

-(IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)addFeed:(id)sender
{
    NSString *url = self.textField.text;
    Feed *feed = [[Feed alloc]initWithUrl:url];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateFeed" object:feed];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [self.suggestions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RouseSuggestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouseSuggestionCell" forIndexPath:indexPath];
    Feed *suggestion = [self.suggestions objectAtIndex:indexPath.item];
    [cell setFeed:suggestion];
    [cell setupNotications];
    
    return cell;
}

@end
