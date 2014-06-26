//
//  PTCMultipleDelegate.m
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//
#import "PTCMultipleDelegate.h"

#import "PTCUtils.h"
#import "NSInvocation+PTCUtils.h"

@interface PTCMultipleDelegate ()

@property (nonatomic, weak) id mainDelegate;
@property (nonatomic, strong) NSPointerArray *delegates;

@end

@implementation PTCMultipleDelegate

+ (instancetype)newProxyForMainDelegate:(id)mainDelegate
                              delegates:(NSArray *)delegates
                mainDelegateIsDelegator:(BOOL)mainDelegateIsDelegator;
{
    return [[self alloc] initProxyMainDelegate:mainDelegate
                                     delegates:delegates
                       mainDelegateIsDelegator:mainDelegateIsDelegator];
}

- (instancetype)initProxyMainDelegate:(id)mainDelegate
                            delegates:(NSArray *)delegates
              mainDelegateIsDelegator:(BOOL)mainDelegateIsDelegator
{
    _mainDelegateIsDelegator = mainDelegateIsDelegator;
    _mainDelegate = mainDelegate;
    _delegates = [NSPointerArray weakObjectsPointerArray];
    [delegates enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [_delegates addPointer:(__bridge void *)obj];
    }];
    return self;
}

- (BOOL)shouldCallMainDelegateForSelector:(SEL)aSelector
{
    if ([self.mainDelegate respondsToSelector:aSelector]) {
        if (self.mainDelegateIsDelegator) {
            if (SelectorOverridenInSubclass([self.mainDelegate class], aSelector)) {
                return YES;
            }
        } else {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    if ([self shouldCallMainDelegateForSelector:aSelector]) {
        return YES;
    }

    for (id delegate in self.delegates) {
		if ([delegate respondsToSelector:aSelector]) {
			return YES;
        }
    }
    
    return NO;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [[self.mainDelegate class] instanceMethodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation
{
    BOOL isMethodReturnSomething = (![[NSString stringWithCString:invocation.methodSignature.methodReturnType
                                                         encoding:NSUTF8StringEncoding]
                                      isEqualToString:@"v"]);
    
	if ([self shouldCallMainDelegateForSelector:invocation.selector]) {
		[invocation invokeWithTarget:self.mainDelegate];
    }
	
	NSInvocation *targetInvocation = invocation;
	if (isMethodReturnSomething) {
		targetInvocation = [invocation copy];
	}
	
	for (id delegate in self.delegates) {
		if ([delegate respondsToSelector:invocation.selector]) {
			[targetInvocation invokeWithTarget:delegate];
        }
    }
}

@end
