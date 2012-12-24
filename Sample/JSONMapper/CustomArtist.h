//
//  CustomArtist.h
//  JSONMapper
//
//  Created by Werner Huber on 24.12.12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CustomArtist : NSObject

@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *genreName;
@property (nonatomic, strong) NSString *wrapperType;
@property (nonatomic, strong) NSNumber *amgArtistId;
@property (nonatomic, strong) NSNumber *artistId;
@property (nonatomic, strong) NSNumber *genreId;

@end
