//
//  QRCodeScanner.m
//  iFocus
//
//  Created by Mac os x on 16/3/29.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "QRCodeScanner.h"

@implementation QRCodeScanner

+ (NSArray *)QRCodeWithImage:(UIImage *)image {
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        
        IFLog(@"自带二维码图片识别仅支持8.0以上版本系统");
        return nil;
    }
    
    NSMutableArray *messages = [NSMutableArray array];
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    NSArray *features = [detector featuresInImage:[[CIImage alloc] initWithImage:image]];
    for (CIQRCodeFeature *feature in features) {
        
        [messages addObject:feature.messageString];
    }
    
    return messages;
}

+ (NSArray *)QRCodeWithFile:(NSString *)filePath {
    
    return [QRCodeScanner QRCodeWithImage:[UIImage imageWithContentsOfFile:filePath]];
}
@end
