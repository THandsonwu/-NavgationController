//
//  SwipTransitionAnimator.m
//  UTTestDemo
//
//  Created by tanzhiwu on 2017/12/29.
//  Copyright © 2017年 tanzhiwu. All rights reserved.
//

#import "SwipTransitionAnimator.h"

@implementation SwipTransitionAnimator

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *containerView = transitionContext.containerView;
    
    UIView *fromView;
    UIView *toView;
    
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromViewController.view;
        toView = toViewController.view;
    }
    //重力方向，转场时偏移方向
    CGVector offset;
//    BOOL isPresenting = (toViewController.presentingViewController == fromViewController);
    BOOL isPresenting = ([transitionContext initialFrameForViewController:toViewController].origin.x > [transitionContext finalFrameForViewController:toViewController].origin.x);
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    if (isPresenting) {
        offset = CGVectorMake(-1.f, 0.f);
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width * offset.dx * -1,
                                    toFrame.size.height * offset.dy * -1);
    }
    else
    {
        offset = CGVectorMake(1.f, 0.f);
        fromView.frame = fromFrame;
        toView.frame = toFrame;
    }
    
    if (isPresenting) {
        [containerView addSubview:toView];
    }
    else
    {
         [containerView insertSubview:toView belowSubview:fromView];
    }
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        if (isPresenting) {
            toView.frame = toFrame;
        }
        else
        {
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width * offset.dx,
                                          fromFrame.size.height * offset.dy);
        }
       
       
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        if (wasCancelled)
        {
            [toView removeFromSuperview];
        }
        [transitionContext completeTransition:!wasCancelled];
    }];
    
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

@end
