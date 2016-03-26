//
//  JRMDemoBalloonViewController.m
//  JRMFloatingAnimation
//
//  Created by Caroline Harrison on 3/1/16.
//  Copyright © 2016 Caroline Harrison. All rights reserved.
//
//  Balloon image by Freepik.com



#import "JRMDemoBalloonViewController.h"
#import "JRMFloatingAnimationView.h"

@interface JRMDemoBalloonViewController()

@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;

@end

@implementation JRMDemoBalloonViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createFloatingAnimation];
}

- (void)createFloatingAnimation {
    self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:CGPointMake(self.view.frame.size.width / 2, self.view.frame.size.height + 100)];
    self.floatingView.startingPointWidth = self.view.frame.size.width;
    self.floatingView.animationWidth = 100;
    self.floatingView.maxFloatObjectSize = 100;
    self.floatingView.minFloatObjectSize = 100;
    self.floatingView.animationDuration = 5;
    self.floatingView.maxAnimationHeight = self.floatingView.maxAnimationHeight - 64;
    self.floatingView.minAnimationHeight = self.floatingView.maxAnimationHeight;
    self.floatingView.removeOnCompletion = NO;
    
    [self.floatingView addImage:[UIImage imageNamed:@"balloon1"]];
    
    [self.view addSubview:self.floatingView];
    
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(animate) userInfo:nil repeats:YES];
}

- (void)animate {
    [self.floatingView animate];
}

@end
