//
//  SecondViewController.m
//  UTNavigationController
//
//  Created by tanzhiwu on 2018/1/23.
//  Copyright © 2018年 tanzhiwu. All rights reserved.
//

#import "SecondViewController.h"
#import "UTNavigationController.h"
#import "ThirdViewController.h"

@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
}
- (IBAction)navpush:(id)sender {
    [self.navigationController pushViewController:[ThirdViewController new] animated:YES];
}
- (IBAction)navpop:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)popClick:(id)sender {
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
//    [nav popViewController:self];
    [nav ut_popViewController];

}
- (IBAction)onClick:(UIButton *)sender {
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    [nav ut_pushViewController:[ThirdViewController new]];
   
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"second will appear=====%@",nav.viewControllers);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"second did appear=====%@",nav.viewControllers);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"second will dis");
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"second did dis");
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
