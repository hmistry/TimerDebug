//
//  GoodTimerViewController.m
//  TimerDebug
//
//  Created by Hiren on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GoodTimerViewController.h"


@implementation GoodTimerViewController

@synthesize oneSecTimer;
@synthesize twoSecTimer;

@synthesize timer1Label;
@synthesize timer2Label;
@synthesize count1, count2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [oneSecTimer release];
    [twoSecTimer release];
    [timer1Label release];
    [timer2Label release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.timer1Label.text = @"0 sec";
    self.timer2Label.text = @"0 sec";
    count1 = 0;
    count2 = 0;
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void) invalidateTimer:(NSTimer *)timer {
    [timer invalidate];
    timer = nil;
}

-(void) oneSecondRepeatingTimer { 
    // Get current runloop
	NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
	
    // Invalidate previously set NSTimer
    [self invalidateTimer:self.oneSecTimer];
    
    // Create new NSTimer
	self.oneSecTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                        target:self
                                                      selector:@selector(updateLabel1)
                                                      userInfo:nil
                                                       repeats:YES];
    // Add NSTimer to runloop
	[runLoop addTimer:self.oneSecTimer forMode:NSDefaultRunLoopMode];    
}

-(void) twoSecondRepeatingTimer { 
    // Get current runloop
	NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
	
    // Invalidate previously set NSTimer
    [self invalidateTimer:self.twoSecTimer];
    
    // Create new NSTimer
	self.twoSecTimer = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                        target:self
                                                      selector:@selector(updateLabel2)
                                                      userInfo:nil
                                                       repeats:YES];
    // Add NSTimer to runloop
	[runLoop addTimer:self.twoSecTimer forMode:NSDefaultRunLoopMode];    
}

-(void) updateLabel1 {
    count1++;
    self.timer1Label.text = [NSString stringWithFormat:@"%d sec", count1];
}


-(void) updateLabel2 {
    count2++;
    self.timer2Label.text = [NSString stringWithFormat:@"%d sec", count2];
}

-(IBAction) startButtonPressed:(id) sender {
    count1 = 0;
    count2 = 0;

    self.timer1Label.text = @"0 sec";
    self.timer2Label.text = @"0 sec";

    [self oneSecondRepeatingTimer];
    [self twoSecondRepeatingTimer];
}

-(IBAction) stopButtonPressed:(id) sender {
    [self invalidateTimer:self.oneSecTimer];
    [self invalidateTimer:self.twoSecTimer];
}

@end
