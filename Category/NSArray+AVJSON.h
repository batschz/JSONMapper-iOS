//
//  NSArray+AVJSON.h
//  JSONMapper
//
//  Created by Sven Roeder on 9/11/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (AVJSON)

- (id)asObjectOfClass:(id)objclass nodeMapping:(NSDictionary*)mapping;
- (NSString*)toJSONWS;

@end