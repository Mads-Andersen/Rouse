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
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void)updateLabel
{
    self.nameLabel.text = feed.name;
}

- (IBAction)addFeed:(id)sender
{
    
}

@end
