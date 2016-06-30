//
//  JSONConverter.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "JSONConverter.h"

@implementation JSONConverter

+ (NSDictionary *)dictionaryFromJSONString:(NSString *)JSONString {
    
    NSData *JSONData = [JSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    return [[self class] dictionaryFromJSONData:JSONData];
}

+ (NSDictionary *)dictionaryFromJSONData:(NSData *)JSONData {
    
    NSError *error = nil;
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:JSONData
                                                               options:NSJSONReadingMutableLeaves
                                                                 error:&error];
    
    if (!error) {
        
        return dictionary;
    } else {
        
        return nil;
    }
}

+ (NSString *)JSONStringFromDictionary:(NSDictionary *)dictionary {

    NSError *error = nil;
    NSData *JSONData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    NSString *JSONString = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    
    if (!error) {
        
        return JSONString;
    } else {
        
        return nil;
    }
}
@end
