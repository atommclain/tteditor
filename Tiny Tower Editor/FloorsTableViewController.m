//
//  FloorsTableViewController.m

#import "FloorsTableViewController.h"
#import "FloorDetailViewController.h"
#import "FloorController.h"
#import "Floor.h"
#import "BitizenController.h"
#import "Bitizen.h"
#import "Tower.h"
#import "TowerController.h"

@interface FloorsTableViewController ()
@property (nonatomic, retain) TowerController *towerController;
- (void)reorderTable;
@end

@implementation FloorsTableViewController

@synthesize towerController = m_towerController;

- (void)dealloc {
    self.towerController = nil;
    [super dealloc];
}
#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NSLocalizedString(@"Floors", @"floors label");
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
    
    /*
     NSString *service = @"eeenmachine.tinytowers.gameData";
     NSString *account = @"gameData";
     id ret = nil;
     NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjectsAndKeys:
     (id)kSecClassGenericPassword, (id)kSecClass,
     service, (id)kSecAttrService,
     account, (id)kSecAttrAccount,
     nil];
     [keychainQuery setObject:(id)kCFBooleanTrue forKey:(id)kSecReturnData];
     CFDataRef keyData = NULL;
     if (SecItemCopyMatching((CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
     @try {
     ret = [NSKeyedUnarchiver unarchiveObjectWithData:(NSData *)keyData];
     }
     @catch (NSException *e) {
     NSLog(@"Unarchive of %@ failed: %@", service, e);
     }
     @finally {}
     }
     if (keyData) CFRelease(keyData);
     */
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(reorderTable)];
	[self.navigationItem setRightBarButtonItem:addButton];
    [addButton release];
    
    self.towerController = [TowerController sharedInstance];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.towerController.numberOfFloors + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewFloorCell"];
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FloorCell"];
    int floorsCount = self.towerController.numberOfFloors;
    int inverseIndex = floorsCount +1 -indexPath.row;
    Floor *floor = [self.towerController floorAtStory:inverseIndex];
    cell.textLabel.text = [NSString stringWithFormat:@"Floor %i", floor.floorNumber];
    cell.detailTextLabel.text = floor.description;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"FloorDetailViewController"]) {
        int selectedRow = [self.tableView indexPathForSelectedRow].row;
        int rowAsStory = self.towerController.numberOfFloors +1 -selectedRow;
        FloorDetailViewController *detailViewController = [segue destinationViewController];
        detailViewController.floor = [self.towerController floorAtStory:rowAsStory];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        //[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
//    else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
}
*/

/*
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
    int originStory = self.floorController.count +1 - fromIndexPath.row;
    int destinationStory = self.floorController.count +1 - toIndexPath.row;
    Floor *floorToMove = [self.floorController floorAtStory:originStory];
    [self.floorController moveFloor:floorToMove toStory:destinationStory];
    [self.tableView reloadData];
}


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    if (indexPath.row == self.floorController.count || indexPath.row == 0) {
        return NO;
    }
    return YES;
}
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        //[self.floorController buildNewFloor];
        //[self.tableView reloadData];
        
        NSArray *theFloors = self.towerController.tower.floors;
        
        int nextFloorLevel = theFloors.count +1;
        NSMutableDictionary *futureFloorDick = [[Floor aptFloor] mutableCopy];
        [futureFloorDick setValue:[NSNumber numberWithInt:nextFloorLevel] forKey:@"s"];
        
        Floor *emptyFloor = [[Floor alloc] initWithDictionary:futureFloorDick];
        FloorController *controller = [[FloorController alloc] initWithFloor:emptyFloor];
        self.towerController.tower.floors = [theFloors arrayByAddingObject:controller];
        
        
        
        [self.tableView reloadData];
    }
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    if (proposedDestinationIndexPath.row == 0) {
        return [NSIndexPath indexPathForRow:1 inSection:0];
    }
    int floorCount = self.towerController.numberOfFloors;
    if (proposedDestinationIndexPath.row == floorCount ) {
        return [NSIndexPath indexPathForRow:floorCount -1 inSection:0];
    }
    
    return proposedDestinationIndexPath;
}

- (void)reorderTable {
    NSDate *date = [[NSDate date] dateByAddingTimeInterval:346676722];
    NSLog(@"%@", date);
    if (self.tableView.editing) {
        [self.tableView setEditing:NO animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Edit"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStylePlain];
    } else {
        [self.tableView setEditing:YES animated:YES];
        [self.navigationItem.rightBarButtonItem setTitle:@"Done"];
		[self.navigationItem.rightBarButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}

@end
