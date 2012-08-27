//
//  Artist.m
//  JSONMapper
//
//  Created by Sven Roeder on 8/26/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "Artist.h"

@implementation Artist


- (NSArray*)keysForExport
{
    return [NSArray arrayWithObjects:@"artistName", @"artistType", nil];
}

@end
