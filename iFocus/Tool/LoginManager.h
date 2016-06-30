//
//  LoginManager.h
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginManager : NSObject
+ (void)autoLogin;
+ (BOOL)canLoginWithLocalInformation;
+ (void)loginWithUsername:(NSString *)username password:(NSString *)password;
@end
