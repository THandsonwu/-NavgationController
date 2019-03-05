//
//  FirstViewController.m
//  UTNavigationController
//
//  Created by tanzhiwu on 2018/1/23.
//  Copyright © 2018年 tanzhiwu. All rights reserved.
//

#import "FirstViewController.h"
#import "UTNavigationController.h"
#import "SecondViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController
- (IBAction)onClick:(id)sender {
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
     NSLog(@"first=====%@",nav.viewControllers);
    [nav ut_pushViewController:[[SecondViewController alloc] init]];
}
- (IBAction)nav:(id)sender {
    [self.navigationController pushViewController:[SecondViewController new] animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"viewdidload first=====%@",nav.viewControllers);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"first will appear=====%@",nav.viewControllers);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    UTNavigationController *nav = (UTNavigationController *)self.parentViewController;
    NSLog(@"first did appear=====%@&%@",nav.class,nav.viewControllers);
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"first will dis");
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"first did dis");
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
