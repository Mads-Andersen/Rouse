//
//  RouseSuggestionCell.m
//  Rouse
//
//  Created by Mads Andersen on 20/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import "RouseSuggestionCell.h"

@implementation RouseSuggestionCell
@synthesize feed;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        
    }
    return self;
}

- (void)setupNotications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(feedNameDownloaded:) name:@"FeedNameDownloaded" object:nil];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)feedNameDownloaded:(NSNotification*) notification
{
    if(self.feed == notification.object)
    {
        [self.nameLabel setText:self.feed.name];
    }
}

- (IBAction)addFeed:(id)sender
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"CreateFeed" object:self.feed];
}

-(void) dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
