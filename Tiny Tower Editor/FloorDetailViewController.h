//
//  FloorDetailViewController.h

#import <UIKit/UIKit.h>

@class Floor;

@interface FloorDetailViewController : UIViewController

@property (nonatomic, retain) Floor *floor;
@property (retain, nonatomic) IBOutlet UILabel *levelLabel;
@property (retain, nonatomic) IBOutlet UIStepper *levelStepper;
@property (retain, nonatomic) IBOutlet UISwitch *ptSwitch;

- (IBAction)levelStepperValueChanged:(UIStepper *)sender;
@end
