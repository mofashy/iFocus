//
//  FileManager.h
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SearchPathDirectory) {
    DocumentDirectory,
    CachesDirectory,
    TemporaryDirectory,
};

@interface FileManager : NSObject
+ (NSDictionary *)dictionaryFromFile:(NSString *)filename directoryType:(SearchPathDirectory)directoryType;
+ (BOOL)writeDictionary:(NSDictionary *)dictionary
                 toFile:(NSString *)filename
          directoryType:(SearchPathDirectory)directoryType;
+ (BOOL)fileExistsWithFilename:(NSString *)filename directoryType:(SearchPathDirectory)directoryType;
@end
