//
//  HappinessViewController.m
//  Happiness
//
//  Created by Tony Scarpino on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController() <FaceViewDataSource>

@property (nonatomic, weak) IBOutlet FaceView *faceview;
@end

@implementation HappinessViewController
@synthesize faceview = _faceview;
@synthesize happiness = _happiness;

- (void)setHappiness:(int)happiness
{
    if (happiness < 0)
        happiness = 0;
    else if (happiness > 100)
        happiness = 100;
    
    _happiness = happiness;
    [self.faceview setNeedsDisplay];
}


- (void)setFaceview:(FaceView *)faceview
{
    _faceview = faceview;
    self.faceview.dataSource = self;
    [self.faceview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceview action:@selector(pinch:)]];
    [self.faceview addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(smile:)]];
}


- (float)smileForFaceView:(FaceView *)sender
{
    return (self.happiness - 50) / 50.0;
}


- (void) smile:(UIPanGestureRecognizer *)gesture
{
    if (gesture.state == UIGestureRecognizerStateChanged ||
        gesture.state == UIGestureRecognizerStateEnded) {
        
        self.happiness += ([gesture translationInView:self.faceview].y / 2);
        [gesture setTranslation:CGPointMake(0, 0) inView:self.faceview];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
