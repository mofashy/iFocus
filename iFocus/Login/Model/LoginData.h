//
//  LoginData.h
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginData : NSObject
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;

- (NSDictionary *)converToDictionary;
@end
