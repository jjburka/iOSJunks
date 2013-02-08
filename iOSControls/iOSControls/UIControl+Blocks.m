//
//  UIButton+Blocks.m
//  iOSControls
//
//  Created by James Burka on 2/7/13.
//  Copyright (c) 2013 James Burka. All rights reserved.
//

#import "UIControl+Blocks.h"
#import <objc/runtime.h>

static NSString *kBlocksAddedSelectors = @"kBlocksAddedSelectors";

@implementation UIControl (Blocks)


- (void) forControlEvents:(UIControlEvents)controlEvents addAction:(void (^)(id,id))block {
	
	// add property to store added selectors
	NSMutableSet *addedSelectors = objc_getAssociatedObject(self, (__bridge const void *)(kBlocksAddedSelectors));
	if (!addedSelectors) {
		objc_setAssociatedObject(self, (__bridge const void *)(kBlocksAddedSelectors), [NSMutableSet set], OBJC_ASSOCIATION_RETAIN);
		addedSelectors = objc_getAssociatedObject(self, (__bridge const void *)(kBlocksAddedSelectors));
	}
	
	// turn block into method implementation
	IMP blockMethod = imp_implementationWithBlock(block);
	
	// create selector string based on control events and block reference (not sure if this is safe)
	NSString *selectorString = [NSString stringWithFormat:@"event(%ul)block(%i)action:forEvent",controlEvents,(int)block];
	SEL selectorMethod = NSSelectorFromString(selectorString);
	
	// add method
	NSAssert(class_addMethod([self class], selectorMethod, blockMethod,"v@:@@"),@"Can't create method :(");
	[self addTarget:self action:selectorMethod forControlEvents:controlEvents];
	[addedSelectors addObject:selectorString];
}

- (void) removeBlocksForControlEvents:(UIControlEvents)controlEvents {
	NSMutableSet *addedSelectors = objc_getAssociatedObject(self, (__bridge const void *)(kBlocksAddedSelectors));
	NSMutableSet *attachedSelectors =[NSMutableSet setWithArray:[self actionsForTarget:self forControlEvent:controlEvents]];
	
	// get the added block selectors that are in the control event array
	[attachedSelectors unionSet:addedSelectors];
	for (NSString *addedSelector in attachedSelectors) {
		[self removeTarget:self action:NSSelectorFromString(addedSelector) forControlEvents:controlEvents];
		[addedSelectors removeObject:addedSelector];
		// remove selector block
		imp_removeBlock(class_getMethodImplementation([self class],NSSelectorFromString(addedSelector)));
	}
}


@end
