//
//  BadTimerViewController.h
//  TimerDebug
//
//  Created by Hiren on 4/15/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface BadTimerViewController : UIViewController {
    
}

@property (nonatomic, retain) IBOutlet UILabel *timer1Label;
@property (nonatomic, retain) IBOutlet UILabel *timer2Label;

@property (nonatomic, retain) NSTimer *oneSecTimer;
@property (nonatomic, retain) NSTimer *halfSecTimer;

@property (nonatomic, assign) int count1;
@property (nonatomic, assign) int count2;

-(void) createTimer:(NSTimer *)timer withTimeInterval:(NSTimeInterval)timeInterval selector:(SEL)aSelector repeats:(BOOL)repeat;
-(void) oneSecondRepeatingTimer; 
-(void) halfSecondRepeatingTimer;
-(void) updateLabel1;
-(void) updateLabel2;
-(IBAction) startButtonPressed:(id) sender;
-(IBAction) stopButtonPressed:(id) sender;

@end
