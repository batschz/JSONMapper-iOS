//
//  ViewController.m
//  JSONMapper
//
//  Created by Sven Roeder on 8/26/12.
//  Copyright (c) 2012 appventures. All rights reserved.
//

#import "ViewController.h"

#import "NSDictionary+AVJSON.h"
#import "NSArray+AVJSON.h"
#import "NSObject+AVJSON.h"
#import "ArtistList.h"
#import "Artist.h"
#import "CustomArtist.h"
#import "CustomArtistList.h"


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
    
    
    
    // Json2ArrayOfObjects 2. version
    // ask the mapper to extend an existing object
    NSArray *artistArray = [[rawDict objectForKey:@"results"] asObjectOfClass:@"Artist" nodeMapping:nil];
    for (Artist *artist in artistArray) {
        NSLog(@"V3 Artist name: %@",artist.artistName);
    }
    
    
    
    // Object2Json
    // ask the mapper to recursively export the ivars we are asking for in our keysForExport selector
    // the result is a json string
    NSLog(@"JSON: %@",[artistList dictionaryWithValuesForKeys:[artistList keysForExport]]);
    
    
    
    // manipulate the json string, number values have quotes - this can be happen with php and other typeless webservices
    NSString *json = @"{\"resultCount\":2,\"results\": [{\"wrapperType\":\"artist\", \"artistType\":\"Artist\", \"artistName\":\"Jack Johnson\", \"artistLinkUrl\":\"https://itunes.apple.com/us/artist/jack-johnson/id909253?uo=4\", \"artistId\":\"909253\", \"amgArtistId\":468749, \"primaryGenreName\":\"Rock\", \"primaryGenreId\":21},{\"wrapperType\":\"artist\", \"artistType\":\"Artist\", \"artistName\":\"U2\", \"artistLinkUrl\":\"https://itunes.apple.com/us/artist/u2/id78500?uo=4\", \"artistId\":\"78500\", \"amgArtistId\":5723, \"primaryGenreName\":\"Rock\", \"primaryGenreId\":21}]}";
    
    rawJsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    rawDict = [NSJSONSerialization JSONObjectWithData:rawJsonData options:NSJSONReadingMutableLeaves error:nil];
    artistList = [rawDict asObjectOfClass:@"ArtistList" nodeMapping:[NSDictionary dictionaryWithObject:@"Artist" forKey:@"results"]];
    // the result is a ready made object structure without any manual mapping
    for (Artist *artist in [artistList results]) {
        NSLog(@"V1 Artist name: %@ %@",artist.artistName, [artist.artistId stringValue]); // call a nsnumber method
    }
    
    
    // custom json -> property mapping
    json = @"{\"resultCount\":2,\"results\": [{\"wrapperType\":\"artist\", \"artistType\":\"Artist\", \"artistName\":\"Jack Johnson\", \"artistLinkUrl\":\"https://itunes.apple.com/us/artist/jack-johnson/id909253?uo=4\", \"artistId\":\"909253\", \"amgArtistId\":468749, \"primaryGenreName\":\"Rock\", \"primaryGenreId\":21},{\"wrapperType\":\"artist\", \"artistType\":\"Artist\", \"artistName\":\"U2\", \"artistLinkUrl\":\"https://itunes.apple.com/us/artist/u2/id78500?uo=4\", \"artistId\":\"78500\", \"amgArtistId\":5723, \"primaryGenreName\":\"Rock\", \"primaryGenreId\":21}]}";
    rawJsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    rawDict = [NSJSONSerialization JSONObjectWithData:rawJsonData options:NSJSONReadingMutableLeaves error:nil];
    
    CustomArtistList *customArtistList = [rawDict asObjectOfClass:@"CustomArtistList" nodeMapping:[NSDictionary dictionaryWithObject:@"CustomArtist" forKey:@"results"]];
    for (CustomArtist *artist in [customArtistList artistList]) {
        NSLog(@"V1 Artist name: %@ %@",artist.name, [artist.artistId stringValue]); // call a nsnumber method
    }
    
 }

@end
