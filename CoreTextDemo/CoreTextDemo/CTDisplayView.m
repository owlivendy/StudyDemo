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

//core text draw
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
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
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:@"Hello World! "];
    
    
    //create framesetter
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self.attributeText);
    
    //get frame
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [self.attributeText length]), drawingpath, NULL);
    
    ///get CTLine array
    CFArrayRef ctlines = CTFrameGetLines(frame);
    CFIndex linesCount = CFArrayGetCount(ctlines);
    CGPoint lineOfOrigins[linesCount];
//    CGPoint *a = &lineOfOrigins;
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOfOrigins);
    for (int i = 0; i < linesCount; i++) {
        CTLineRef line = CFArrayGetValueAtIndex(ctlines, i);
        CGPoint lineofOrigin = lineOfOrigins[i];
        NSLog(@"%@",NSStringFromCGPoint(lineofOrigin));
        //绘制
        CGContextSetTextPosition(context, lineofOrigin.x, lineofOrigin.y);
//        CTLineDraw(line, context);
        [self drawline:line context:context];
    }
    
    // 步骤 5
//    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(drawingpath);
    CFRelease(framesetter);
}

- (void)drawline:(CTLineRef)line context:(CGContextRef)context {
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runs);
    
//    ctrunget
    for (int i = 0; i < runCount; i++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, i);
        CFRange range = CTRunGetStringRange(run);
//        ctrungetgl
        NSLog(@"range:%ld,%ld",range.location,range.length);
//        CGContextSetTextPosition(context, lineofOrigin.x, lineofOrigin.y);
        CTRunDraw(run, context, CFRangeMake(0, 0));
    }
}

@end

