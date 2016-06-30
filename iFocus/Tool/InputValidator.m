//
//  InputValidator.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "InputValidator.h"

@implementation InputValidator

+ (BOOL)isEmpty:(id)obj {
    
    BOOL flag = NO;
    if (obj == nil) {
        
        flag = YES;
    } else if ([obj isKindOfClass:[NSNull class]]) {
        
        flag = YES;
    } else if ([obj isKindOfClass:[NSArray class]] &&
               ((NSArray *)obj).count == 0) {
        
        flag = YES;
    } else if ([obj isKindOfClass:[NSDictionary class]] &&
               ((NSDictionary *)obj).count == 0) {
        
        flag = YES;
    } else if ([obj isKindOfClass:[NSString class]] &&
               ((NSString *)obj).length == 0) {
        
        flag = YES;
    }
    
    return flag;
}
@end
