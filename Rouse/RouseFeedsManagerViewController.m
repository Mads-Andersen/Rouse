//
//  RouseFeedsManagerViewController.m
//  Rouse
//
//  Created by Mads Andersen on 29/10/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseFeedsManagerViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RouseFeedsManagerViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak) IBOutlet UITextField *textField;
@property (weak) IBOutlet UIView *backgroundView;
@property (weak) IBOutlet UIButton *addButton;

-(IBAction)cancel:(id)sender;
-(IBAction)addFeed:(id)sender;

@end

@implementation RouseFeedsManagerViewController

@synthesize childView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.backgroundView.layer.cornerRadius = 4;
    self.backgroundView.layer.masksToBounds = YES;
    self.backgroundView.opaque = NO;
    self.addButton.layer.cornerRadius = 4;
    self.addButton.layer.masksToBounds = YES;
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(IBAction)cancel:(id)sender
{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:^{}];
}

-(IBAction)addFeed:(id)sender
{
    NSString *text = self.textField.text;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateFeed" object:text];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 9;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RouseSuggestionCell" forIndexPath:indexPath];
    return cell;
}

@end
