//
//  TowerController.m

#import "TowerController.h"
#import "Tower.h"
#import "Floor.h"
#import "FloorController.h"
#import "Bitizen.h"
#import "BitizenController.h"

@interface TowerController ()
@property (nonatomic, retain, readwrite) Tower *tower;
@end

@implementation TowerController

@synthesize tower = m_tower;

static TowerController *instance = NULL;

+ (TowerController *)sharedInstance;
{
    @synchronized(self)
    {
        if (instance == NULL)
        {
            NSString* path = [[NSBundle mainBundle] pathForResource:@"game" ofType:@"txt"];
            NSString* rawData = [NSString stringWithContentsOfFile:path
                                                          encoding:NSUTF8StringEncoding
                                                             error:NULL];
        
            instance = [[self alloc] initWithString:rawData];
        }
    }
    
    return(instance);
}

- (id)initWithString:(NSString *)str
{
    if ([super init]) {
        NSArray *(^removeLastObject)(NSArray *) = ^(NSArray *anArray){
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:anArray];
            [tempArray removeObject:[tempArray lastObject]];
            return tempArray;
        };
        
        NSArray* (^componantsOfString)(NSString *) = ^(NSString *str){
            NSRange range = [str rangeOfString:@"{"];
            NSUInteger location = range.location + range.length;
            NSUInteger length = [str length] -location -1;
            NSRange trimRange = NSMakeRange(location, length);
            
            NSString *trimedString = [str substringWithRange:trimRange];
            NSArray *anArray = [trimedString componentsSeparatedByString:@","]; 
            
            anArray = removeLastObject(anArray);
            
            return anArray;
        };
        
        NSArray *modelObjectsStrings = [str componentsSeparatedByString:@"|"];
        NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
        
        //Create Tower specific attributes
        NSArray *attributesArray = [[modelObjectsStrings objectAtIndex:0] componentsSeparatedByString:@";"];
        attributesArray = removeLastObject(attributesArray);
        for (NSString *attr in attributesArray) {
            if ([attr isEqualToString:@"d"]) {
                continue;
            }
            NSArray *temp = [attr componentsSeparatedByString:@"="];
            [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]]];
        }
        
        //Create floors
        NSArray *floorStrings = componantsOfString([modelObjectsStrings objectAtIndex:2]);
        NSMutableArray *floorArray = [[NSMutableArray alloc] init];
        for (NSString *floorString in floorStrings) {
            FloorController *fc = [[FloorController alloc] initWithString:floorString];
            [floorArray addObject:fc];
            [fc release];
        }
        [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:floorArray forKey:@"floors"]];
        [floorArray release];
        
        //Create bitizens
        NSArray *bitizenStrings = componantsOfString([modelObjectsStrings objectAtIndex:1]);
         NSMutableArray *bitizenArray = [[NSMutableArray alloc] init];
         for (NSString *bitizenString in bitizenStrings) {
             Bitizen *bit = [[Bitizen alloc] initWithString:bitizenString];
             [bitizenArray addObject:bit];
             [bit release];
         }
        [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:bitizenArray forKey:@"bitizens"]];
        [bitizenArray release];
        
        self.tower = [[[Tower alloc] initWithDictionary:attributes] autorelease];
    }
    
    return self;
}

- (void)dealloc {
    self.tower = nil;
    [super dealloc];
}

- (NSUInteger)numberOfFloors {
    return self.tower.floors.count;
}

- (Floor *)floorAtStory:(NSUInteger)story {
    Floor *returnFloor = nil;
    for (FloorController *tempFloorController in self.tower.floors) {
        if (tempFloorController.floor.floorNumber == story) {
            returnFloor = tempFloorController.floor;
            break;
        }
    }
    
    return returnFloor;
}

@end
