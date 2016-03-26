//
//  ViewController.m
//  BubbleAnimationDemo
//
//  Created by 叶杨 on 16/3/26.
//  Copyright © 2016年 叶景天. All rights reserved.
//

#import "ViewController.h"

#import "BubbleImageView.h"

@interface ViewController ()

@property (nonatomic, assign)NSInteger bubbleNumber;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc]init];

    
    [gradientLayer setFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height / 2, self.view.bounds.size.width, self.view.bounds.size.height / 2)];
    gradientLayer.colors = @[(__bridge id)[UIColor whiteColor].CGColor,(__bridge id)[UIColor colorWithRed:0 green:0.5 blue:1 alpha:0.5].CGColor,(__bridge id)[UIColor blueColor].CGColor];
    [self.view.layer addSublayer:gradientLayer];
    
    
    self.bubbleNumber = 0;
  
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.bubbleNumber <= 30) {

       BubbleImageView *bubbleImageView = [[BubbleImageView alloc]initWithMaxHeight:self.view.bounds.size.height / 2.5 maxWidth: self.view.bounds.size.width / 1.5 maxFrame:CGRectMake([self makeRandomNumberFromMin:0 toMax:self.view.bounds.size.width], self.view.center.y, 50, 50) andSuperView:self.view];
        self.bubbleNumber++;
    }
    
}

- (CGFloat)makeRandomNumberFromMin:(CGFloat)min toMax: (CGFloat)max
{
    NSInteger precision = 100;
    
    CGFloat subtraction = ABS(max - min);
    
    subtraction *= precision;
    
    CGFloat randomNumber = arc4random() % ((int)subtraction+1);
    
    randomNumber /= precision;
    
    randomNumber += min;
    
    //返回结果
    return randomNumber;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
