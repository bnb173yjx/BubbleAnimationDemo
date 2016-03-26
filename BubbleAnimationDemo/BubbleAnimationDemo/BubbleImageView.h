//
//  BubbleImageView.h
//  BubbleAnimationDemo
//
//  Created by 叶杨 on 16/3/26.
//  Copyright © 2016年 叶景天. All rights reserved.
//

#import <UIKit/UIKit.h>


//UIButtonType
typedef  NS_ENUM(NSInteger, BubblePathType) {
    BubblePathTypeLeft = 0,     //贝塞尔曲线,先向左弯曲;
    BubblePathTypeRight,   //贝塞尔曲线,先向右弯曲;
};




@interface BubbleImageView : UIImageView

- (instancetype)initWithMaxHeight:(CGFloat) maxHeight maxWidth: (CGFloat)maxWidth maxFrame:(CGRect)frame andSuperView: (UIView *)superView;


@end
