//
//  FloorDetailViewController.h
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Floor;

@interface FloorDetailViewController : UIViewController

@property (nonatomic, retain) Floor *floor;
@property (retain, nonatomic) IBOutlet UILabel *levelLabel;
@property (retain, nonatomic) IBOutlet UIStepper *levelStepper;
@property (retain, nonatomic) IBOutlet UISwitch *ptSwitch;

- (IBAction)levelStepperValueChanged:(UIStepper *)sender;
@end
