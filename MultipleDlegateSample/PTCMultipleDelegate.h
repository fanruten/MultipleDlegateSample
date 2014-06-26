//
//  PTCMultipleDelegate.h
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTCMultipleDelegate : NSProxy

@property (nonatomic, weak, readonly) id mainDelegate;
@property (nonatomic, strong, readonly) NSPointerArray *delegates;
@property (nonatomic, assign, readonly) BOOL mainDelegateIsDelegator;

+ (instancetype)newProxyForMainDelegate:(id)mainDelegate
                              delegates:(NSArray *)delegates
                mainDelegateIsDelegator:(BOOL)mainDelegateIsDelegator;

@end
