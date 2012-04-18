//
//  BadTimerViewController.m
//  TimerDebug
//
//  Created by Hiren on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BadTimerViewController.h"


@implementation BadTimerViewController

@synthesize oneSecTimer;
@synthesize twoSecTimer;

@synthesize timer1Label;
@synthesize timer2Label;
@synthesize zeroTimestamp;

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
    [zeroTimestamp release];
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
    self.timer1Label.text = @"0.0 sec";
    self.timer2Label.text = @"0.0 sec";
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

-(void) createTimer:(NSTimer *)timer withTimeInterval:(NSTimeInterval)timeInterval selector:(SEL)aSelector repeats:(BOOL)repeat {
    // Get current runloop
	NSRunLoop* runLoop = [NSRunLoop currentRunLoop];
	
    // Invalidate previously set NSTimer
    [self invalidateTimer:timer];
    
    // Create new NSTimer
	timer = [NSTimer scheduledTimerWithTimeInterval:timeInterval
                                             target:self
                                           selector:aSelector
                                           userInfo:nil
                                            repeats:repeat];
    // Add NSTimer to runloop
	[runLoop addTimer:timer forMode:NSDefaultRunLoopMode];    
}

-(void) oneSecondRepeatingTimer {     
    [self createTimer:self.oneSecTimer withTimeInterval:1.0 selector:@selector(updateLabel1) repeats:YES];    
}

-(void) twoSecondRepeatingTimer { 
    [self createTimer:self.twoSecTimer withTimeInterval:0.1 selector:@selector(updateLabel2) repeats:YES];    
}

-(void) updateLabel1 {
    self.timer1Label.text = [NSString stringWithFormat:@"%.1f sec", [[NSDate date] timeIntervalSinceDate:self.zeroTimestamp]];
}


-(void) updateLabel2 {
    self.timer2Label.text = [NSString stringWithFormat:@"%.1f sec", [[NSDate date] timeIntervalSinceDate:self.zeroTimestamp]];
}

-(IBAction) startButtonPressed:(id) sender {
    self.zeroTimestamp = [NSDate date];
    
    self.timer1Label.text = @"0.0 sec";
    self.timer2Label.text = @"0.0 sec";
    
//    [self oneSecondRepeatingTimer];
    [self twoSecondRepeatingTimer];
}

-(IBAction) stopButtonPressed:(id) sender {
    self.zeroTimestamp = nil;
//    [self invalidateTimer:self.oneSecTimer];
    [self invalidateTimer:self.twoSecTimer];
}

@end
