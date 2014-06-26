//
//  PTCNameValidator.m
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import "PTCNameValidator.h"

@implementation PTCNameValidator

- (BOOL)textIsValid:(NSString *)text
{
    NSCharacterSet *alphaSet = [NSCharacterSet letterCharacterSet];
    return text.length && ([text stringByTrimmingCharactersInSet:alphaSet].length == 0);
}

- (BOOL)textLengthIsValid:(NSString *)text
{
    return text.length <= 10;
}

@end
