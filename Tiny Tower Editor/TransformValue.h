//
//  TransformValue.h

#import <Foundation/Foundation.h>

@interface TransformValue : NSObject

@property (nonatomic, retain) id value;
@property (nonatomic, retain) NSString *key;

- (id)initWithKey:(NSString *)key value:(id)value;

@end
