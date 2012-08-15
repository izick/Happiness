//
//  HappinessViewController.m
//  Happiness
//
//  Created by Tony Scarpino on 8/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController()

@property (nonatomic, weak) IBOutlet UIView *faceview;
@end

@implementation HappinessViewController
@synthesize faceview = _faceview;
@synthesize happiness = _happiness;

/*
 - (void)setHappiness:(int)happiness
{
    _happiness = happiness;
    [self.faceview setNeedsDisplay];
}
*/

- (void)setFaceview:(FaceView *)faceview
{
    _faceview = faceview;
    [self.faceview addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.faceview action:@selector(pinch:)]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}
@end
