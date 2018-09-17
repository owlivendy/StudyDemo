//
//  CTDisplayView.m
//  CoreTextDemo
//
//  Created by TF14975 on 2018/8/31.
//  Copyright © 2018年 TF14975. All rights reserved.
//

#import "CTDisplayView.h"
#import <CoreText/CoreText.h>

@interface CTDisplayView()
{
    CTFrameRef _ctframe;
}
@end

@implementation CTDisplayView

- (void)dealloc
{
    CFRelease(_ctframe);
}

//core text draw
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤 2
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
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
    CFRetain(frame);
    _ctframe = frame;
    
    ///get CTLine array
    CFArrayRef ctlines = CTFrameGetLines(frame);
    CFIndex linesCount = CFArrayGetCount(ctlines);
    CGPoint lineOfOrigins[linesCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), lineOfOrigins);
    for (int i = 0; i < linesCount; i++) {
        CTLineRef line = CFArrayGetValueAtIndex(ctlines, i);
        CGPoint lineofOrigin = lineOfOrigins[i];
        NSLog(@"%@",NSStringFromCGPoint(lineofOrigin));
        //绘制
        CGContextSetTextPosition(context, lineofOrigin.x, lineofOrigin.y);
//        CTLineDraw(line, context);
        [self drawline:line context:context lineofOrigin:lineofOrigin];
    }
    
    // 步骤 5
//    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(drawingpath);
    CFRelease(framesetter);
}

- (void)drawline:(CTLineRef)line context:(CGContextRef)context lineofOrigin:(CGPoint)lineofOrigin {
    CFArrayRef runs = CTLineGetGlyphRuns(line);
    CFIndex runCount = CFArrayGetCount(runs);
    
//    ctrunget
    for (int i = 0; i < runCount; i++) {
        CTRunRef run = CFArrayGetValueAtIndex(runs, i);
        //draw
        CTRunDraw(run, context, CFRangeMake(0, 0));
        
        //add img icon
        NSDictionary *runAttributes = (NSDictionary *)CTRunGetAttributes(run);
        CTRunDelegateRef delegate = (__bridge CTRunDelegateRef)[runAttributes valueForKey:(id)kCTRunDelegateAttributeName];
        if (delegate == nil) {
            continue;
        }
        NSDictionary * metaDic = CTRunDelegateGetRefCon(delegate);
        if (![metaDic isKindOfClass:[NSDictionary class]]) {
            continue;
        }
        CGRect runBounds;
        CGFloat ascent;
        CGFloat descent;
        runBounds.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0, 0), &ascent, &descent, NULL);
        runBounds.size.height = ascent + descent;
        CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL);
        runBounds.origin.x = lineofOrigin.x + xOffset;
        runBounds.origin.y = lineofOrigin.y;
        
        UIImage *appadd = [UIImage imageNamed:@"app_add"];
        NSLog(@"%@",NSStringFromCGRect(runBounds));
        CGContextDrawImage(context, runBounds, appadd.CGImage);
    }
}

@end

