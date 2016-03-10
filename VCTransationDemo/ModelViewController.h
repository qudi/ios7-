//
//  ModelViewController.h
//  VCTransationDemo
//
//  Created by quyanhuiqu on 16/3/10.
//  Copyright © 2016年 quyanhuiqu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ModalViewController;
@protocol ModalViewControllerDelegate <NSObject>

-(void) modalViewControllerDidClickedDismissButton:(ModalViewController *)viewController;

@end
@interface ModelViewController : UIViewController
@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@property (nonatomic,strong) UIButton *cbutton;

@end
