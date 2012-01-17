//
//  BitizenController.m

#import "BitizenController.h"
#import "Bitizen.h"

@interface BitizenController ()
@property (nonatomic, retain, readwrite) Bitizen *bitizen;
@end

@implementation BitizenController

@synthesize bitizen = m_bitizen;

- (id)initWithString:(NSString *)string {
    Bitizen *bit = [[[Bitizen alloc] initWithString:string] autorelease];
    if (bit == nil) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.bitizen = bit;
    }
    return self;
}

- (id)initWithBitizen:(Bitizen *)bitizen {

    self = [super init];
    if (self) {
        self.bitizen = bitizen;
    }
    
    return self;
}

@end
