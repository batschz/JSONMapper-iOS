//
//  Artist.h
//  JSONMapper
//
//  Created by Sven Roeder on 8/26/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic, strong) NSString *artistLinkUrl;
@property (nonatomic, strong) NSString *artistName;
@property (nonatomic, strong) NSString *artistType;
@property (nonatomic, strong) NSString *primaryGenreName;
@property (nonatomic, strong) NSString *wrapperType;
@property (nonatomic, strong) NSNumber *amgArtistId;
@property (nonatomic, strong) NSNumber *artistId;
@property (nonatomic, strong) NSNumber *primaryGenreId;

@end
