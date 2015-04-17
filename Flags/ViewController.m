//
//  ViewController.m
//  Flags
//
//  Created by Ramaraj Thanga Pandi on 08/12/14.
//  Copyright (c) 2014 Ramaraj. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Flags.h"

@interface ViewController ()
{
    NSArray *countries;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    //@Keeguon, Thanks you, for the country list
    //https://gist.github.com/Keeguon/2310008

    NSData *data = [NSData dataWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"CountriesList" withExtension:@"json"]];
    NSError *error = nil;
    countries = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        NSLog(@"%@", [error localizedDescription]);
    }
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [countries count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *country = countries[indexPath.row];
    
    UITableViewCell *cell   =   [tableView dequeueReusableCellWithIdentifier:@"MyCell"];
    cell.textLabel.text     =   country[@"name"];
    cell.detailTextLabel.text=  country[@"code"];
    cell.imageView.image    =   [UIImage flagForCountryCode:country[@"code"]];
    return cell;
}

@end
