//
//  PTCVerifiableTextField.m
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import "PTCVerifiableTextField.h"

#import "PTCMultipleDelegate.h"

@interface PTCVerifiableTextField () <UITextFieldDelegate>

@property (nonatomic, assign) BOOL isValid;
@property (nonatomic, strong) id<UITextFieldDelegate> customDelegate;

@end

@implementation PTCVerifiableTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    [self setDelegate:nil];
    
    self.isValid = NO;
    
    _validTextColor = [UIColor blueColor];
    _invalidTextColor = [UIColor redColor];
    
    [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingChanged];
    [self addTarget:self action:@selector(textFieldDidChange) forControlEvents:UIControlEventEditingDidEnd];
    
    [self textFieldDidChange];
}

- (void)setDelegate:(id<UITextFieldDelegate>)delegate
{
    NSArray *additionalDelegates = delegate ? @[delegate] : nil;
    self.customDelegate = (id<UITextFieldDelegate>)[PTCMultipleDelegate newProxyForMainDelegate:self
                                                                                      delegates:additionalDelegates
                                                                                   mainDelegateIsDelegator:YES];
    [super setDelegate:self.customDelegate];
}

- (UIColor *)textColorForCurrentState
{
    return self.isValid ? self.validTextColor : self.invalidTextColor;
}

-(void)textFieldDidChange
{
    self.isValid = self.validator == nil || ([self.validator textIsValid:self.text] && [self.validator textLengthIsValid:self.text]);
    self.textColor = [self textColorForCurrentState];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    BOOL isValidLength = self.validator == nil || [self.validator textLengthIsValid:newString];
    return isValidLength;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.textColor = [self textColorForCurrentState];    
}

@end
