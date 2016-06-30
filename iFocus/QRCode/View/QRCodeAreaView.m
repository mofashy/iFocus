//
//  QRCodeAreaView.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

#import "QRCodeAreaView.h"

typedef NS_ENUM(NSUInteger, MoveDirection) {
    MoveDirectionUp,
    MoveDirectionDown,
};

@interface QRCodeAreaView ()
@property (assign, nonatomic) CGPoint position;
@property (assign, nonatomic) MoveDirection moveDirection;
@property (strong, nonatomic) CADisplayLink *displayLink;
@end

@implementation QRCodeAreaView

#pragma mark - Getter   |   Setter

- (CADisplayLink *)displayLink {
    
    if (!_displayLink) {
        _displayLink = ({
            CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
            [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
            displayLink;});
    }
    
    return _displayLink;
}

- (void)drawRect:(CGRect)rect {
    
    self.position = [self configPointWithRect:rect];
    
    // 绘制图片
    UIImage *image = [UIImage imageNamed:@"line"];
    [image drawAtPoint:self.position];
}

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor clearColor];
        self.moveDirection = MoveDirectionDown;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"frame_icon"]];
        imageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
        [self addSubview:imageView];
    }
    
    return self;
}

- (CGPoint)configPointWithRect:(CGRect)rect {
    
    CGPoint nextPosition = self.position;
    if (self.moveDirection == MoveDirectionDown) {
        
        nextPosition.y++;
        if (nextPosition.y >= CGRectGetMaxY(rect) - 3) {
            
            nextPosition.y--;
            self.moveDirection = MoveDirectionUp;
        }
    } else {
        
        nextPosition.y--;
        if (nextPosition.y <= CGRectGetMinY(rect) - 3) {
            
            nextPosition.y++;
            self.moveDirection = MoveDirectionDown;
        }
    }
    
    return nextPosition;
}

- (void)startAnimation {
    
    self.displayLink.paused = NO;
}

- (void)stopAnimation {
    
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}
@end
