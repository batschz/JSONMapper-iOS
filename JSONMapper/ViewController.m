//
//  ViewController.m
//  JSONMapper
//
//  Created by Sven Roeder on 8/26/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "ViewController.h"

#import "NSDictionary+AVJSON.h"
#import "NSObject+AVJSON.h"
#import "ArtistList.h"
#import "Artist.h"


@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];


    // get some dummy data in a bad way, but good enough for demonstration :)
    NSData *rawJsonData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://itunes.apple.com/lookup?amgArtistId=468749,5723"]];
    id rawDict = [NSJSONSerialization JSONObjectWithData:rawJsonData options:NSJSONReadingMutableLeaves error:nil];
    
    
    
    // Json2Object 1. version
    // ask the mapper for a certain object and let it map certain keys to other objects
    ArtistList *artistList = [rawDict asObjectOfClass:@"ArtistList" nodeMapping:[NSDictionary dictionaryWithObject:@"Artist" forKey:@"results"]];
    
    // the result is a ready made object structure without any manual mapping
    for (Artist *artist in [artistList results]) {
        NSLog(@"V1 Artist name: %@",artist.artistName);
    }
    
    
    
    // Json2Object 2. version
    // ask the mapper to extend an existing object
    artistList = [[ArtistList alloc] init];
    [rawDict asObjectOfClass:artistList nodeMapping:[NSDictionary dictionaryWithObject:@"Artist" forKey:@"results"]];
    
    // the result is a ready made object structure without any manual mapping
    for (Artist *artist in [artistList results]) {
        NSLog(@"V2 Artist name: %@",artist.artistName);
    }
    
    
    
    // Object2Json
    // ask the mapper to recursively export the ivars we are asking for in our keysForExport selector
    // the result is a json string
    NSLog(@"JSON: %@",[artistList dictionaryWithValuesForKeys:[artistList keysForExport]]);
    
}

@end
