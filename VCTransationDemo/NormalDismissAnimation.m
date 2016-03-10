//
//  NormalDismissAnimation.m
//  VCTransitionDemo
//
//  Created by 王 巍 on 13-10-13.
//  Copyright (c) 2013年 王 巍. All rights reserved.
//

#import "NormalDismissAnimation.h"
#import <UIKit/UIScreen.h>
#import "MainViewController.h"
@implementation NormalDismissAnimation
- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4f;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    id<UIViewControllerContextTransitioning> transitionContext = [anim valueForKey:@"transitionContext"];
    [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    if ([transitionContext transitionWasCancelled]) {
        [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view.layer.mask = nil;
        
    }
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 1. Get controllers from transition context
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    
//    // 2. Set init frame for fromVC
//    CGRect screenBounds = [[UIScreen mainScreen] bounds];
//    CGRect initFrame = [transitionContext initialFrameForViewController:fromVC];
//    CGRect finalFrame = CGRectOffset(initFrame, 0, screenBounds.size.height);
//    
//    // 3. Add target view to the container, and move it to back.
//    UIView *containerView = [transitionContext containerView];
//    [containerView addSubview:toVC.view];
//    [containerView sendSubviewToBack:toVC.view];
//
//    // 4. Do animate now
//    NSTimeInterval duration = [self transitionDuration:transitionContext];
//    [UIView animateWithDuration:duration animations:^{
//        fromVC.view.frame = finalFrame;
//    } completion:^(BOOL finished) {
//        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
//    }];
    
//    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
//    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
//    //参照present动画的逻辑，present成功后，containerView的最后一个子视图就是截图视图，我们将其取出准备动画
//    UIView *tempView = [transitionContext containerView].subviews[0];
//    //动画吧
//    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
//        //因为present的时候都是使用的transform，这里的动画只需要将transform恢复就可以了
//        fromVC.view.transform = CGAffineTransformIdentity;
//        tempView.transform = CGAffineTransformIdentity;
//    } completion:^(BOOL finished) {
//        if ([transitionContext transitionWasCancelled]) {
//            //失败了标记失败
//            [transitionContext completeTransition:NO];
//        }else{
//            //如果成功了，我们需要标记成功，同时让vc1显示出来，然后移除截图视图，
//            [transitionContext completeTransition:YES];
//            toVC.view.hidden = NO;
//            [tempView removeFromSuperview];
//        }
//    }];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    MainViewController *temp =(MainViewController*)toVC;
    UIView *containerView = [transitionContext containerView];
    //画两个圆路径
    CGFloat radius = sqrtf(containerView.frame.size.height * containerView.frame.size.height + containerView.frame.size.width * containerView.frame.size.width) / 2;
    UIBezierPath *startCycle = [UIBezierPath bezierPathWithArcCenter:containerView.center radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    UIBezierPath *endCycle =  [UIBezierPath bezierPathWithOvalInRect:temp.abutton.frame];
    //创建CAShapeLayer进行遮盖
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.fillColor = [UIColor greenColor].CGColor;
    maskLayer.path = endCycle.CGPath;
    fromVC.view.layer.mask = maskLayer;
    //创建路径动画
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.fromValue = (__bridge id)(startCycle.CGPath);
    maskLayerAnimation.toValue = (__bridge id)((endCycle.CGPath));
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];
    maskLayerAnimation.delegate = self;
    maskLayerAnimation.timingFunction = [CAMediaTimingFunction  functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [maskLayerAnimation setValue:transitionContext forKey:@"transitionContext"];
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
}

@end
