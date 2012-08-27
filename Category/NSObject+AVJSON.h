//
//  NSObject+AVJSON.h
//
//  Created by Sven Röder on 01/01/11.
//  Copyright 2011 Appventures. All rights reserved.
//

@interface NSObject (NSObject_AVJSON)

- (NSArray*)keysForExport;
- (void)setValuesForKeysWithDictionary:(NSDictionary*)dict nodeMapping:(NSDictionary*)mapping;

@end
