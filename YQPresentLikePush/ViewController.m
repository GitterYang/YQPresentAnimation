//
//  ViewController.m
//  YQPresentLikePush
//
//  Created by 杨麒 on 16/8/13.
//  Copyright © 2016年 杨麒. All rights reserved.
//

#import "ViewController.h"
#import "YQPushViewController.h"
#import "YQPresentViewController.h"
#import "YQDismissTransitionAnimated.h"

#import "YQPresentTransitionAnimated.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

- (IBAction)pushAction:(id)sender;
- (IBAction)presentAction:(id)sender;
- (IBAction)systemPresentAction:(id)sender;

@property (nonatomic, retain) UIPercentDrivenInteractiveTransition * percentDrivenTransition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.transitioningDelegate = self;
}


#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return [[YQPresentTransitionAnimated alloc] init];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[YQDismissTransitionAnimated alloc] init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
    return _percentDrivenTransition;
}

#pragma mark - 按钮事件
- (IBAction)pushAction:(id)sender {
    YQPushViewController *pushVC = [YQPushViewController new];
    [self.navigationController pushViewController:pushVC animated:YES];
}

- (IBAction)presentAction:(id)sender {
    YQPresentViewController *presentVC = [YQPresentViewController new];
    UINavigationController *presentNav = [[UINavigationController alloc] initWithRootViewController:presentVC];
    presentNav.transitioningDelegate = self;
    [self addScreenLeftEdgePanGestureRecognizer:presentVC.view];
    
    [self presentViewController:presentNav animated:YES completion:nil];
}

- (IBAction)systemPresentAction:(id)sender {
    YQPresentViewController *presentVC = [YQPresentViewController new];
    UINavigationController *presentNav = [[UINavigationController alloc] initWithRootViewController:presentVC];
    [self presentViewController:presentNav animated:YES completion:nil];
}

#pragma mark - 添加手势的方法
- (void)addScreenLeftEdgePanGestureRecognizer:(UIView *)view {
    UIScreenEdgePanGestureRecognizer * edgePan = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(edgePanGesture:)]; //手势由self来管理
    edgePan.edges = UIRectEdgeLeft;
    [view addGestureRecognizer:edgePan];
}

#pragma mark - 手势的监听方法
- (void)edgePanGesture:(UIScreenEdgePanGestureRecognizer *)edgePan{
    CGFloat progress = fabs([edgePan translationInView:[UIApplication sharedApplication].keyWindow].x / [UIApplication sharedApplication].keyWindow.bounds.size.width);
    
    if(edgePan.state == UIGestureRecognizerStateBegan){
        self.percentDrivenTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        if(edgePan.edges == UIRectEdgeLeft){
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        }
    }else if(edgePan.state == UIGestureRecognizerStateChanged){
        [self.percentDrivenTransition updateInteractiveTransition:progress];
    }else if(edgePan.state == UIGestureRecognizerStateCancelled || edgePan.state == UIGestureRecognizerStateEnded){
        if(progress > 0.5){
            [_percentDrivenTransition finishInteractiveTransition];
        }else{
            [_percentDrivenTransition cancelInteractiveTransition];
        }
        _percentDrivenTransition = nil;
    }
}

@end
