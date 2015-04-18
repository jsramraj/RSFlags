//
//  PhoneViewController.m
//  Flags
//
//  Created by Suresh T on 17/04/15.
//  Copyright (c) 2015 Ramaraj. All rights reserved.
//

#import "PhoneViewController.h"
#import "UIImage+RSFlags.h"

@interface PhoneViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
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
    countries = [countries sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1[@"name"] compare:obj2[@"name"] options:NSCaseInsensitiveSearch];
    }];

    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }

    phoneNumberField.leftViewMode = UITextFieldViewModeAlways;
    phoneNumberField.leftView = redView;
    [flagImageView setImage:[UIImage flagForCountryCode:@"US"]];
    
    UIPickerView *picker = [[UIPickerView alloc] init];
    [picker setDataSource:self];
    [picker setDelegate:self];
    [countryField setInputView:picker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [flagImageView setImage:nil];
    if (textField.text && ![string isEqualToString:@""]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.dial_code LIKE %@", [textField.text stringByAppendingString:string]];
        NSArray *filetered = [countries filteredArrayUsingPredicate:predicate];
        if (filetered && [filetered count]>0) {
            CATransition *transition = [CATransition animation];
            transition.duration = 1.0f;
            transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
            transition.type = kCATransitionFromTop;
            
            [flagImageView setImage:[UIImage flagForCountryCode:filetered[0][@"code"]]];
//            [flagImageView.layer addAnimation:transition forKey:nil];
        }
    }
    return YES;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (!view)
    {
        //Custom view creation code is copied from
        //https://github.com/nicklockwood/CountryPicker/blob/master/CountryPicker/CountryPicker.m
        
        view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 280, 30)];
        
        UILabel *countryName = [[UILabel alloc] initWithFrame:CGRectMake(35, 3, 245, 24)];
        countryName.backgroundColor = [UIColor clearColor];
        countryName.tag = 1;
        [view addSubview:countryName];
        
        UIImageView *flagImage = [[UIImageView alloc] initWithFrame:CGRectMake(3, 9, 16, 11)];
        flagImage.contentMode = UIViewContentModeScaleAspectFit;
        flagImage.tag = 2;
        [view addSubview:flagImage];
    }
    NSDictionary *country = countries[row];
    ((UILabel *)[view viewWithTag:1]).text = country[@"name"];
    ((UIImageView *)[view viewWithTag:2]).image = [UIImage flagForCountryCode:country[@"code"]];
    return view;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [countries count];
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
