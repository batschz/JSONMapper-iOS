//
//  NSDictionary+AVJSON.h
//
//  Created by Sven Röder on 01/01/11.
//  Copyright 2011 Appventures. All rights reserved.
//

@interface NSDictionary (AVJSON)

- (id)asObjectOfClass:(id)objclass nodeMapping:(NSDictionary*)mapping;
- (NSString*)toJSONWS;

@end
