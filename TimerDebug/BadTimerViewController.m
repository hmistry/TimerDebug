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
@synthesize halfSecTimer;

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
    [halfSecTimer release];
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

-(void) halfSecondRepeatingTimer { 
    [self createTimer:self.halfSecTimer withTimeInterval:0.5 selector:@selector(updateLabel2) repeats:YES];    
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
    [self halfSecondRepeatingTimer];
}

-(IBAction) stopButtonPressed:(id) sender {
    [self invalidateTimer:self.oneSecTimer];
    [self invalidateTimer:self.halfSecTimer];
}

@end
