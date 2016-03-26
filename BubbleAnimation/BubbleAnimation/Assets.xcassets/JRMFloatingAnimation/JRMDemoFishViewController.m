//
//  JRMDemoFishViewController.m
//  JRMFloatingAnimation
//
//  Created by Caroline on 2/23/16.
//  Copyright © 2016 Caroline Harrison. All rights reserved.
//

//  Ocean background and chest by Freepik.com

#import "JRMDemoFishViewController.h"
#import "JRMFloatingAnimationView.h"

@interface JRMDemoFishViewController()

@property (strong, nonatomic) UIImageView *treasureChestImageView;
@property (strong, nonatomic) JRMFloatingAnimationView *floatingView;

@property (strong, nonatomic) CAShapeLayer *startingPointWidthLine;
@property BOOL showingStartingPointWidthLine;

@property (strong, nonatomic) CAShapeLayer *maxAnimationHeightLine;
@property BOOL showingMaxAnimationHeightLine;

@property (strong, nonatomic) CAShapeLayer *minAnimationHeightLine;
@property BOOL showingMinAnimationHeightLine;

@end

@implementation JRMDemoFishViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createTreasureChest];
    [self createFloatingAnimation];
    [self createLines];
}

- (void)createTreasureChest {
    self.treasureChestImageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2 - 150, self.view.frame.size.height - 200, 200, 170)];
    self.treasureChestImageView.image = [UIImage imageNamed:@"Treasure"];
    [self.view addSubview:self.treasureChestImageView];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chestTouched)];
    singleTap.numberOfTapsRequired = 1;
    [self.treasureChestImageView setUserInteractionEnabled:YES];
    [self.treasureChestImageView addGestureRecognizer:singleTap];
}

- (void)createFloatingAnimation {

    CGFloat x = (self.treasureChestImageView.frame.origin.x + self.treasureChestImageView.frame.size.width + 100) / 2;
    
    self.floatingView = [[JRMFloatingAnimationView alloc] initWithStartingPoint:CGPointMake(x, self.treasureChestImageView.frame.origin.y + 50)];
    self.floatingView.startingPointWidth = self.treasureChestImageView.frame.size.width - 100;
    self.floatingView.animationWidth = 50;
    self.floatingView.pop = YES;
    self.floatingView.varyAlpha = YES;
    self.floatingView.maxFloatObjectSize = 30;
    self.floatingView.minFloatObjectSize = 5;
    
    self.floatingView.maxAnimationHeight = 200;
    self.floatingView.minAnimationHeight = 100;
    
    UIImage *bubble = [UIImage imageNamed:@"bubble"];
    [self.floatingView addImage:bubble];
    
    [self.view addSubview:self.floatingView];
}

- (void)createLines {
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:CGPointMake(self.floatingView.startingPoint.x - self.floatingView.startingPointWidth / 2, self.floatingView.startingPoint.y)];
    [path addLineToPoint:CGPointMake(self.floatingView.startingPoint.x + self.floatingView.startingPointWidth / 2, self.floatingView.startingPoint.y)];
    
    self.startingPointWidthLine = [CAShapeLayer layer];
    self.startingPointWidthLine.path = [path CGPath];
    self.startingPointWidthLine.strokeColor = [[UIColor blueColor] CGColor];
    self.startingPointWidthLine.lineWidth = 3.0;
    self.startingPointWidthLine.fillColor = [[UIColor clearColor] CGColor];
    
    UIBezierPath *maxHeightPath = [UIBezierPath bezierPath];
    [maxHeightPath moveToPoint:CGPointMake(self.floatingView.startingPoint.x, self.floatingView.startingPoint.y)];
    [maxHeightPath addLineToPoint:CGPointMake(self.floatingView.startingPoint.x, self.floatingView.startingPoint.y - self.floatingView.maxAnimationHeight)];
    
    self.maxAnimationHeightLine = [CAShapeLayer layer];
    self.maxAnimationHeightLine.path = [maxHeightPath CGPath];
    self.maxAnimationHeightLine.strokeColor = [[UIColor redColor] CGColor];
    self.maxAnimationHeightLine.lineWidth = 3.0;
    self.maxAnimationHeightLine.fillColor = [[UIColor clearColor] CGColor];
    
    
    UIBezierPath *minHeightPath = [UIBezierPath bezierPath];
    [minHeightPath moveToPoint:CGPointMake(self.floatingView.startingPoint.x - 10, self.floatingView.startingPoint.y)];
    [minHeightPath addLineToPoint:CGPointMake(self.floatingView.startingPoint.x - 10, self.floatingView.startingPoint.y - self.floatingView.minAnimationHeight)];
    
    self.minAnimationHeightLine = [CAShapeLayer layer];
    self.minAnimationHeightLine.path = [minHeightPath CGPath];
    self.minAnimationHeightLine.strokeColor = [[UIColor purpleColor] CGColor];
    self.minAnimationHeightLine.lineWidth = 3.0;
    self.minAnimationHeightLine.fillColor = [[UIColor clearColor] CGColor];
}

- (void)chestTouched {
    [self.floatingView animate];
}

- (IBAction)startingPointWidthButton:(id)sender {
    if (self.showingStartingPointWidthLine) {
        [self.startingPointWidthLine removeFromSuperlayer];
        self.showingStartingPointWidthLine = NO;
    } else {
        [self.view.layer addSublayer:self.startingPointWidthLine];
        self.showingStartingPointWidthLine = YES;
    }
}

- (IBAction)popValueChanged:(UISwitch *)sender {
    if (sender.on) {
        self.floatingView.pop = YES;
    } else {
        self.floatingView.pop = NO;
    }
}

- (IBAction)maxSizeSliderChanged:(UISlider *)sender {
    self.floatingView.maxFloatObjectSize = sender.value;
}

- (IBAction)minSizeSliderChanged:(UISlider *)sender {
    self.floatingView.minFloatObjectSize = sender.value;
}

- (IBAction)varyAlphaValueChanged:(UISwitch *)sender {
    if (sender.on) {
        self.floatingView.varyAlpha = YES;
    } else {
        self.floatingView.varyAlpha = NO;
    }
}
- (IBAction)maxAnimationHeightButtonPressed:(id)sender {
    if (self.showingMaxAnimationHeightLine) {
        [self.maxAnimationHeightLine removeFromSuperlayer];
        self.showingMaxAnimationHeightLine = NO;
    } else {
        [self.view.layer addSublayer:self.maxAnimationHeightLine];
        self.showingMaxAnimationHeightLine = YES;
    }
}

- (IBAction)minAnimationHeightButton:(id)sender {
    if (self.showingMinAnimationHeightLine) {
        [self.minAnimationHeightLine removeFromSuperlayer];
        self.showingMinAnimationHeightLine = NO;
    } else {
        [self.view.layer addSublayer:self.minAnimationHeightLine];
        self.showingMinAnimationHeightLine = YES;
    }
}

@end
