//
//  ViewController.m
//  UTNavigationController
//
//  Created by tanzhiwu on 2018/1/22.
//  Copyright © 2018年 tanzhiwu. All rights reserved.
//

#import "ViewController.h"
#import "UTNavigationController.h"
#import "FirstViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)nav:(id)sender {
    [self.navigationController pushViewController:[FirstViewController new] animated:YES];
}
- (IBAction)utnav:(id)sender {
    UTNavigationController *nav = [[UTNavigationController alloc] initWithRootViewController:[[FirstViewController alloc] init]];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
 
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"nav view will appear");
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    NSLog(@"nav view did appear");
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"nav view will disappear");
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    NSLog(@"nav view did disappear");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
