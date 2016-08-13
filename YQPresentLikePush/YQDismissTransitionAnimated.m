//
//  YQDismissTransitionAnimated.m
//  YQPresentLikePush
//
//  Created by 杨麒 on 16/8/13.
//  Copyright © 2016年 杨麒. All rights reserved.
//

#import "YQDismissTransitionAnimated.h"

@implementation YQDismissTransitionAnimated

//动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.4;
}

//动画特效
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
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
    
    //给fromView加一个阴影
    fromView.layer.masksToBounds = NO;
    fromView.layer.shadowOffset = CGSizeMake(-3, 3);
    fromView.layer.shadowOpacity = 0.5;
    fromView.layer.shadowPath = [UIBezierPath bezierPathWithRect:fromView.bounds].CGPath;
    
    BOOL isDismissing = (fromViewController.presentingViewController == toViewController);
    
    CGRect fromFrame = [transitionContext initialFrameForViewController:fromViewController];
    CGRect toFrame = [transitionContext finalFrameForViewController:toViewController];
    
    if (isDismissing) {
        fromView.frame = fromFrame;
        toView.frame = CGRectOffset(toFrame, toFrame.size.width * 0.3 * -1, 0);
    }
    
    if (isDismissing) {
        [containerView insertSubview:toView belowSubview:fromView];
    }
    
    NSTimeInterval transitionDuration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:transitionDuration animations:^{
        if (isDismissing) {
            toView.frame = toFrame;
            fromView.frame = CGRectOffset(fromFrame, fromFrame.size.width, 0);
        }
    } completion:^(BOOL finished) {
        BOOL wasCancelled = [transitionContext transitionWasCancelled];
        
        if (wasCancelled)
            [toView removeFromSuperview];
        
        [transitionContext completeTransition:!wasCancelled];
    }];
}

@end
