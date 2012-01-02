//
//  FloorDetailViewController.m
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FloorDetailViewController.h"
#import "Floor.h"

@implementation FloorDetailViewController

@synthesize floor = m_floor;
@synthesize levelLabel;
@synthesize levelStepper;
@synthesize ptSwitch;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    self.floor = nil;
    [levelLabel release];
    [levelStepper release];
    [ptSwitch release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)loadView
{
    [super loadView];
}



- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
    self.title = [NSString stringWithFormat:@"Floor %i", self.floor.floorNumber];
    self.levelLabel.text = [NSString stringWithFormat:@"%i", self.floor.level];
    self.levelStepper.value = self.floor.level;
    if (self.floor.ptValue == -1) {
        self.ptSwitch.enabled = NO;
    }
    self.ptSwitch.on = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    NSMutableDictionary *newFloorDict = [NSMutableDictionary dictionaryWithDictionary:[self.floor objectAsDictionary]];
    if (self.ptSwitch.on == YES) {
        //[newFloorDict setObject:[NSNumber numberWithInteger:-1] forKey:kPTValue];
    }
    if (self.levelStepper.value != self.floor.level) {
        //[newFloorDict setObject:[NSNumber numberWithDouble:self.levelStepper.value] forKey:kLevel];
    }
    Floor *newFloor = [[Floor alloc] initWithDictionary:newFloorDict];
}


- (void)viewDidUnload
{
    [self setLevelLabel:nil];
    [self setLevelStepper:nil];
    [self setPtSwitch:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)levelStepperValueChanged:(UIStepper *)sender {
    self.levelLabel.text = [NSString stringWithFormat:@"%i", (int)[sender value]];
}
@end
