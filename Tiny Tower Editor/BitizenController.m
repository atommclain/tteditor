//
//  BitizenController.m
//  Tiny Tower Editor
//
//  Created by Adam Mclain on 12/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BitizenController.h"
#import "Bitizen.h"

@interface BitizenController ()
@property (nonatomic, retain, readwrite) NSArray *allBitizens;
@end

@implementation BitizenController

@synthesize allBitizens = m_allBitizens;

- (id)initWithStrings:(NSArray *)strings {
    self = [super init];
    if (self) {
        
        NSArray *(^removeLastObject)(NSArray *) = ^(NSArray *anArray){  //TODO put this somewhere reuseable
            NSMutableArray *tempArray = [NSMutableArray arrayWithArray:anArray];
            [tempArray removeObject:[tempArray lastObject]];
            return tempArray;
        };
        
        NSMutableArray *bitizens = [[NSMutableArray alloc] init];
        for (NSString *bitizenString in strings) {
            NSArray *attributesArray = [bitizenString componentsSeparatedByString:@";"];
            attributesArray = removeLastObject(attributesArray);
            
            NSMutableDictionary *attributes = [[[NSMutableDictionary alloc] init] autorelease];
            for (NSString *attr in attributesArray) {
                if ([attr isEqualToString:@"d"]) {
                    continue;
                }
                NSArray *temp = [attr componentsSeparatedByString:@"="];
                [attributes addEntriesFromDictionary:[NSDictionary dictionaryWithObject:[temp objectAtIndex:1] forKey:[temp objectAtIndex:0]]];
            }
            
            Bitizen *bitizen = [[Bitizen alloc] initWithDictionary:attributes];
            [bitizens addObject:bitizen];
            [bitizen release];

        }
        
        self.allBitizens = bitizens;
        [bitizens release];
    }
    return self;
}

- (id)initWithBitizens:(NSArray *)bitizens {
    
    for (id obj in bitizens) {
        if (![obj isKindOfClass:[Bitizen class]]) {
            return nil;
        }
    }
    
    self = [super init];
    if (self) {
        self.allBitizens = bitizens;
    }
    
    return self;
}


- (NSString *)bitizensAsString {
    NSMutableString *bitizensString = [[[NSMutableString alloc] init] autorelease];
    [bitizensString appendString:@"bitizens{"];
    
    for (Bitizen *bitizen in self.allBitizens) {
        [bitizensString appendFormat:@"%@,", [bitizen bitizenAsString]];
    }
    [bitizensString appendString:@"}"];
    return bitizensString;
}

- (NSArray *)bitizensAtStory:(NSUInteger)story {
    NSIndexSet *indexes = [self.allBitizens indexesOfObjectsPassingTest:^(id obj, NSUInteger idx, BOOL *stop){
        if (story == [obj homeFloor] || story == [obj workFloor] ) {
            return YES;
        }
        return NO;
    }];
    
    NSMutableArray *targetArray  = [NSMutableArray array];
    int count = [self.allBitizens count];
    
    unsigned index = [indexes firstIndex];
    while ( index != NSNotFound )
    {
        if ( index < count )
            [targetArray addObject:[self.allBitizens objectAtIndex:index]];
        
        index = [indexes indexGreaterThanIndex:index];
    }
    
    return targetArray;
}
@end
