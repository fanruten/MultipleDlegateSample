//
//  NSInvocation+PTCUtils.m
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 27/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import "NSInvocation+PTCUtils.h"

@implementation NSInvocation (PTCUtils)

- (instancetype)copy
{
	NSInvocation *copy = [NSInvocation invocationWithMethodSignature:[self methodSignature]];
	NSUInteger argCount = [[self methodSignature] numberOfArguments];
	
    for (int i = 0; i < argCount; i++)
	{
        const char *argType = [[self methodSignature] getArgumentTypeAtIndex:i];
        NSUInteger size;
        NSGetSizeAndAlignment(argType, &size, NULL);
        char buffer[size];
		[self getArgument:(void *)&buffer atIndex:i];
		[copy setArgument:(void *)&buffer atIndex:i];
	}
    
	return copy;
}

@end
