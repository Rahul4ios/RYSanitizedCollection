//
//  NSObject+RYCollectionRemoveNull.h
//
//  Created by Rahul Yadav on 23/05/18.
//

#import <Foundation/Foundation.h>

@interface NSObject (RYCollectionRemoveNull)

/**
 Remove NSNull from collection. Especially used in Firebase responses.
 Firebase doesn't have array. It has only dictionaries.
 We traverse through a collection and when find an array then go inside it and remove the nulls
 @return collection without NSNulls
 */
-(id)RYRemoveNull;

/**
 Do we handle this type
 @return YES/NO
 */
-(BOOL)RYRemoveNullIsThisTypeHandled;


@end

@interface NSDictionary (RYRemoveNull)

/**
 Removes null
 @return dict with null removed
 */
-(NSDictionary*)RYRemoveNull;

@end

@interface NSArray (RYRemoveNull)

/**
 Removes null
 @return array with null removed
 */
-(NSArray*)RYRemoveNull;

@end
