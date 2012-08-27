//
//  ArtistList.m
//  JSONMapper
//
//  Created by Sven Roeder on 8/26/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "ArtistList.h"

@implementation ArtistList


- (NSArray*)keysForExport
{
    return [NSArray arrayWithObjects:@"results", nil];
}

@end
