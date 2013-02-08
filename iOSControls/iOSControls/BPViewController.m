//
//  BPViewController.m
//  iOSControls
//
//  Created by James Burka on 2/7/13.
//  Copyright (c) 2013 James Burka. All rights reserved.
//

#import "BPViewController.h"
#import "UIControl+Blocks.h"

@interface BPViewController ()

@property (nonatomic,strong) NSOperationQueue *operationQueue;

@end

@implementation BPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	UIButton *aButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
	[aButton setFrame:CGRectMake(50, 50, 100, 100)];
	[aButton setTitle:@"here" forState:UIControlStateNormal];
	[aButton forControlEvents:UIControlEventTouchUpInside addAction:^(UIButton *control,UIEvent *event) {
		NSLog(@"here");
	}];
	[aButton removeBlocksForControlEvents:UIControlEventTouchUpInside];
	[aButton forControlEvents:UIControlEventTouchUpInside addAction:^(UIButton *control,UIEvent *event) {
		NSLog(@"other");
	}];
	[aButton addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];

	
	[self.view addSubview:aButton];
	// Do any additional setup after loading the view, typically from a nib.
}


- (void) action {
	NSLog(@"action");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
