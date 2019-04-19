//
//  NSObject+RYCollectionRemoveNull.m
//
//  Created by Rahul Yadav on 23/05/18.
//

#import "NSObject+RYCollectionRemoveNull.h"

@implementation NSObject (RYCollectionRemoveNull)

-(id)RYRemoveNull{
    
    if (![self RYRemoveNullIsThisTypeHandled]) {
        
        return self;
    }
    
    return [self RYRemoveNull];
}

-(BOOL)RYRemoveNullIsThisTypeHandled{
    
    if ([self isKindOfClass:[NSArray class]] || [self isKindOfClass:[NSDictionary class]]) {
        
        return YES;
    }
    return NO;
}

@end

@implementation NSDictionary (RYRemoveNull)

-(NSDictionary*)RYRemoveNull{
    
    NSMutableDictionary *mDict = nil;
    if ([self isMemberOfClass:[NSMutableDictionary class]]) {
        // Case: i am already mutable
        
        mDict = (NSMutableDictionary*)self;
    }
    else{
        
        mDict = [self mutableCopy];
    }
    
    for (NSString *key in mDict.allKeys) {
        
        id value = [mDict objectForKey:key];
        
        if ([value isKindOfClass:[NSNull class]]) {
            // Case: null
            
            [mDict setValue:nil forKey:key];
        }
        else{
            
            if ([value RYRemoveNullIsThisTypeHandled]) {
                
                NSObject *updatedValue = [value RYRemoveNull]; // recursive class
                
                [mDict setObject:updatedValue forKey:key];
            }
        }
    }
    return mDict;
}

@end


@implementation NSArray (RYRemoveNull)

-(NSArray*)RYRemoveNull{
    
    NSPredicate *predicateNull = [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        
        return [evaluatedObject isKindOfClass:[NSNull class]] ? NO : YES;
    }];
    
    NSArray *updatedArr = [self filteredArrayUsingPredicate:predicateNull];  // remove null
    
    NSMutableArray *mArr = [updatedArr mutableCopy];
    
    for (NSInteger idx = 0; idx < mArr.count; idx++) {
        
        NSObject *element = [mArr objectAtIndex:idx];
        
        if ([element RYRemoveNullIsThisTypeHandled]) {
            // Case: dictionary or array
            
            id updatedElement = [element RYRemoveNull];    // call to NSObject
            [mArr replaceObjectAtIndex:idx withObject:updatedElement];
        }
    }
    return mArr;
}

@end
