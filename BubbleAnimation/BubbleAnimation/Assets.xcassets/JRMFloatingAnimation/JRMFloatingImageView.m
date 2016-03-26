//
//  JRMFloatingImageView.m
//  JRMFloatingAnimation
//
//  Created by Caroline Harrison on 2/23/16.
//  Copyright © 2016 Caroline Harrison. All rights reserved.
//

#import "JRMFloatingImageView.h"

@implementation JRMFloatingImageView

- (void)start {
    UIBezierPath *zigzagPath = [self makeZigZagPathWithShape:self.delegate.floatingShape];
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.delegate = self;
    pathAnimation.duration = self.delegate.animationDuration;
    pathAnimation.path = zigzagPath.CGPath;
    pathAnimation.calculationMode = kCAAnimationLinear;
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;
    [self.layer addAnimation:pathAnimation forKey:@"movingAnimation"];
    if (self.delegate.fadeOut) {
        [UIView animateWithDuration:self.delegate.animationDuration animations:^{
            [self setAlpha:0.0f];
        }];
    }
}

- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag {
    [UIView transitionWithView:self
                      duration:0.1f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        if (self.delegate.pop) {
                            self.transform = CGAffineTransformMakeScale(1.3, 1.3);    
                        }
                    } completion:^(BOOL finished) {
                        if (self.delegate.removeOnCompletion) {
                            [self removeFromSuperview];
                        }
                    }];
}

- (UIBezierPath *)makeZigZagPathWithShape:(JRMFloatingShape)floatingShape {
    switch (floatingShape) {
        case JRMFloatingShapeTriangleUp: {
            NSArray* methods = @[@"curveLeftPath", @"curveRightPath", @"straightPath"];
            NSString* method = [methods objectAtIndex:[self randomIndex:[methods count]]];
            // disable warning:"PerformSelector may cause a leak because its selector is unknown"
            #pragma clang diagnostic push
            #pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            return [self performSelector:NSSelectorFromString(method)];
            #pragma clang diagnostic pop
        } break;
        case JRMFloatingShapeCurveLeft: return [self curveLeftPath];
        case JRMFloatingShapeCurveRight: return [self curveRightPath];
        case JRMFloatingShapeStraight:
        default: {
            return [self straightPath];
        }
    }
}

#pragma mark - Bezier helper functions

- (UIBezierPath *)curveLeftPath {
    UIBezierPath *zigzagPath = [[UIBezierPath alloc] init];
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    [zigzagPath moveToPoint:CGPointMake(x, y)];
    CGFloat w = [self randomFloatBetween:50 and:self.delegate.animationWidth];
    CGFloat r = [self randomFloatBetween:self.delegate.minAnimationHeight and:self.delegate.maxAnimationHeight];
    CGPoint cp1 = CGPointMake(x, y - (.75*r));
    CGPoint cp2 = CGPointMake(x - w, y - (.25*r));
    NSArray *controlPoints = [self mixUpControlPoints1:cp1 and2:cp2];
    [zigzagPath addCurveToPoint:CGPointMake(x - w, y - r) controlPoint1:[[controlPoints objectAtIndex:0] CGPointValue] controlPoint2:[[controlPoints objectAtIndex:1] CGPointValue]];
    return zigzagPath;
}

- (UIBezierPath *)curveRightPath {
    UIBezierPath *zigzagPath = [[UIBezierPath alloc] init];
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    [zigzagPath moveToPoint:CGPointMake(x, y)];
    CGFloat r = [self randomFloatBetween:self.delegate.minAnimationHeight and:self.delegate.maxAnimationHeight];
    CGFloat w = [self randomFloatBetween:50 and:self.delegate.animationWidth];
    CGPoint cp1 = CGPointMake(x, y - (.75*r));
    CGPoint cp2 = CGPointMake(x + w, y - (.25*r));
    NSArray *controlPoints = [self mixUpControlPoints1:cp1 and2:cp2];
    [zigzagPath addCurveToPoint:CGPointMake(x + w, y - r) controlPoint1:[[controlPoints objectAtIndex:0] CGPointValue] controlPoint2:[[controlPoints objectAtIndex:1] CGPointValue]];
    return zigzagPath;
}

- (UIBezierPath *)straightPath {
    UIBezierPath *zigzagPath = [[UIBezierPath alloc] init];
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y;
    CGFloat r = [self randomFloatBetween:1 and:self.delegate.animationWidth];
    CGFloat h = [self randomFloatBetween:-self.delegate.minAnimationHeight and:-self.delegate.maxAnimationHeight];
    CGFloat ey = y + h + self.frame.size.height;
    CGPoint cp1 = CGPointMake(x - r, (y + ey) / 2);
    CGPoint cp2 = CGPointMake(x + r, cp1.y);
    NSArray *controlPoints = [self mixUpControlPoints1:cp1 and2:cp2];
    [zigzagPath moveToPoint:CGPointMake(x, y)];
    [zigzagPath addCurveToPoint:CGPointMake(x, ey) controlPoint1:[[controlPoints objectAtIndex:0] CGPointValue] controlPoint2:[[controlPoints objectAtIndex:1] CGPointValue]];
    return zigzagPath;
}

#pragma mark - Misc helper functions

- (NSArray *)mixUpControlPoints1:(CGPoint)p1 and2:(CGPoint)p2 {
    NSUInteger r = [self randomIndex:2];
    NSArray *controlPoints;
    if (r == 0) {
        controlPoints = @[
                          [NSValue valueWithCGPoint:p1],
                          [NSValue valueWithCGPoint:p2]
                          ];
    } else {
        controlPoints = @[
                          [NSValue valueWithCGPoint:p2],
                          [NSValue valueWithCGPoint:p1]
                          ];
    }
    return controlPoints;
}

- (NSUInteger)randomIndex:(NSUInteger)count {
    return arc4random() % count;
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}


@end
