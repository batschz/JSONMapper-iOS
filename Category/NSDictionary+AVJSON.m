//
//  NSDictionary+AVJSON.m
//
//  Created by Sven Röder on 01/01/11.
//  Copyright 2011 Appventures. All rights reserved.
//

#import "NSDictionary+AVJSON.h"
#import "NSObject+AVJSON.h"

@implementation NSDictionary (AVJSON)


- (id)asObjectOfClass:(id)objclass nodeMapping:(NSDictionary*)mapping
{
    id obj = nil;

    if([objclass isKindOfClass:[NSString class]]) 
	{
        obj = [[NSClassFromString(objclass) alloc] init];
    } 
    else
    {
        obj = objclass;
    }
    
    [(NSObject*)obj setValuesForKeysWithDictionary:self nodeMapping:mapping];

    return obj;
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
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:self];

    return [[NSString alloc] initWithData:[dict toJSON] encoding:NSUTF8StringEncoding];
}

@end
