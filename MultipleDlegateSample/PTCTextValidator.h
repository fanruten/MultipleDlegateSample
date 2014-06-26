//
//  PTCTextValidator.h
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol PTCTextValidator <NSObject>

- (BOOL)textIsValid:(NSString *)text;
- (BOOL)textLengthIsValid:(NSString *)text;

@end
