//
//  JSONConverter.h
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONConverter : NSObject
+ (NSDictionary *)dictionaryFromJSONData:(NSData *)JSONData;
+ (NSDictionary *)dictionaryFromJSONString:(NSString *)JSONString;
+ (NSString *)JSONStringFromDictionary:(NSDictionary *)dictionary;
@end
