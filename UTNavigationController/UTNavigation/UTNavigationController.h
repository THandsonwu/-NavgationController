//
//  UTNavigationController.h
//  UTNavigationController
//
//  Created by tanzhiwu on 2018/1/22.
//  Copyright © 2018年 tanzhiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UTNavigationController : UIViewController
@property (nonatomic, readonly,strong) NSArray *viewControllers;
@property (nonatomic, assign) UIViewController *rootViewController;

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController;
- (void)ut_pushViewController:(UIViewController *)viewController;
- (void)ut_popViewController;
- (void)ut_popToViewController:(UIViewController *)viewController;
- (void)ut_popToRootViewController;
@end
