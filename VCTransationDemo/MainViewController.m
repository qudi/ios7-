//
//  MainViewController.m
//  VCTransationDemo
//
//  Created by quyanhuiqu on 16/3/10.
//  Copyright © 2016年 quyanhuiqu. All rights reserved.
//

#import "MainViewController.h"
#import "ModelViewController.h"
#import "BouncePresentAnimation.h"
#import "NormalDismissAnimation.h"
@interface MainViewController ()<UIViewControllerTransitioningDelegate,ModalViewControllerDelegate>
@property (nonatomic,strong)BouncePresentAnimation *presntAnimation;
@property (nonatomic,strong)NormalDismissAnimation *dismissAnimation;
@end

@implementation MainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _presntAnimation = [BouncePresentAnimation new];
    _dismissAnimation = [NormalDismissAnimation new];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    self.abutton = button;
}


-(void) buttonClicked:(id)sender
{
    ModelViewController *mvc =  [[ModelViewController alloc] init];
    mvc.transitioningDelegate = self;
    mvc.delegate = self;
    [self presentViewController:mvc animated:YES completion:nil];
}

-(void)modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return self.presntAnimation;
}

-(id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return self.dismissAnimation;
}

@end
