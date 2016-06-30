//
//  ViewController.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: ViewController
#import "ViewController.h"
#import "LoginViewController.h"
#import "QRCodeViewController.h"

// MARK: Tool
#import "QRCodeGenerator.h"
#import "QRCodeScanner.h"

// MARK: Delegate
#import "AppDelegate.h"

@interface ViewController ()
@property (strong, nonatomic) LoginViewController *longinViewController;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

#pragma mark - Getter   |   Setter

- (LoginViewController *)longinViewController {
    
    if (!_longinViewController) {
        _longinViewController = [[LoginViewController alloc] init];
    }
    
    return _longinViewController;
}

#pragma mark - Life cycle

- (void)dealloc {
    
    IFLog(@"%@", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishLogIn:) name:@"IFLoginStatusNotification" object:nil];
    [self presentLoginViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View helper

- (void)presentLoginViewController {
  
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    UIWindow *mainWindow = delegate.window;
    [mainWindow addSubview:self.longinViewController.view];
}

- (void)dismissLoginViewController {
    
    [UIView animateWithDuration:0.6f delay:0.5f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.longinViewController.view.alpha = 0.0f;
        self.longinViewController.view.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.5f, 1.5f, 1.0f);
    } completion:^(BOOL finished) {
        [self.longinViewController.view removeFromSuperview];
        self.longinViewController = nil;
    }];
}

#pragma mark - Action

- (IBAction)captureAction:(id)sender {
    
    [self presentViewController:[[QRCodeViewController alloc] init] animated:YES completion:nil];
}

#pragma mark - Notification

- (void)didFinishLogIn:(NSNotification *)notification {
    
    NSDictionary *result = notification.object;
    NSString *status = [result objectForKey:@"status"];
    
    if ([status intValue] == 1) {
        
        IFLog(@"Login success");
        [self dismissLoginViewController];
    } else {
        
        IFLog(@"Login fail");
    }
}
@end
