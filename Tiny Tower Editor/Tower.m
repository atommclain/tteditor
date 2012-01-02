//
//  Tower.m

#import "Tower.h"

NSString * const kCoins = @"coins";
NSString * const kBux = @"bux";
NSString * const kPaint = @"paint";
NSString * const kElevator = @"elv";
NSString * const kTip = @"tip";
NSString * const kAchievements = @"ach";
NSString * const kCostumes = @"costumes";
NSString * const kMissions = @"missions";

@interface Tower ()
@property (nonatomic, assign, readwrite) NSUInteger coins;
@property (nonatomic, assign, readwrite) NSUInteger bux;
@property (nonatomic, assign, readwrite) NSUInteger paint;
@property (nonatomic, assign, readwrite) NSUInteger elevatorSpeed;
@property (nonatomic, assign, readwrite) NSUInteger tip;
@property (nonatomic, retain, readwrite) NSArray *achievements;
@property (nonatomic, retain, readwrite) NSArray *costumes;
@property (nonatomic, retain, readwrite) NSArray *missions;
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
    }
    return self;
}

- (id)initWithString:(NSString *)str
{
    NSArray *(^removeLastObject)(NSArray *) = ^(NSArray *anArray){  //TODO put this somewhere reuseable
        NSMutableArray *tempArray = [NSMutableArray arrayWithArray:anArray];
        [tempArray removeObject:[tempArray lastObject]];
        return tempArray;
    };
    
    NSArray *attributesArray = [str componentsSeparatedByString:@";"];
    attributesArray = removeLastObject(attributesArray);
    
    NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
    for (NSString *attr in attributesArray) {
        if ([attr isEqualToString:@"d"]) {
            continue;
        }
        NSArray *temp = [attr componentsSeparatedByString:@"="];
        [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]]];
    }
    
    return [self initWithDictionary:attributes];
}

- (NSString *)description { 
    return [NSString stringWithFormat:@"Coins: %i, Bux: %i", self.coins, self.bux];
}

- (NSString *)towerAsString {
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

@end