//
//  Tower.m

#import "Tower.h"
#import "Floor.h"
#import "FloorController.h"
#import "Bitizen.h"
#import "BitizenController.h"

NSString * const kCoins = @"coins";
NSString * const kBux = @"bux";
NSString * const kPaint = @"paint";
NSString * const kElevator = @"elv";
NSString * const kTip = @"tip";
NSString * const kAchievements = @"ach";
NSString * const kCostumes = @"costumes";
NSString * const kMissions = @"missions";

NSString * const kFloors = @"floors";
NSString * const kBitizens = @"bitizens";

@interface Tower ()
@property (nonatomic, assign, readwrite) NSUInteger coins;
@property (nonatomic, assign, readwrite) NSUInteger bux;
@property (nonatomic, assign, readwrite) NSUInteger paint;
@property (nonatomic, assign, readwrite) NSUInteger elevatorSpeed;
@property (nonatomic, assign, readwrite) NSUInteger tip;
@property (nonatomic, retain, readwrite) NSArray *achievements;
@property (nonatomic, retain, readwrite) NSArray *costumes;
@property (nonatomic, retain, readwrite) NSArray *missions;
@property (nonatomic, retain, readwrite) NSArray *floors;
@property (nonatomic, retain, readwrite) NSArray *bitizens;
@end

@implementation Tower

@synthesize coins = m_coins;
@synthesize bux = m_bux;
@synthesize paint = m_paint;
@synthesize elevatorSpeed = m_elevatorSpeed;
@synthesize tip = m_tip;
@synthesize achievements = m_achievements;
@synthesize costumes = m_costumes;
@synthesize missions = m_missions;
@synthesize floors = m_floors;
@synthesize bitizens = m_bitizens;

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.coins = [[dict valueForKey:kCoins] intValue];
        self.bux = [[dict valueForKey:kBux] intValue];
        self.paint = [[dict valueForKey:kPaint] intValue];
        self.elevatorSpeed = [[dict valueForKey:kElevator] intValue];
        self.tip = [[dict valueForKey:kTip] intValue];
        self.achievements = [dict valueForKey:kAchievements];
        self.costumes = [dict valueForKey:kCostumes];
        self.missions = [dict valueForKey:kMissions];
        self.floors = [dict valueForKey:kFloors];
    }
    return self;
}

- (NSString *)description { 
    return [NSString stringWithFormat:@"Coins: %i, Bux: %i", self.coins, self.bux];
}

- (NSString *)bitizensAsString {
    NSMutableString *bitizensString = [[[NSMutableString alloc] init] autorelease];
    for (Bitizen *bitizen in self.bitizens) {
        [bitizensString appendFormat:@"%@,", [bitizen bitizenAsString]];
    }
    return bitizensString;
}

- (NSString *)floorsAsString {
    NSMutableString *floorsString = [[[NSMutableString alloc] init] autorelease];
    for (FloorController *floorController in self.floors) {
        [floorsString appendFormat:@"%@,", [floorController.floor floorAsString]];
    }
    return floorsString;
}

- (NSString *)towerPropertiesAsString {
    NSMutableString *returnString = [[[NSMutableString alloc] init] autorelease];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kCoins, self.coins]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kBux, self.bux]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kPaint, self.paint]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kElevator, self.elevatorSpeed]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kTip, self.tip]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%@;",kAchievements, self.achievements]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%@;",kCostumes, self.costumes]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%@;",kMissions, self.missions]];
    return returnString; 
}

- (NSString *)towerAsString {
    NSMutableString *towerString = [[[NSMutableString alloc] init] autorelease];
    [towerString appendFormat:@"%@|", self.towerPropertiesAsString];
    [towerString appendFormat:@"bitizens{%@}|", self.bitizensAsString];
    [towerString appendFormat:@"stories{%@}", self.floorsAsString];
    return towerString;
}

@end
