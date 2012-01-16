//
//  TransformValue.m

#import "TransformValue.h"

@implementation TransformValue

@synthesize value = m_value;
@synthesize key = m_key;

- (id)initWithKey:(NSString *)key value:(id)value {
    if ([self init]) {
        self.key = key;
        self.value = value;
    }
    
    return self;
}

@end
