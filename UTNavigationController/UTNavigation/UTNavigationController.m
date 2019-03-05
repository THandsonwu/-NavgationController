//
//  UTNavigationController.m
//  UTNavigationController
//
//  Created by tanzhiwu on 2018/1/22.
//  Copyright © 2018年 tanzhiwu. All rights reserved.
//


#import "UTNavigationController.h"
#import "SwipTransitionAnimator.h"

typedef NS_ENUM(NSUInteger, Direction) {
    DirectionLeft,
    DirectionRight,
};
@interface PrivateTransitionContext:NSObject<UIViewControllerContextTransitioning>

@property (nonatomic, copy) void(^completionBlock)(BOOL didCompleted);
@property (nonatomic, assign, getter=isAnimated) BOOL animated;
@property (nonatomic, assign, getter=isInteractive) BOOL interactive;

- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController direction:(Direction)direction;
@end
@interface PrivateAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>
@end
@interface UTNavigationController ()
//@property (nonatomic, readwrite, strong) NSMutableArray *viewControllers;
@property (nonatomic, strong)            UIView         *utContainerView;
@end

@implementation UTNavigationController
- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super init]) {
        self.rootViewController = rootViewController;
        [self addChildViewController:self.rootViewController];
        self.rootViewController.view.frame = self.view.bounds;
        [self.rootViewController beginAppearanceTransition:YES animated:YES];
        [self.utContainerView addSubview:self.rootViewController.view];
        [self.rootViewController didMoveToParentViewController:self];
        [self.rootViewController endAppearanceTransition];
    }
    return self;
}

- (NSArray *)viewControllers
{
    return [self.childViewControllers copy];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.utContainerView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.utContainerView];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (UIViewController *)childViewControllerForStatusBarStyle
{
    return [self.viewControllers lastObject];
}
- (BOOL)shouldAutomaticallyForwardAppearanceMethods
{
    return NO;
}

#pragma mak---private method
- (void)ut_pushViewController:(UIViewController *)viewController
{
    UIViewController *fromViewController = ([self.childViewControllers count] > 0 ? [self.childViewControllers lastObject] : self.rootViewController);
    
   
    id<UIViewControllerAnimatedTransitioning>animator = [[PrivateAnimatedTransition alloc] init];
//    id<UIViewControllerAnimatedTransitioning>animator = [[SwipTransitionAnimator alloc] init];
    PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:fromViewController toViewController:viewController direction:DirectionLeft];
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL didComplete) {
//        [fromViewController beginAppearanceTransition:NO animated:YES];
//        [fromViewController.view removeFromSuperview];
//        [viewController beginAppearanceTransition:YES animated:YES];
//        [fromViewController endAppearanceTransition];
//
//        [self.utContainerView addSubview:viewController.view];
//        [viewController endAppearanceTransition];
//        [viewController didMoveToParentViewController:self];
    };
    [animator animateTransition:transitionContext];
    
   
    
   
 
    
    
    
}
- (void)popViewController:(UIViewController *)viewController
{
    NSInteger index = [self.childViewControllers indexOfObject:viewController];
    index = index >0 ?index-1 :index;
    UIViewController *toViewController = self.childViewControllers[index];
    

    id<UIViewControllerAnimatedTransitioning>animator = [[PrivateAnimatedTransition alloc] init];
    //    id<UIViewControllerAnimatedTransitioning>animator = [[SwipTransitionAnimator alloc] init];
    PrivateTransitionContext *transitionContext = [[PrivateTransitionContext alloc] initWithFromViewController:viewController toViewController:toViewController direction:DirectionRight];
    transitionContext.animated = YES;
    transitionContext.interactive = NO;
    transitionContext.completionBlock = ^(BOOL didComplete) {
        
//        [viewController willMoveToParentViewController:nil];
//        [viewController beginAppearanceTransition:NO animated:YES];
//        [viewController.view removeFromSuperview];
//        [viewController removeFromParentViewController];
//        [toViewController beginAppearanceTransition:YES animated:YES];
//        [viewController endAppearanceTransition];
//        [toViewController endAppearanceTransition];
    };
    [animator animateTransition:transitionContext];
 
  

}

- (void)ut_popViewController
{
    [self popViewController:self.childViewControllers.lastObject];
}

- (void)ut_popToViewController:(UIViewController *)viewController
{
    
    NSInteger index = [self.childViewControllers indexOfObject:viewController];
      NSInteger count = self.childViewControllers.count;
    [[[self.childViewControllers reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == count -index-1) {
            [self popViewController:self.childViewControllers.lastObject];
            *stop = YES;
        }
        else
        {
            if (idx==0) {

            }
            else
            {
                [obj willMoveToParentViewController:nil];
                [obj.view removeFromSuperview];
                [obj removeFromParentViewController];
            }
        }
    }];
    
  
    
}

- (void)ut_popToRootViewController
{
    UIViewController *vc = self.childViewControllers.firstObject;
    NSInteger index = [self.childViewControllers indexOfObject:vc];
    NSInteger count = self.childViewControllers.count;
    [[[self.childViewControllers reverseObjectEnumerator] allObjects] enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx == count -index-1) {
            [self popViewController:self.childViewControllers.lastObject];
            *stop = YES;
        }
        else
        {
            if (idx==0) {
               
            }
            else
            {
                [obj willMoveToParentViewController:nil];
                [obj.view removeFromSuperview];
                [obj removeFromParentViewController];
            }
           
        }
    }];
}

