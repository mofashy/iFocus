//
//  NetworkManager.h
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^completionHandler)(NSData * __nullable data, NSURLResponse * __nullable response, NSError * __nullable error);

@interface NetworkManager : NSObject
+ (void)requestWithDictionary:(nonnull NSDictionary *)dictionary
                    URLString:(nonnull NSString *)URLString
            completionHandler:(nonnull completionHandler)completionHandler;
@end
