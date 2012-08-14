//
//  FaceView.m
//  Happiness
//
//  Created by Tony Scarpino on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@implementation FaceView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawCircleAtPoint:(CGPoint)pt radius:(CGFloat)radius inContext:(CGContextRef)context
{
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextAddArc(context, pt.x, pt.y, radius, 0, 2*M_PI, NO);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint midpoint;
    CGFloat radius;
    
    midpoint.x = self.bounds.size.width / 2;
    midpoint.y = self.bounds.size.height / 2;

    // Size of Circle
    if (self.bounds.size.height > self.bounds.size.width) {
        radius = (self.bounds.size.width / 2.0) - 5;
    } else {
        radius = (self.bounds.size.height / 2.0) - 5;
    }
    
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midpoint radius:radius inContext:context];
}


@end