@end

#pragma mark - Private Transitioning Classes

@interface PrivateTransitionContext ()
@property (nonatomic, strong) NSDictionary *privateViewControllers;
@property (nonatomic, assign) CGRect privateDisappearingFromRect;
@property (nonatomic, assign) CGRect privateAppearingFromRect;
@property (nonatomic, assign) CGRect privateDisappearingToRect;
@property (nonatomic, assign) CGRect privateAppearingToRect;
@property (nonatomic, weak)   UIView *containerView;
@property (nonatomic, assign) UIModalPresentationStyle presentationStyle;
@end

@implementation  PrivateTransitionContext
- (instancetype)initWithFromViewController:(UIViewController *)fromViewController toViewController:(UIViewController *)toViewController direction:(Direction)direction
{
    NSAssert ([fromViewController isViewLoaded] && fromViewController.view.superview, @"The fromViewController view must reside in the container view upon initializing the transition context.");
    
    if ((self = [super init])) {
        self.presentationStyle = UIModalPresentationCustom;
        self.containerView = fromViewController.view.superview;
        self.privateViewControllers = @{
                                        UITransitionContextFromViewControllerKey:fromViewController,
                                        UITransitionContextToViewControllerKey:toViewController,
                                        };
        
      
        CGFloat travelDistance = (direction == DirectionLeft ? -self.containerView.bounds.size.width : self.containerView.bounds.size.width);
        self.privateDisappearingFromRect = self.privateAppearingToRect = self.containerView.bounds;
        self.privateDisappearingToRect = CGRectOffset (self.containerView.bounds, travelDistance, 0);
        self.privateAppearingFromRect = CGRectOffset (self.containerView.bounds, -travelDistance, 0);
    }
    
    return self;
}

- (CGRect)initialFrameForViewController:(UIViewController *)vc
{
    if (vc == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingFromRect;
    } else {
        return self.privateAppearingFromRect;
    }
}

- (CGRect)finalFrameForViewController:(UIViewController *)vc
{
    if (vc == [self viewControllerForKey:UITransitionContextFromViewControllerKey]) {
        return self.privateDisappearingToRect;
    } else {
        return self.privateAppearingToRect;
    }
}
- (UIViewController *)viewControllerForKey:(UITransitionContextViewControllerKey)key
{
    return self.privateViewControllers[key];
}

- (void)completeTransition:(BOOL)didComplete
{
    !self.completionBlock ?: self.completionBlock(didComplete);
}
- (BOOL)transitionWasCancelled
{
    return NO;
}
- (void)updateInteractiveTransition:(CGFloat)percentComplete {}
- (void)finishInteractiveTransition {}
- (void)cancelInteractiveTransition {}
@end

@implementation PrivateAnimatedTransition

static CGFloat const kChildViewPadding = 0;
//static CGFloat const kDamping = 0.75;
//static CGFloat const kInitialSpringVelocity = 0.5;

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

/// Slide views horizontally, with a bit of space between, while fading out and in.
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    // When sliding the views horizontally in and out, figure out whether we are going left or right.
    BOOL goingRight = ([transitionContext initialFrameForViewController:toViewController].origin.x < [transitionContext finalFrameForViewController:toViewController].origin.x);
    CGFloat travelDistance = [transitionContext containerView].bounds.size.width + kChildViewPadding;
    CGAffineTransform travel = CGAffineTransformMakeTranslation (goingRight ? travelDistance : -travelDistance, 0);
    if (!goingRight) {
        [fromViewController.parentViewController addChildViewController:toViewController];
        UIView *toView = toViewController.view;
        [toView setTranslatesAutoresizingMaskIntoConstraints:YES];
        toView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        toView.frame = [transitionContext containerView].bounds;
        
    }
    [[transitionContext containerView] addSubview:toViewController.view];
    toViewController.view.alpha = 0;
    toViewController.view.transform = CGAffineTransformInvert (travel);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromViewController.view.transform = travel;
        fromViewController.view.alpha = 0;
        toViewController.view.transform = CGAffineTransformIdentity;
        toViewController.view.alpha = 1;
    } completion:^(BOOL finished) {
        if (!goingRight) {
            fromViewController.view.transform = CGAffineTransformIdentity;
            [fromViewController beginAppearanceTransition:NO animated:YES];
            [fromViewController.view removeFromSuperview];
            [toViewController beginAppearanceTransition:YES animated:YES];
            [fromViewController endAppearanceTransition];
            [toViewController endAppearanceTransition];
            [toViewController didMoveToParentViewController:fromViewController.parentViewController];
        }
        else
        {
            [fromViewController willMoveToParentViewController:nil];
            [fromViewController beginAppearanceTransition:NO animated:YES];
            [fromViewController.view removeFromSuperview];
            [fromViewController removeFromParentViewController];
            [toViewController beginAppearanceTransition:YES animated:YES];
            [fromViewController endAppearanceTransition];
            [toViewController endAppearanceTransition];
        }
        
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}


@end
