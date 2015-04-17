//
//  ViewController.m
//  Flags
//
//  Created by Ramaraj Thanga Pandi on 08/12/14.
//  Copyright (c) 2014 Ramaraj. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

static inline CGRect CGRectMultiply(CGRect rect, CGFloat factor)
{
    return CGRectMake(rect.origin.x*factor, rect.origin.y*factor, rect.size.width*factor, rect.size.height*factor);
}

- (void)viewDidLoad {
    
    NSLog(@"Flag has been loaded");
    
    const char char1 = *[@"I" UTF8String];
    int index1 = char1 - 64;
    NSLog(@"%d", index1);

    const char char2 = *[@"N" UTF8String];
    int index2 = char2 - 64;
    NSLog(@"%d", index2);
    
//    CGRect fromRect = CGRectMake(32, 18, 32, 22);
//    CGRect fromRect = CGRectMake(index1*32, index2*22, 32, 22);
    UIImage *origImage = [UIImage imageWithCGImage:[UIImage imageNamed:@"WorldFlags"].CGImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    
    CGRect fromRect = CGRectMake(index1*16, index2*11, 16, 11);
    fromRect = CGRectMultiply(fromRect, [UIScreen mainScreen].scale);
    CGImageRef drawImage = CGImageCreateWithImageInRect(origImage.CGImage, fromRect);
    UIImage *newImage = [UIImage imageWithCGImage:drawImage scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp];
    CGImageRelease(drawImage);

    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 50, 16, 11)];
//    [imageView setBackgroundColor:[UIColor redColor]];
    [imageView setContentMode:UIViewContentModeScaleAspectFit];
    [imageView setImage:newImage];
    [self.view addSubview:imageView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
