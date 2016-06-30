//
//  FileManager.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "FileManager.h"

@implementation FileManager

+ (NSDictionary *)dictionaryFromFile:(NSString *)filename directoryType:(SearchPathDirectory)directoryType {
    
    NSDictionary *dict;
    NSString *absolutlyString = [FileManager absolutlyStringOfFile:filename directoryType:directoryType];
    if ([[NSFileManager defaultManager] fileExistsAtPath:absolutlyString]) {
        
        dict = [NSDictionary dictionaryWithContentsOfFile:absolutlyString];
    }
    
    return dict;
}

+ (BOOL)writeDictionary:(NSDictionary *)dictionary toFile:(NSString *)filename directoryType:(SearchPathDirectory)directoryType {
    
    BOOL flag = NO;
    NSString *absolutlyString = [FileManager absolutlyStringOfFile:filename directoryType:directoryType];
    flag = [dictionary writeToFile:absolutlyString atomically:YES];
    
    return flag;
}

+ (BOOL)fileExistsWithFilename:(NSString *)filename directoryType:(SearchPathDirectory)directoryType  {
    
    BOOL flag = NO;
    NSString *absolutlyString = [FileManager absolutlyStringOfFile:filename directoryType:directoryType];
    if ([[NSFileManager defaultManager] fileExistsAtPath:absolutlyString]) {
        
        flag = YES;
    }
    
    return flag;
}

+ (NSString *)cacheDirectory {
    
    return [FileManager directoryWithSearchPathDirectory:NSCachesDirectory];
}

+ (NSString *)documentDirectiory {
    
    return [FileManager directoryWithSearchPathDirectory:NSDocumentDirectory];
}

+ (NSString *)temporaryDirectory {
    
    return NSTemporaryDirectory();
}

+ (NSString *)directoryWithSearchPathDirectory:(NSSearchPathDirectory)searchPathDirectory {
    
    NSString *path = [NSSearchPathForDirectoriesInDomains(searchPathDirectory, NSUserDomainMask, YES) firstObject];
    
    return path;
}

+ (NSString *)absolutlyStringOfFile:(NSString *)filename directoryType:(SearchPathDirectory)directoryType {
    
    NSString *path = @"";
    switch (directoryType) {
        case CachesDirectory:
            path = [FileManager cacheDirectory];
            break;
        case DocumentDirectory:
            path = [FileManager documentDirectiory];
            break;
        case TemporaryDirectory:
            path = [FileManager temporaryDirectory];
            break;
        default:
            break;
    }
    
    if (path.length > 0) {
        
        NSString *absolutlyString = [path stringByAppendingPathComponent:filename];
        return absolutlyString;
    }
    
    return path;
}
@end
