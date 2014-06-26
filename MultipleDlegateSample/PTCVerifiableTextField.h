//
//  PTCVerifiableTextField.h
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PTCTextValidator.h"

@interface PTCVerifiableTextField : UITextField

@property (nonatomic, weak) IBOutlet id<PTCTextValidator> validator;
@property (nonatomic, strong) UIColor *validTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *invalidTextColor UI_APPEARANCE_SELECTOR;

@property (nonatomic, readonly) BOOL isValid;

@end
