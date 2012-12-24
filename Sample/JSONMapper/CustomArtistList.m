//
//  CustomArtistList.m
//  JSONMapper
//
//  Created by Werner Huber on 24.12.12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "CustomArtistList.h"

@implementation CustomArtistList

- (NSDictionary *)propertyMapping {
    
    return @{@"resultCount" : @"count",
             @"results" : @"artistList"};
    
}

@end
