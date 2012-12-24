//
//  NSObject+AVJSON.h
//
//  Created by Sven Röder on 01/01/11.
//  Copyright 2011 Appventures. All rights reserved.
//

@interface NSObject (AVJSON)

- (NSArray*)keysForExport;
- (NSDictionary *)propertyMapping;
- (void)setValuesForKeysWithDictionary:(NSDictionary*)dict nodeMapping:(NSDictionary*)mapping;

@end
