JSONMapper-iOS
==============

This iOS categories try to map json data to your own objects, although it has a few limitations

# Usage
Add the NSDictionary+AVJSON.h, NSDictionary+AVJSON.m, NSObject+AVJSON.h, NSObject+AVJSON.m categories to your project
    
## Json2Object 1. option
```
// ask the mapper for a certain object and let it map certain keys to other objects
ArtistList *artistList = [rawDict asObjectOfClass:@"ArtistList" nodeMapping:[NSDictionary dictionaryWithObject:@"Artist" forKey:@"results"]];
```

## Json2Object 2. option
```
// ask the mapper to extend an existing object
artistList = [[ArtistList alloc] init];
[rawDict asObjectOfClass:artistList nodeMapping:[NSDictionary dictionaryWithObject:@"Artist" forKey:@"results"]];
```
        
## Json2ArrayOfObjects 3. option
```
// ask the mapper to return an array of certain objects
NSArray *artistArray = [[rawDict objectForKey:@"results"] asObjectOfClass:@"Artist" nodeMapping:nil];
```
        
## Object2Json
```
// ask the mapper to recursively export the ivars we are asking for in our keysForExport selector
// the result is a json string
NSLog(@"JSON: %@",[artistList dictionaryWithValuesForKeys:[artistList keysForExport]]);
```

Feel free to extend this helper.