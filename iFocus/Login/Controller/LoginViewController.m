//
//  LoginViewController.m
//  iFocus
//
//  Created by Mac os x on 16/3/28.
//  Copyright © 2016年 YCS. All rights reserved.
//

// MARK: ViewController
#import "LoginViewController.h"
#import "ViewController.h"

// MARK: View
#import "LoginView.h"

@interface LoginViewController ()
@property (strong, nonatomic) LoginView *loginView;
@end

@implementation LoginViewController

#pragma mark - Getter   |   Setter

- (LoginView *)loginView {
    
    if (!_loginView) {
        _loginView = [[LoginView alloc] init];
    }
    
    return _loginView;
}

#pragma mark - Life cycle

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    IFLog(@"%@ dealloc", [self class]);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.loginView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
