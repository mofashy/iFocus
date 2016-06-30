//
//  MD5Encryptor.h
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MD5Encryptor : NSObject
+ (NSString *)MD5EncryptWithString:(NSString *)string;
@end
