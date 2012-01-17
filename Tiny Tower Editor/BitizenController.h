//
//  BitizenController.h

#import <Foundation/Foundation.h>

@class Bitizen;

@interface BitizenController : NSObject

@property (nonatomic, retain, readonly) Bitizen *bitizen;

- (id)initWithString:(NSString *)string;
- (id)initWithBitizen:(Bitizen *)bitizen;

@end
