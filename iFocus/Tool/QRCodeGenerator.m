//
//  QRCodeGenerator.m
//  iFocus
//
//  Created by Mac os x on 16/3/29.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "QRCodeGenerator.h"

@implementation QRCodeGenerator

+ (UIImage *)QRCodeImageWithString:(NSString *)string iconImage:(UIImage *)iconImage {
    
    NSData *stringData = [string dataUsingEncoding:NSUTF8StringEncoding];
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"H" forKey:@"inputCorrectionLevel"];
    CIImage *qrImage = qrFilter.outputImage;
    
    CIFilter *colorFilter = [CIFilter filterWithName:@"CIFalseColor"];
    [colorFilter setDefaults];
    [colorFilter setValue:qrImage forKey:@"inputImage"];
    [colorFilter setValue:[CIColor colorWithRed:0 green:0 blue:0] forKey:@"inputColor0"];
    [colorFilter setValue:[CIColor colorWithRed:1 green:1 blue:1] forKey:@"inputColor1"];
    
    CGSize size = CGSizeMake(156, 156);
    CGImageRef cgImage = [[CIContext contextWithOptions:nil] createCGImage:qrImage fromRect:qrImage.extent];
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetInterpolationQuality(context, kCGInterpolationNone);
    CGContextScaleCTM(context, 1.0, -1.0);  // 若不翻转，则生成的二维码上下颠倒
    CGContextDrawImage(context, CGContextGetClipBoundingBox(context), cgImage);
    UIImage *codeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRelease(cgImage);
    
    if (iconImage) {
        
        CGRect rect = CGRectMake(0, 0, codeImage.size.width, codeImage.size.height);
        UIGraphicsBeginImageContext(rect.size);
        [codeImage drawInRect:rect];
        
        CGSize avatarSize = CGSizeMake(rect.size.width * 0.25, rect.size.height * 0.25);
        CGFloat x = (rect.size.width - avatarSize.width) * 0.5;
        CGFloat y = (rect.size.height - avatarSize.height) * 0.5;
        [iconImage drawInRect:CGRectMake(x, y, avatarSize.width, avatarSize.height)];
        codeImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return codeImage;
}
@end
