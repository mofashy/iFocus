//
//  QRCodeBackgroundView.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "QRCodeBackgroundView.h"

@implementation QRCodeBackgroundView

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
   
    [[[UIColor blackColor] colorWithAlphaComponent:0.5] setFill];
    
    CGMutablePathRef screenPath = CGPathCreateMutable();
    CGPathAddRect(screenPath, NULL, self.bounds);
    
    CGMutablePathRef scanPath = CGPathCreateMutable();
    CGPathAddRect(scanPath, NULL, CGRectMake((SCREEN_WIDTH - SCAN_VIEW_WIDTH) / 2,
                                             (SCREEN_HEIGHT - SCAN_VIEW_HEIGHT) / 2,
                                             SCAN_VIEW_WIDTH,
                                             SCAN_VIEW_HEIGHT));
                  
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddPath(path, NULL, screenPath);
    CGPathAddPath(path, NULL, scanPath);
      
    CGContextAddPath(context, path);
    CGContextDrawPath(context, kCGPathEOFill); // kCGPathEOFill 方式
      
    CGPathRelease(screenPath);
    CGPathRelease(scanPath);
    CGPathRelease(path);
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}
@end
