//
//  Floor.m

#import "Floor.h"

NSString * const kFloorNumber = @"s";
NSString * const kLevel = @"l";
NSString * const kFloorType = @"f";
NSString * const kAwaitingStock = @"a";
NSString * const kPTValue = @"pt";
NSString * const kPRValue = @"pr";
NSString * const kSTValue = @"sl";
NSString * const kStockLevel = @"st";
NSString * const kCustomName = @"n";

@interface Floor ()
@property (nonatomic, assign, readwrite) NSUInteger floorNumber;
@property (nonatomic, assign, readwrite) NSUInteger level;
@property (nonatomic, assign, readwrite) NSUInteger floorType;
@property (nonatomic, assign, readwrite) NSInteger awaitingStock;
@property (nonatomic, assign, readwrite) NSInteger ptValue;
@property (nonatomic, assign, readwrite) NSInteger prValue;
@property (nonatomic, retain, readwrite) NSString *stValue;
@property (nonatomic, retain, readwrite) NSString *stockLevel;
@property (nonatomic, retain, readwrite) NSString *customName;
@end

@implementation Floor

@synthesize floorNumber = m_floorNumber;
@synthesize level = m_level;
@synthesize floorType = m_floorType;
@synthesize awaitingStock = m_awaitingStock;
@synthesize ptValue = m_ptValue;
@synthesize prValue = m_prValue;
@synthesize stValue = m_stValue;
@synthesize stockLevel = m_stockLevel;
@synthesize customName = m_customName;

+ (NSDictionary *)emptyFloor {
    NSArray *objects = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:0],
                        [NSNumber numberWithUnsignedInteger:1],
                        [NSNumber numberWithUnsignedInteger:58],
                        [NSNumber numberWithInteger:-1],
                        [NSNumber numberWithInteger:-1],
                        [NSNumber numberWithInteger:-1],
                        @"0:0:0",
                        @"0:0:0",
                        @"", nil];
    NSArray *keys = [NSArray arrayWithObjects:kFloorNumber, kLevel, kFloorType, kAwaitingStock, kPTValue, kPRValue, kSTValue, kStockLevel, kCustomName, nil];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (id)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        self.floorNumber = [[dict valueForKey:kFloorNumber] integerValue];
        self.level = [[dict valueForKey:kLevel] integerValue];
        self.floorType = [[dict valueForKey:kFloorType] integerValue];
        self.awaitingStock = [[dict valueForKey:kAwaitingStock] integerValue];
        self.ptValue = [[dict valueForKey:kPTValue] integerValue];
        self.prValue = [[dict valueForKey:kPRValue] integerValue];
        self.stValue = [dict valueForKey:kSTValue];
        self.stockLevel = [dict valueForKey:kStockLevel];
        self.customName = [dict valueForKey:kCustomName];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"F: %i, AS: %i, pr: %i, slV: %@, stV: %@", self.floorNumber, self.awaitingStock, self.prValue, self.stValue, self.stockLevel];
}

- (NSDictionary *)objectAsDictionary {
    NSArray *objects = [NSArray arrayWithObjects:[NSNumber numberWithUnsignedInteger:self.floorNumber],
                        [NSNumber numberWithUnsignedInteger:self.level],
                        [NSNumber numberWithUnsignedInteger:self.floorType],
                        [NSNumber numberWithInteger:self.awaitingStock],
                        [NSNumber numberWithInteger:self.ptValue],
                        [NSNumber numberWithInteger:self.prValue],
                        self.stValue,
                        self.stockLevel,
                        self.customName, nil];
    NSArray *keys = [NSArray arrayWithObjects:kFloorNumber, kLevel, kFloorType, kAwaitingStock, kPTValue, kPRValue, kSTValue, kStockLevel, kCustomName, nil];
    
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSString *)floorAsString {
    NSMutableString *returnString = [[[NSMutableString alloc] init] autorelease];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kFloorNumber, self.floorNumber]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kFloorType, self.floorType]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kLevel, self.level]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kAwaitingStock, self.awaitingStock]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kPTValue, self.ptValue]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%i;",kPRValue, self.prValue]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%@;",kStockLevel, self.stockLevel]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%@;",kSTValue, self.stValue]];
    [returnString appendString:[NSString stringWithFormat:@"%@=%@;",kCustomName, self.customName]];
    return returnString;
}



@end
