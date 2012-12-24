//
//  NSObject+AVJSON.m
//
//  Created by Sven Röder on 01/01/11.
//  Copyright 2011 Appventures. All rights reserved.
//

#import "NSObject+AVJSON.h"
#import "NSDictionary+AVJSON.h"
#import <objc/runtime.h>

@implementation NSObject (AVJSON)


/**
 * returns an alternative key for a special variable, for instance if a var is called id
 * @return key
 */
- (NSString*)keyExceptionForSourceKey:(NSString*)source
{
    
    NSDictionary *mapping = [self propertyMapping];
    
    if([mapping.allKeys containsObject:source]) {
        return [mapping objectForKey:source];
    }
    
    if([source isEqualToString:@"id"])
    {
        return @"ident";
    }
    
    return source;
}


/**
 * returns an original key for a special variable, for instance if a var is called id
 * @return key
 */
- (NSString*)sourceKeyForExceptionKey:(NSString*)source
{
    if([source isEqualToString:@"ident"])
    {
        return @"id";
    }
    
    return source;
}


- (void)setValuesForKeysWithDictionary:(NSDictionary*)dict nodeMapping:(NSDictionary*)mapping
{
    for (NSString *key in [dict keyEnumerator])
    {
        id obj = [mapping objectForKey:key];
        
        if(obj)
        {
            
            if([[dict objectForKey:key] isKindOfClass:[NSDictionary class]])
            {
                [self setValue:[(NSDictionary*)[dict objectForKey:key] asObjectOfClass:[mapping objectForKey:key]
                                                                            nodeMapping:mapping]
                        forKey:[self keyExceptionForSourceKey:key]];
            }
            else if ([[dict objectForKey:key] isKindOfClass:[NSArray class]])
            {
                NSMutableArray *result = [NSMutableArray array];
                
                for(NSDictionary* item in [dict objectForKey:key])
                {
                    [result addObject:[item asObjectOfClass:[mapping objectForKey:key] 
                                                 nodeMapping:mapping]];
                }
                
                if([result count])
                {
                    [self setValue:result forKey:[self keyExceptionForSourceKey:key]];
                }
            }
        }
        else
        {
            NSString *selectorKey = [self keyExceptionForSourceKey:key];
            selectorKey = [selectorKey stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                               withString:[[selectorKey substringToIndex:1] capitalizedString]];
            SEL selector = NSSelectorFromString([@"set" stringByAppendingFormat:@"%@:",selectorKey]);
            
            id value = [dict valueForKey:key];
            
            if([value isKindOfClass:[NSString class]] && [self isNumberProperty:key])
            {
                NSNumberFormatter * f = [[NSNumberFormatter alloc] init];
                [f setDecimalSeparator:@"."];
                [f setNumberStyle:NSNumberFormatterDecimalStyle];
                NSNumber *number = [f numberFromString:value];
                value = number;
            }
            
            if([self respondsToSelector:selector])
            {
                #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
                [self performSelector:selector withObject:value];
            }
            else
            {
#ifdef DEBUG
                NSLog(@"%@ missing in %@ while import", key, self);
#endif
            }
        }
    }
}


- (NSDictionary*)dictionaryWithValuesForKeys:(NSArray*)keys {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    for (NSString *key in keys)
    {
        
        if([self respondsToSelector:NSSelectorFromString(key)])
        {            
            id value = [self valueForKeyPath:key];
            NSString *cleanKey = [[key componentsSeparatedByString:@"."] lastObject];
            
            if([value isKindOfClass:[NSNumber class]] || [value isKindOfClass:[NSString class]])
            {
                [result setValue:value forKey:[self sourceKeyForExceptionKey:cleanKey]];
            }
            else if ([value isKindOfClass:[NSArray class]])
            {
                NSMutableArray *items = [NSMutableArray array];
                
                for(id item in value)
                {
                    [items addObject:[item dictionaryWithValuesForKeys:[item keysForExport]]];
                }
                
                if([items count])
                {
                    [result setValue:items forKey:[self sourceKeyForExceptionKey:cleanKey]];
                }
            }
            else if ([value isKindOfClass:[NSDictionary class]])
            {
                [result setValue:value forKey:[self sourceKeyForExceptionKey:cleanKey]];
            }
            else
            {
                [result setValue:[value dictionaryWithValuesForKeys:[value keysForExport]]
                          forKey:[self sourceKeyForExceptionKey:cleanKey]];
            }
        }
        else
        {
#ifdef DEBUG
            NSLog(@"%@ missing in %@ while export", key, self);
#endif
        }
    }
    
    return result;
}

/**
 * BOOL if the property with the given name is a NSNumber property
 * @return BOOL if the property with the given name is a NSNumber property
 */
- (BOOL)isNumberProperty:(NSString *)property {
    objc_property_t prop = class_getProperty([self class], property.UTF8String);
    BOOL success = (prop != NULL && strstr(property_getAttributes(prop),"NSNumber") != NULL);
    
    return success;
}


/**
 * returns an array of a complex object and the ivars that need to be exported for json
 * @return array of keys to export of a certain object
 */
- (NSArray*)keysForExport {
    return [NSArray array];
}

- (NSDictionary *)propertyMapping {
    return [NSDictionary dictionary];
}

@end
