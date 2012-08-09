//
//  BitizenCell.m
//  Tiny Tower Editor
//
//  Created by Adam McLain on 8/8/12.
//
//

#import "BitizenCell.h"

@implementation BitizenCell
@synthesize workLabel;
@synthesize homeLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [workLabel release];
    [homeLabel release];
    [super dealloc];
}
@end
