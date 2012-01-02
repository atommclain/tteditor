//
//  Bitzen.m


#import "Bitizen.h"

NSString * const kHomeFloor = @"h";
NSString * const kWorkFloor = @"w";
NSString * const kDreamJobID = @"j";
NSString * const kSValue = @"s";
NSString * const kVSValue = @"vs";
NSString * const kCostume = @"c";


@interface Bitizen ()
@property (nonatomic, assign, readwrite) NSUInteger homeFloor;
@property (nonatomic, assign, readwrite) NSInteger workFloor;
@property (nonatomic, assign, readwrite) NSUInteger dreamJobID;
@property (nonatomic, assign, readwrite) NSUInteger sValue;
@property (nonatomic, assign, readwrite) NSUInteger vsValue;
@property (nonatomic, retain, readwrite) NSString *costume;
@end

@implementation Bitizen

@synthesize homeFloor = m_homeFloor;
@synthesize workFloor = m_workFloor;
@synthesize dreamJobID = m_dreamJobID;
@synthesize sValue = m_sValue;
@synthesize vsValue = m_vsValue;
@synthesize costume = m_costume;

- (id)initWithDictionary:(NSDictionary *) dict
{
    self = [super init];
    if (self) {
        self.homeFloor = [[dict valueForKey:kHomeFloor] intValue];
        self.workFloor = [[dict valueForKey:kWorkFloor] intValue];
        self.dreamJobID = [[dict valueForKey:kDreamJobID] intValue];
        self.sValue = [[dict valueForKey:kSValue] intValue];
        self.vsValue = [[dict valueForKey:kVSValue] intValue];
        self.costume = [dict valueForKey:kCostume];
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
    NSString *numStr = [NSString stringWithFormat:@"%i", self.vsValue];
    NSRange range = NSMakeRange(numStr.length-5, 2);
    numStr = [numStr substringWithRange:range];
    return [NSString stringWithFormat:@"Home floor: %i, Work floor: %i, sValue: %i, vsValue: %i, delta %i middle2: %@", self.homeFloor, self.workFloor, self.sValue, self.vsValue, abs(self.sValue - self.vsValue), numStr ];
}

- (NSDictionary *)objectAsDictionary {
    NSArray *objects = [NSArray arrayWithObjects:[NSNumber numberWithInt:self.homeFloor],
                                                [NSNumber numberWithInt:self.workFloor],
                                                [NSNumber numberWithInt:self.dreamJobID],
                                                [NSNumber numberWithInt:self.sValue],
                                                [NSNumber numberWithInt:self.vsValue],
                                                self.costume, nil];
    NSArray *keys = [NSArray arrayWithObjects:kHomeFloor, kWorkFloor, kDreamJobID, kSValue, kVSValue, kCostume, nil];
    return [NSDictionary dictionaryWithObjects:objects forKeys:keys];
}

- (NSString *)bitizenAsString {
    NSDictionary *dict = [self objectAsDictionary];
    NSMutableString *returnString = [[[NSMutableString alloc] init] autorelease];
    NSArray *keys = [dict allKeys];
    for (NSString *key in keys) {
        [returnString appendString:[NSString stringWithFormat:@"%@=%@;",key, [dict valueForKey:key]]];
    }
    return returnString;
}

@end
