//
//  CustomArtist.m
//  JSONMapper
//
//  Created by Werner Huber on 24.12.12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "CustomArtist.h"

@implementation CustomArtist

- (NSDictionary *)propertyMapping {

    return @{@"artistLinkUrl" : @"url",
             @"artistName" : @"name",
             @"artistType" : @"type",
             @"primaryGenreName" : @"genreName",
             @"primaryGenreId" : @"genreId"};

}

@end
