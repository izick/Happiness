//
//  FaceView.m
//  Happiness
//
//  Created by Tony Scarpino on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FaceView.h"

@interface FaceView()
@end

@implementation FaceView

@synthesize scale = _scale;
@synthesize smile = _smile;
@synthesize dataSource;

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    [self setNeedsDisplay];
}

- (void)setSmile:(CGFloat)happiness
{
    self.smile = (happiness - 50) / 50.0;
}

- (void)setup
{
    self.contentMode = UIViewContentModeRedraw;
    self.scale = 0.95;
}

- (void)awakeFromNib
{
    [self setup]; // get initialized when we come out of a storyboard
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
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
        radius = (self.bounds.size.width / 2.0);
    } else {
        radius = (self.bounds.size.height / 2.0);
    }
    
    radius *= self.scale;
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midpoint radius:radius inContext:context];
    
    //Eyes
#define EYES_X 0.35
#define EYES_Y 0.35
#define EYES_RADIUS 0.10
    CGPoint eyes = midpoint;
    eyes.x -= radius * EYES_X;
    eyes.y -= radius * EYES_Y;
    
    [self drawCircleAtPoint:eyes radius:radius * EYES_RADIUS inContext:context];
    eyes.x += (radius * 2 * EYES_X);
    [self drawCircleAtPoint:eyes radius:radius * EYES_RADIUS inContext:context];
    
    //Mouth
#define MOUTH_X 0.45
#define MOUTH_Y 0.4
    
    CGPoint start, end;
    start.x = midpoint.x - radius * MOUTH_X;
    start.y = midpoint.y + radius * MOUTH_Y;
    end.x = midpoint.x + radius * MOUTH_X;
    end.y = start.y;
    
    CGPoint center1 = start, center2 = end;
    center1.y += ((radius / 3) * [self.dataSource smileForFaceView:self]);
    center2.y = center1.y;
    center1.x += radius * MOUTH_X * (2/3);
    center2.x -= radius * MOUTH_X * (2/3);
    
    UIGraphicsPushContext(context);
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, start.x, start.y);
    CGContextAddCurveToPoint(context, center1.x, center1.y, center2.x, center2.y, end.x, end.y);
    CGContextStrokePath(context);
    UIGraphicsPopContext();
}

- (void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        self.scale *= gesture.scale;
        gesture.scale = 1;
    }
        
}

@end
