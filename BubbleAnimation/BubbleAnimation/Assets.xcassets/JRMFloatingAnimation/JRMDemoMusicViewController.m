//
//  JRMDemoMusicViewController.m
//  JRMFloatingAnimation
//
//  Created by Caroline on 2/25/16.
//  Copyright © 2016 Caroline Harrison. All rights reserved.
//
//  Music notes and sax by by Freepik.com

#import "JRMDemoMusicViewController.h"
#import "JRMFloatingAnimationView.h"

@interface JRMDemoMusicViewController()

@property (strong, nonatomic) UIImageView *saxImageView;
@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;

@end

@implementation JRMDemoMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createInstrument];
    [self createFloatingAnimation];
}

- (void)createInstrument {
    self.saxImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.center.x - 150, self.view.center.y + 100, 200, 200)];
    self.saxImageView.image = [UIImage imageNamed:@"sax"];
    [self.view addSubview:self.saxImageView];
}

- (void)createFloatingAnimation {
    self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:CGPointMake(self.saxImageView.center.x + 55, self.saxImageView.center.y - 20)];
    self.floatingView.fadeOut = YES;
    self.floatingView.varyAlpha = YES;
    [self.floatingView addImage:[UIImage imageNamed:@"note1"]];
    [self.floatingView addImage:[UIImage imageNamed:@"note2"]];
    [self.floatingView addImage:[UIImage imageNamed:@"note3"]];
    [self.view addSubview:self.floatingView];
}

- (IBAction)straightButton:(id)sender {
    self.floatingView.floatingShape = JRMFloatingShapeStraight;
    [self.floatingView animate];
}

- (IBAction)curveRightButton:(id)sender {
    self.floatingView.floatingShape = JRMFloatingShapeCurveRight;
    [self.floatingView animate];
}

- (IBAction)triangleButton:(id)sender {
    self.floatingView.floatingShape = JRMFloatingShapeTriangleUp;
    [self.floatingView animate];
}

- (IBAction)curveLeftButton:(id)sender {
    self.floatingView.floatingShape = JRMFloatingShapeCurveLeft;
    [self.floatingView animate];
}

- (IBAction)fadeOutSwitched:(UISwitch *)sender {
    if (sender.on) {
        self.floatingView.fadeOut = YES;
    } else {
        self.floatingView.fadeOut = NO;
    }
}


@end
