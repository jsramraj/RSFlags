//
//  PhoneViewController.m
//  Flags
//
//  Created by Suresh T on 17/04/15.
//  Copyright (c) 2015 Ramaraj. All rights reserved.
//

#import "PhoneViewController.h"
#import "UIImage+Flags.h"

@interface PhoneViewController ()
{
    NSArray *countries;
}
@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CountriesList" withExtension:@"json"]];
    NSError *error = nil;
    countries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

    phoneNumberField.leftViewMode = UITextFieldViewModeAlways;
    phoneNumberField.leftView = redView;
    [flagImageView setImage:[UIImage flagForCountryCode:@"US"]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"%@", textField.text);
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
