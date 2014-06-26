//
//  PTCUtils.m
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 27/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import "PTCUtils.h"

#import <objc/runtime.h>


BOOL SelectorOverridenInSubclass(Class subclass, SEL aSelecor)
{
    if (method_getImplementation(class_getInstanceMethod(subclass, aSelecor)) !=
        method_getImplementation(class_getInstanceMethod(class_getSuperclass(subclass), aSelecor))) {
        return YES;
    } else {
        return NO;
    }
}

