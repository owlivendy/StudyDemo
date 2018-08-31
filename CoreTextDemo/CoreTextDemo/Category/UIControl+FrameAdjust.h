//
//  UIControl+FrameAdjust.h
//  CoreTextDemo
//
//  Created by TF14975 on 2018/8/31.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (FrameAdjust)

- (CGFloat)x;
- (void)setX:(CGFloat)x;
- (CGFloat)y;
- (void)setY:(CGFloat)y;
- (CGFloat)height;
- (void)setHeight:(CGFloat)height;
- (CGFloat)width;
- (void)setWidth:(CGFloat)width;

@end
