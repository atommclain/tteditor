//
//  FloorController.m

#import "FloorController.h"
#import "Floor.h"

@interface FloorController ()
@property (nonatomic, retain, readwrite) Floor *floor;
@end

@implementation FloorController

@synthesize floor = m_floor;

- (id)initWithString:(NSString *)floorString {
    self = [super init];
    if (self) {
        NSArray *(^removeLastObject)(NSArray *) = ^(NSArray *anArray){  //TODO put this somewhere reuseable
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:anArray];
            [tempArray removeObject:[tempArray lastObject]];
            return tempArray;
        };
        
        NSArray *floorAttributesArray = removeLastObject([floorString componentsSeparatedByString:@";"]);
        
        NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
        for (NSString *attribute in floorAttributesArray) {
            NSArray *temp = [attribute componentsSeparatedByString:@"="];
            [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]]];
        }
        
        Floor *floor = [[[Floor alloc] initWithDictionary:attributes] autorelease];
        
        if (floor == nil) {
            [super release];
            return nil;
        }
        
        self.floor = floor;
    }
    return self;
}

- (id)initWithFloor:(Floor *)floor {
    
    if (floor == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.floor = floor;
    }
    return self;
}

- (void)dealloc {
    self.floor = nil;
    [super dealloc];
}

@end
