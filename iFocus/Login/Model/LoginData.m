//
//  LoginData.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "LoginData.h"

@implementation LoginData

- (NSDictionary *)converToDictionary {
    
    NSDictionary *dict;
    [dict setValue:_username forKey:@"uname"];
    [dict setValue:_password forKey:@"upass"];
    
    return dict;
}
@end
