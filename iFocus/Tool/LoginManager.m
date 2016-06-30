//
//  LoginManager.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: Tool
#import "LoginManager.h"
#import "MD5Encryptor.h"
#import "FileManager.h"
#import "NetworkManager.h"

@implementation LoginManager

+ (BOOL)canLoginWithLocalInformation {
    
    BOOL flag = NO;
    flag = [FileManager fileExistsWithFilename:USER_INFORMATION_LOCAL_FILE directoryType:DocumentDirectory];
    if (flag) {
        
        NSDictionary *dict = [FileManager dictionaryFromFile:USER_INFORMATION_LOCAL_FILE directoryType:DocumentDirectory];
        if (dict.count > 0) {
            
            flag = YES;
        }
    }
    
    return flag;
}

+ (void)autoLogin {
    
    NSDictionary *dict = [FileManager dictionaryFromFile:USER_INFORMATION_LOCAL_FILE directoryType:DocumentDirectory];
    NSString *username = [dict objectForKey:@"username"];
    NSString *password = [dict objectForKey:@"password"];
    
    [LoginManager loginWithUsername:username password:password];
}

+ (void)loginWithUsername:(NSString *)username password:(NSString *)password {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"IFLoginStatusNotification" object:@{@"status" : @"1"}];
//    [NetworkManager requestWithDictionary:@{@"uname" : username, @"upass" : password} URLString:LOGIN_URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//        
//        // is login success
//    }];
}
@end
