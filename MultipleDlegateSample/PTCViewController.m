//
//  PTCViewController.m
//  MultipleDlegateSample
//
//  Created by Ruslan Gumennyi on 26/06/14.
//  Copyright (c) 2014 e-legion. All rights reserved.
//

#import "PTCViewController.h"

@interface PTCViewController () <UITextFieldDelegate>

@end

@implementation PTCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}

@end
