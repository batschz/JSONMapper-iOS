//
//  ArtistList.h
//  JSONMapper
//
//  Created by Sven Roeder on 8/26/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArtistList : NSObject

@property (nonatomic, strong) NSNumber *resultCount;
@property (nonatomic, strong) NSArray *results;

@end
