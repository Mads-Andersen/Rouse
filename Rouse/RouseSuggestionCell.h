//
//  RouseSuggestionCell.h
//  Rouse
//
//  Created by Mads Andersen on 20/11/12.
//  Copyright (c) 2012 Mads Andersen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Feed.h"

@interface RouseSuggestionCell : UITableViewCell

@property (nonatomic, strong) IBOutlet UILabel *nameLabel;
@property (nonatomic, strong) Feed *feed;

- (void)updateLabel;
- (IBAction)addFeed:(id)sender;

@end
