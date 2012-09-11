//
//  NSArray+AVJSON.m
//  JSONMapper
//
//  Created by Sven Roeder on 9/11/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "NSArray+AVJSON.h"
#import "NSObject+AVJSON.h"
#import "Artist.h"

@implementation NSArray (AVJSON)


- (id)asObjectOfClass:(id)objclass nodeMapping:(NSDictionary*)mapping
{
    NSMutableArray *result = [NSMutableArray array];
    
    for(id item in self)
    {
        [result addObject:[item asObjectOfClass:objclass nodeMapping:mapping]];
    }
    
    return result;
}


- (NSData*)toJSON
{
    NSError* error = nil;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    
    if (error != nil)
    {
        return nil;
    }
    
    return result;
}


/**
 * returns a ready to post string for a webservice
 * @return json encoded objects
 */
- (NSString*)toJSONWS {
    NSMutableArray *array = [NSMutableArray arrayWithArray:self];
    
    return [[NSString alloc] initWithData:[array toJSON] encoding:NSUTF8StringEncoding];
}

@end
