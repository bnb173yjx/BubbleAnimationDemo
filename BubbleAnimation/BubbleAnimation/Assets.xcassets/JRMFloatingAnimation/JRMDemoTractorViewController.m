//
//  JRMDemoTractorViewController.m
//  JRMFloatingAnimation
//
//  Created by Caroline on 2/26/16.
//  Copyright © 2016 Caroline Harrison. All rights reserved.
//

//  Images from Freepik.com

#import "JRMDemoTractorViewController.h"
#import "JRMFloatingAnimationView.h"

@interface JRMDemoTractorViewController()

@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;
@property (strong, nonatomic) UIImageView *tractorImageView;

@end

@implementation JRMDemoTractorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTractor];
    
    [self createFloatingAnimation];
    
    [NSTimer scheduledTimerWithTimeInterval:.2
                                     target:self
                                   selector:@selector(puff)
                                   userInfo:nil
                                    repeats:YES];
    
    
    [self runTractor];
}

- (void)createTractor {
    self.tractorImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width, self.view.center.y, 80, 80)];
    self.tractorImageView.image = [UIImage imageNamed:@"tractor"];
    [self.view addSubview:self.tractorImageView];
    
}

- (void)runTractor {
    [UIView animateWithDuration:5 animations:^{
        self.tractorImageView.frame = CGRectMake(-80, self.view.center.y, 80, 80);
    } completion:^(BOOL finished) {
        self.tractorImageView.frame = CGRectMake(self.view.frame.size.width, self.view.center.y, 80, 80);
        [self runTractor];
    }];
}

- (void)createFloatingAnimation {
    self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:[self startingPoint]];
    self.floatingView.animationWidth = 20;
    self.floatingView.maxAnimationHeight = 80;
    self.floatingView.floatingShape = JRMFloatingShapeCurveRight;
    self.floatingView.varyAlpha = YES;
    self.floatingView.fadeOut = YES;
    self.floatingView.maxFloatObjectSize = 30;
    self.floatingView.minFloatObjectSize = 5;
    [self.floatingView addImage:[UIImage imageNamed:@"dustcloud"]];
    [self.view addSubview:self.floatingView];
}

- (void)puff {
    self.floatingView.startingPoint = [self startingPoint];
    [self.floatingView animate];
}

- (CGPoint)startingPoint {
    CGPoint origin = [self.tractorImageView.layer.presentationLayer frame].origin;
    return CGPointMake(origin.x + 40, origin.y + 20);
}

@end
