//
//  MD5Encryptor.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: Tool
#import "MD5Encryptor.h"

// MARK: C header
#import "CommonCrypto/CommonDigest.h"

@implementation MD5Encryptor
+ (NSString *)MD5EncryptWithString:(NSString *)string {
    
    const char *cString = [string UTF8String];
    unsigned char result[16];
    CC_MD5(cString, (CC_LONG)strlen(cString), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
