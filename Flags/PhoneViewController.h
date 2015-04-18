//
//  PhoneViewController.h
//  Flags
//
//  Created by Suresh T on 17/04/15.
//  Copyright (c) 2015 Ramaraj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneViewController : UIViewController
{
    
    __weak IBOutlet UITextField *phoneNumberField;
    __weak IBOutlet UITextField *countryField;
    __weak IBOutlet UIView *redView;
    __weak IBOutlet UIImageView *flagImageView;
    
}


@end
