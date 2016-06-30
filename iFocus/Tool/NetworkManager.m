//
//  NetworkManager.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: Tool
#import "NetworkManager.h"
#import "JSONConverter.h"

@implementation NetworkManager

+ (void)requestWithDictionary:(NSDictionary *)dictionary URLString:(NSString *)URLString completionHandler:(completionHandler)completionHandler {
    
    NSURL *URL = [NSURL URLWithString:URLString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    NSString *JSONString = [JSONConverter JSONStringFromDictionary:dictionary];
    request.HTTPBodyStream = [[NSInputStream alloc] initWithData:[JSONString dataUsingEncoding:NSUTF8StringEncoding]];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:completionHandler] resume];
}
@end
