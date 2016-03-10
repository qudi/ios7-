//
//  ModelViewController.m
//  VCTransationDemo
//
//  Created by quyanhuiqu on 16/3/10.
//  Copyright © 2016年 quyanhuiqu. All rights reserved.
//

#import "ModelViewController.h"

@implementation ModelViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button setTitle:@"Dismiss me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(asdbut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)asdbut
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissButton:)]) {
        [self.delegate modalViewControllerDidClickedDismissButton:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
