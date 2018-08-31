//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by TF14975 on 2018/8/31.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@implementation CTDisplayView

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    NSLog(@"%@",NSStringFromCGRect(rect));
    NSLog(@"%@",NSStringFromCGRect(self.bounds));
    
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    // 步骤 3
    CGMutablePathRef drawingpath = CGPathCreateMutable();
    CGPathAddRect(drawingpath, NULL, self.bounds);
//    CGPathAddEllipseInRect(drawingpath, NULL, self.bounds);
    
    //draw path
    [[UIColor blackColor] setStroke];
    CGContextSetLineWidth(context, 1/[UIScreen mainScreen].scale);
    CGContextAddPath(context, drawingpath);
    CGContextDrawPath(context, kCGPathStroke);
    
    // 步骤 4 
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World! "];
    
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), drawingpath, NULL);
    // 步骤 5
    CTFrameDraw(frame, context);
    // 步骤 6
    CFRelease(frame);
    CFRelease(drawingpath);
    CFRelease(framesetter);
}

@end
