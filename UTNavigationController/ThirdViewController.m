//
//  ThirdViewController.m
//  UTNavigationController
//
//  Created by tanzhiwu on 2018/1/23.
//  Copyright © 2018年 tanzhiwu. All rights reserved.
//

#import "ThirdViewController.h"
#import "UTNavigationController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController
- (IBAction)onClick:(id)sender {
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
//    [nav popViewController:self];
    [nav ut_popToRootViewController];
//    [nav ut_popToViewController:nav.viewControllers[1]];
    
}
- (IBAction)navpop:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"third =====%ld &%@",nav.viewControllers.count,nav.class);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"third will appear=====%@",nav.viewControllers);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"third did appear=====%@",nav.viewControllers);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"third will dis");
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"third did dis");
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
