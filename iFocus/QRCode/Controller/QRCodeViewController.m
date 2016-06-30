//
//  QRCodeViewController.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: UIKit
@import AVFoundation;

// MARK: ViewController
#import "QRCodeViewController.h"

// MARK: View
#import "QRCodeAreaView.h"
#import "QRCodeBackgroundView.h"

// MARK: Tool
#import "NetworkManager.h"
#import "JSONConverter.h"

@interface QRCodeViewController () <AVCaptureMetadataOutputObjectsDelegate>
@property (strong, nonatomic) QRCodeAreaView *scanAreaView;
@property (strong, nonatomic) AVCaptureSession *captureSession;
@end

@implementation QRCodeViewController

#pragma mark - Life cycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 扫描区域
    CGRect scanAreaFrame = CGRectMake((SCREEN_WIDTH - SCAN_VIEW_WIDTH) / 2,
                                      (SCREEN_HEIGHT - SCAN_VIEW_HEIGHT) / 2,
                                      SCAN_VIEW_WIDTH,
                                      SCAN_VIEW_HEIGHT);
    
    // 半透明背景
    QRCodeBackgroundView *backgroundView = [[QRCodeBackgroundView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:backgroundView];
    
    //设置扫描区域
    _scanAreaView = [[QRCodeAreaView alloc] initWithFrame:scanAreaFrame];
    [self.view addSubview:_scanAreaView];
    
    // 提示文字
    UILabel *label = [[UILabel alloc] init];
    label.text = @"将二维码放入框内，即开始扫描";
    label.textColor = [UIColor whiteColor];
    [label sizeToFit];
    label.center = CGPointMake(_scanAreaView.center.x, CGRectGetMaxY(scanAreaFrame) + 20);
    [self.view addSubview:label];
    
    // 返回键
    UIButton *backbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    backbutton.frame = CGRectMake(12, 26, 42, 42);
    [backbutton setTitle:@"取消" forState:UIControlStateNormal];
//    [backbutton setBackgroundImage:[UIImage imageNamed:@"prev"] forState:UIControlStateNormal];
    [backbutton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backbutton];
    
    /**
     *  初始化二维码扫描
     */
    
    // 获取摄像设备
    AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 创建输入流
    AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    // 创建输出流
    AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc] init];
    
    // 设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置识别区域
    // 深坑，这个值是按比例0~1设置，而且X、Y要调换位置，width、height调换位置
    output.rectOfInterest = CGRectMake(CGRectGetMinY(scanAreaFrame) / SCREEN_HEIGHT,
                                       CGRectGetMinX(scanAreaFrame) / SCREEN_WIDTH,
                                       CGRectGetHeight(scanAreaFrame) / SCREEN_HEIGHT,
                                       CGRectGetWidth(scanAreaFrame) / SCREEN_WIDTH);
    
    // 初始化链接对象
    _captureSession = [[AVCaptureSession alloc] init];
    //高质量采集率
    [_captureSession setSessionPreset:AVCaptureSessionPresetHigh];
    
    [_captureSession addInput:input];
    [_captureSession addOutput:output];
    
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode,
                                 AVMetadataObjectTypeEAN13Code,
                                 AVMetadataObjectTypeEAN8Code,
                                 AVMetadataObjectTypeCode128Code];
    
    AVCaptureVideoPreviewLayer *layer = [AVCaptureVideoPreviewLayer layerWithSession:_captureSession];
    layer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    layer.frame = self.view.layer.bounds;
    
    [self.view.layer insertSublayer:layer atIndex:0];
    
    // 开始捕获
    [_captureSession startRunning];
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [_scanAreaView startAnimation];
}

- (void)dealloc {
    
    IFLog(@"%@ dealloc", [self class]);
}

#pragma mark - AVCaptureMetadataOutputObjectsDelegate

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    
    if (metadataObjects.count > 0) {
        
        [_captureSession stopRunning];  // 停止扫描
        [_scanAreaView stopAnimation];  // 暂停动画
        AVMetadataMachineReadableCodeObject *metadataObject = [metadataObjects firstObject];
        
        // 输出扫描字符串
        IFLog(@"%@", metadataObject.stringValue);
        [self backAction];
        NSURL *URL = [NSURL URLWithString:metadataObject.stringValue];
        if ([[UIApplication sharedApplication] canOpenURL:URL]) {
            
            [[UIApplication sharedApplication] openURL:URL];
        }
//        __weak __typeof(self)weakSelf = self;
//        [NetworkManager requestWithDictionary:@{@"token" : @"test", @"codeValue" : metadataObject.stringValue} URLString:QRCODE_SCAN_RESULT_URL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//            
//            //
//            if (!error) {
//                
//                NSDictionary *dict = [JSONConverter dictionaryFromJSONData:data];
//                IFLog(@"%@", dict);
//                if ([[dict objectForKey:@"msg"] intValue] == 1) {
//                    
//                    [weakSelf playSoundEffectWithFilename:@"validate.wav"];
//                } else {
//                    
//                    [weakSelf playSoundEffectWithFilename:@"invalidate.wav"];
//                }
//            } else {
//                
//                IFLog(@"请求失败");
//                [weakSelf playSoundEffectWithFilename:@"invalidate.wav"];
//            }
//            
//            [_captureSession startRunning];
//            [_scanAreaView startAnimation];
//        }];
    }
}

#pragma mark - Audio    |   Video

- (void)playSoundEffectWithFilename:(NSString *)filename {
    
    NSURL *URL = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)URL, &soundID);
    AudioServicesPlayAlertSound(soundID);
}

#pragma mark - Action

- (void)backAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
