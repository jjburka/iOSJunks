//
//  UIButton+Blocks.h
//  iOSControls
//
//  Created by James Burka on 2/7/13.
//  Copyright (c) 2013 James Burka. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Blocks)

- (void) removeBlocksForControlEvents:(UIControlEvents)controlEvents;

- (void) forControlEvents:(UIControlEvents)controlEvents addAction:(void (^)(id,id))block;

@end
