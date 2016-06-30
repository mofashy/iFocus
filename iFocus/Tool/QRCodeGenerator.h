//
//  QRCodeGenerator.h
//  iFocus
//
//  Created by Mac os x on 16/3/29.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QRCodeGenerator : NSObject
+ (UIImage *)QRCodeImageWithString:(NSString *)string iconImage:(UIImage *)iconImage;
@end
